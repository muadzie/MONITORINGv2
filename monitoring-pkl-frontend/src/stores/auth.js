import { defineStore } from 'pinia'
import axios from '../plugins/axios'

export const useAuthStore = defineStore('auth', {
  state: () => ({
    user: null,
    token: localStorage.getItem('token'),
    role: localStorage.getItem('role')
  }),

  getters: {
    isAuthenticated: (state) => !!state.token,
  },

  actions: {
    async login(credentials) {
      try {
        const response = await axios.post('/login', credentials)
        const { user, token, role } = response.data
        
        this.user = user
        this.token = token
        this.role = role
        
        localStorage.setItem('token', token)
        localStorage.setItem('role', role)
        axios.defaults.headers.common['Authorization'] = `Bearer ${token}`
        
        return response.data
      } catch (error) {
        throw error
      }
    },

    async logout() {
      try {
        await axios.post('/logout')
      } catch (error) {}
      finally {
        this.user = null
        this.token = null
        this.role = null
        localStorage.removeItem('token')
        localStorage.removeItem('role')
        delete axios.defaults.headers.common['Authorization']
      }
    },

    async checkAuth() {
      const token = localStorage.getItem('token')
      if (!token) return false
      
      this.token = token
      axios.defaults.headers.common['Authorization'] = `Bearer ${token}`
      
      try {
        const response = await axios.get('/me')
        this.user = response.data
        this.role = response.data.role?.name
        localStorage.setItem('role', this.role)
        return true
      } catch (error) {
        this.logout()
        return false
      }
    }
  }
})