<template>
  <div class="space-y-6">
    <div class="flex justify-between items-center">
      <h1 class="text-2xl font-bold text-gray-800">Manajemen User</h1>
      <button @click="openModal" class="bg-indigo-600 text-white px-4 py-2 rounded-lg hover:bg-indigo-700 transition">
        + Tambah User
      </button>
    </div>

    <!-- Table -->
    <div class="bg-white rounded-xl shadow-sm overflow-hidden">
      <div class="overflow-x-auto">
        <table class="w-full">
          <thead class="bg-gray-50">
            <tr>
              <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600">Nama</th>
              <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600">Email</th>
              <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600">Role</th>
              <th class="px-6 py-3 text-left text-xs font-semibold text-gray-600">Aksi</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-100">
            <tr v-for="user in users" :key="user.id" class="hover:bg-gray-50">
              <td class="px-6 py-4 text-sm font-medium">{{ user.name }}</td>
              <td class="px-6 py-4 text-sm">{{ user.email }}</td>
              <td class="px-6 py-4">
                <span :class="getRoleClass(user.role)" class="px-2 py-1 rounded-full text-xs font-medium">
                  {{ user.role }}
                </span>
              </td>
              <td class="px-6 py-4 space-x-2">
                <button @click="editUser(user)" class="text-indigo-600 hover:text-indigo-800 text-sm">Edit</button>
                <button @click="deleteUser(user)" class="text-red-600 hover:text-red-800 text-sm">Hapus</button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Modal -->
    <div v-if="showModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
      <div class="bg-white rounded-xl p-6 w-full max-w-md">
        <h2 class="text-xl font-bold mb-4">{{ isEdit ? 'Edit User' : 'Tambah User' }}</h2>
        
        <form @submit.prevent="saveUser">
          <div class="mb-3">
            <label class="block text-sm font-medium mb-1">Nama</label>
            <input v-model="form.name" type="text" class="w-full px-3 py-2 border rounded-lg" required>
          </div>
          
          <div class="mb-3">
            <label class="block text-sm font-medium mb-1">Email</label>
            <input v-model="form.email" type="email" class="w-full px-3 py-2 border rounded-lg" required>
          </div>
          
          <div class="mb-3">
            <label class="block text-sm font-medium mb-1">Role</label>
            <select v-model="form.role_id" class="w-full px-3 py-2 border rounded-lg" required>
              <option value="">Pilih Role</option>
              <option :value="1">Admin</option>
              <option :value="2">Siswa</option>
              <option :value="3">Guru</option>
              <option :value="4">Perusahaan</option>
            </select>
          </div>
          
          <div class="mb-4">
            <label class="block text-sm font-medium mb-1">Password</label>
            <input v-model="form.password" type="password" class="w-full px-3 py-2 border rounded-lg" :required="!isEdit">
            <p v-if="isEdit" class="text-xs text-gray-500 mt-1">Kosongkan jika tidak ingin mengubah password</p>
          </div>
          
          <div class="flex justify-end space-x-2">
            <button type="button" @click="showModal = false" class="px-4 py-2 border rounded-lg hover:bg-gray-50">Batal</button>
            <button type="submit" class="px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700">Simpan</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import axios from '../../plugins/axios'
import { useToast } from 'vue-toastification'

const toast = useToast()
const users = ref([])
const showModal = ref(false)
const isEdit = ref(false)
const form = ref({ id: null, name: '', email: '', role_id: '', password: '' })

const getRoleClass = (role) => {
  const classes = {
    Admin: 'bg-red-100 text-red-800',
    Guru: 'bg-blue-100 text-blue-800',
    Siswa: 'bg-green-100 text-green-800',
    Perusahaan: 'bg-purple-100 text-purple-800'
  }
  return classes[role] || 'bg-gray-100 text-gray-800'
}

const fetchUsers = async () => {
  try {
    const res = await axios.get('/admin/users')
    users.value = res.data
    console.log('Users loaded:', users.value)
  } catch (error) {
    console.error('Error fetching users:', error)
    toast.error('Gagal memuat data user')
  }
}

const openModal = () => {
  isEdit.value = false
  form.value = { id: null, name: '', email: '', role_id: '', password: '' }
  showModal.value = true
}

const editUser = (user) => {
  isEdit.value = true
  form.value = {
    id: user.id,
    name: user.name,
    email: user.email,
    role_id: user.role_id,
    password: ''
  }
  showModal.value = true
}

const saveUser = async () => {
  try {
    if (isEdit.value) {
      await axios.put(`/admin/users/${form.value.id}`, form.value)
      toast.success('User berhasil diupdate')
    } else {
      await axios.post('/admin/users', form.value)
      toast.success('User berhasil ditambahkan')
    }
    showModal.value = false
    fetchUsers()
  } catch (error) {
    console.error('Error saving user:', error)
    toast.error(error.response?.data?.message || 'Gagal menyimpan user')
  }
}

const deleteUser = async (user) => {
  if (confirm(`Apakah Anda yakin ingin menghapus user "${user.name}"?`)) {
    try {
      await axios.delete(`/admin/users/${user.id}`)
      toast.success('User berhasil dihapus')
      fetchUsers()
    } catch (error) {
      console.error('Error deleting user:', error)
      toast.error('Gagal menghapus user')
    }
  }
}

onMounted(() => {
  fetchUsers()
})
</script>