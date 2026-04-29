<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
      <div>
        <h1 class="text-2xl font-bold text-gray-800">Manajemen User</h1>
        <p class="text-gray-500 mt-1">Kelola semua pengguna sistem</p>
      </div>
      <button 
        @click="openModal" 
        class="bg-gradient-to-r from-indigo-600 to-purple-600 text-white px-5 py-2.5 rounded-xl hover:shadow-lg transition-all duration-300 hover:scale-105 flex items-center gap-2"
      >
        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
        </svg>
        Tambah User
      </button>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
      <div class="bg-gradient-to-br from-indigo-500 to-indigo-700 rounded-xl p-5 text-white shadow-lg hover:shadow-xl transition-all duration-300">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Total User</p>
            <p class="text-3xl font-bold mt-1">{{ pagination.total }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path>
            </svg>
          </div>
        </div>
      </div>
      <div class="bg-gradient-to-br from-green-500 to-green-700 rounded-xl p-5 text-white shadow-lg hover:shadow-xl transition-all duration-300">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Aktif</p>
            <p class="text-3xl font-bold mt-1">{{ users.filter(u => u.is_active !== false).length }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
            </svg>
          </div>
        </div>
      </div>
      <div class="bg-gradient-to-br from-yellow-500 to-yellow-700 rounded-xl p-5 text-white shadow-lg hover:shadow-xl transition-all duration-300">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Nonaktif</p>
            <p class="text-3xl font-bold mt-1">{{ users.filter(u => u.is_active === false).length }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
            </svg>
          </div>
        </div>
      </div>
      <div class="bg-gradient-to-br from-purple-500 to-purple-700 rounded-xl p-5 text-white shadow-lg hover:shadow-xl transition-all duration-300">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Role Aktif</p>
            <p class="text-3xl font-bold mt-1">{{ uniqueRoles }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
            </svg>
          </div>
        </div>
      </div>
    </div>

    <!-- Search & Filter -->
    <div class="bg-white rounded-xl shadow-md p-5 border border-gray-100">
      <div class="flex flex-col md:flex-row gap-4">
        <div class="flex-1 relative">
          <svg class="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
          </svg>
          <input 
            v-model="search" 
            type="text" 
            placeholder="Cari user (Nama, Email)..." 
            class="w-full pl-10 pr-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
            @keyup.enter="fetchUsers"
          >
        </div>
        <select v-model="filters.role" class="px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 bg-white">
          <option value="">📌 Semua Role</option>
          <option value="Admin">👑 Admin</option>
          <option value="Guru">👨‍🏫 Guru</option>
          <option value="Siswa">🎓 Siswa</option>
          <option value="Perusahaan">🏢 Perusahaan</option>
        </select>
        <button @click="resetFilters" class="px-4 py-2.5 text-gray-600 hover:bg-gray-100 rounded-lg transition flex items-center gap-2">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path>
          </svg>
          Reset
        </button>
      </div>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="flex justify-center py-12">
      <div class="text-center">
        <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-indigo-600 mx-auto"></div>
        <p class="mt-4 text-gray-500">Memuat data user...</p>
      </div>
    </div>

    <!-- Error State -->
    <div v-else-if="error" class="bg-red-50 border border-red-200 text-red-700 p-4 rounded-xl flex items-center justify-between">
      <div class="flex items-center gap-3">
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
        </svg>
        <span>{{ error }}</span>
      </div>
      <button @click="fetchUsers" class="px-4 py-2 bg-red-100 text-red-700 rounded-lg hover:bg-red-200 transition">Coba Lagi</button>
    </div>

    <!-- Table -->
    <div v-else-if="filteredUsers.length > 0" class="bg-white rounded-xl shadow-md overflow-hidden border border-gray-100">
      <div class="overflow-x-auto">
        <table class="min-w-[900px] lg:min-w-full bg-white">
          <thead>
            <tr class="bg-gradient-to-r from-indigo-600 to-purple-600">
              <th class="px-4 py-3 text-left text-xs font-semibold text-white uppercase w-12">No</th>
              <th class="px-4 py-3 text-left text-xs font-semibold text-white uppercase w-36">Nama</th>
              <th class="px-4 py-3 text-left text-xs font-semibold text-white uppercase w-44">Email</th>
              <th class="px-4 py-3 text-left text-xs font-semibold text-white uppercase w-28">Role</th>
              <th class="px-4 py-3 text-left text-xs font-semibold text-white uppercase w-32">Tanggal</th>
              <th class="px-4 py-3 text-center text-xs font-semibold text-white uppercase w-20">Aksi</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-100">
            <tr v-for="(user, index) in filteredUsers" :key="user.id" class="hover:bg-gray-50 transition duration-200">
              <td class="px-4 py-3 text-sm text-gray-500 text-center">{{ getRowNumber(index) }}</td>
              <td class="px-4 py-3 font-medium text-gray-800 whitespace-nowrap">
                <div class="flex items-center gap-2">
                  <div class="w-8 h-8 bg-gradient-to-br from-indigo-100 to-purple-100 rounded-full flex items-center justify-center font-bold text-sm shadow-sm" :class="getRoleBgClass(user.role)">
                    {{ user.name?.charAt(0) || 'U' }}
                  </div>
                  {{ user.name }}
                </div>
              </td>
              <td class="px-4 py-3 text-sm text-gray-600 truncate max-w-xs">{{ user.email }}</td>
              <td class="px-4 py-3">
                <span :class="getRoleClass(user.role)" class="inline-flex items-center gap-1 px-2 py-1 rounded-lg text-xs font-medium">
                  <span class="w-1.5 h-1.5 rounded-full" :class="getRoleDotClass(user.role)"></span>
                  {{ user.role }}
                </span>
              </td>
              <td class="px-4 py-3 text-sm text-gray-600 whitespace-nowrap">{{ formatDate(user.created_at) }}</td>
              <td class="px-4 py-3 text-center">
                <div class="flex items-center justify-center gap-2">
                  <button @click="editUser(user)" class="p-1.5 text-indigo-600 hover:bg-indigo-50 rounded-lg transition" title="Edit">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"></path>
                    </svg>
                  </button>
                  <button @click="deleteUser(user)" class="p-1.5 text-red-600 hover:bg-red-50 rounded-lg transition" title="Hapus">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                    </svg>
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
      
      <!-- Pagination -->
      <div class="px-5 py-4 border-t bg-gray-50 flex flex-col md:flex-row justify-between items-center gap-3">
        <span class="text-sm text-gray-500">
          Menampilkan {{ users.length }} dari {{ pagination.total }} user
        </span>
        <div class="flex gap-2">
          <button 
            @click="prevPage" 
            :disabled="pagination.current_page <= 1"
            class="px-4 py-2 border border-gray-300 rounded-lg text-gray-600 hover:bg-gray-100 transition disabled:opacity-50 disabled:cursor-not-allowed flex items-center gap-1"
          >
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round"stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
            </svg>
            Sebelumnya
          </button>
          <span class="px-4 py-2 text-sm font-medium text-gray-700">
            Halaman {{ pagination.current_page }} dari {{ pagination.last_page }}
          </span>
          <button 
            @click="nextPage" 
            :disabled="pagination.current_page >= pagination.last_page"
            class="px-4 py-2 border border-gray-300 rounded-lg text-gray-600 hover:bg-gray-100 transition disabled:opacity-50 disabled:cursor-not-allowed flex items-center gap-1"
          >
            Selanjutnya
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
            </svg>
          </button>
        </div>
      </div>
    </div>

    <!-- Empty State -->
    <div v-else-if="!loading && filteredUsers.length === 0" class="bg-white rounded-xl p-12 text-center">
      <svg class="w-20 h-20 mx-auto text-gray-300 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path>
      </svg>
      <p class="text-gray-500 text-lg">Belum ada data user</p>
      <p class="text-sm text-gray-400 mt-1">Silakan tambahkan user baru</p>
      <button @click="openModal" class="mt-4 px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition">Tambah user pertama</button>
    </div>

    <!-- Modal Tambah/Edit User -->
    <div v-if="showModal" class="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50" @click.self="closeModal">
      <div class="bg-white rounded-2xl w-full max-w-md max-h-[90vh] overflow-y-auto animate-fade-in-up shadow-2xl">
        <div class="sticky top-0 bg-white p-5 border-b rounded-t-2xl">
          <div class="flex justify-between items-center">
            <div class="flex items-center gap-3">
              <div class="w-10 h-10 bg-gradient-to-br from-indigo-600 to-purple-600 rounded-xl flex items-center justify-center shadow-lg">
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path>
                </svg>
              </div>
              <div>
                <h3 class="text-xl font-bold text-gray-800">{{ isEdit ? 'Edit User' : 'Tambah User' }}</h3>
                <p class="text-sm text-gray-500">{{ isEdit ? 'Ubah data user' : 'Masukkan data user baru' }}</p>
              </div>
            </div>
            <button @click="closeModal" class="text-gray-400 hover:text-gray-600 transition">
              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
              </svg>
            </button>
          </div>
        </div>

        <form @submit.prevent="saveUser" class="p-6 space-y-4">
          <div>
            <label class="block text-sm font-semibold text-gray-700 mb-1">Nama Lengkap <span class="text-red-500">*</span></label>
            <input v-model="form.name" type="text" class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent" placeholder="Masukkan nama lengkap" required>
          </div>
          
          <div>
            <label class="block text-sm font-semibold text-gray-700 mb-1">Email <span class="text-red-500">*</span></label>
            <input v-model="form.email" type="email" class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent" placeholder="user@example.com" required>
          </div>
          
          <div>
            <label class="block text-sm font-semibold text-gray-700 mb-1">Role <span class="text-red-500">*</span></label>
            <select v-model="form.role_id" class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent bg-white" required>
              <option value="">📌 Pilih Role</option>
              <option :value="1">👑 Admin</option>
              <option :value="2">🎓 Siswa</option>
              <option :value="3">👨‍🏫 Guru</option>
              <option :value="4">🏢 Perusahaan</option>
            </select>
          </div>
          
          <div>
            <label class="block text-sm font-semibold text-gray-700 mb-1">Password <span v-if="!isEdit" class="text-red-500">*</span></label>
            <input v-model="form.password" type="password" class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent" :required="!isEdit" placeholder="Minimal 6 karakter">
            <p v-if="isEdit" class="text-xs text-gray-500 mt-1">Kosongkan jika tidak ingin mengubah password</p>
          </div>

          <div class="flex justify-end gap-3 pt-4 border-t">
            <button type="button" @click="closeModal" class="px-5 py-2.5 border border-gray-300 rounded-lg hover:bg-gray-50 transition font-medium">Batal</button>
            <button type="submit" class="px-6 py-2.5 bg-gradient-to-r from-indigo-600 to-purple-600 text-white rounded-lg hover:shadow-lg transition-all font-medium" :disabled="saving">
              {{ saving ? 'Menyimpan...' : (isEdit ? 'Update' : 'Simpan') }}
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import axios from '../../plugins/axios'
import { useToast } from 'vue-toastification'

const toast = useToast()

// State
const users = ref([])
const loading = ref(true)
const saving = ref(false)
const error = ref('')
const showModal = ref(false)
const isEdit = ref(false)
const currentPage = ref(1)
const search = ref('')
const filters = ref({ role: '' })

const pagination = ref({
  current_page: 1,
  last_page: 1,
  total: 0
})

const form = ref({ 
  id: null, 
  name: '', 
  email: '', 
  role_id: '', 
  password: '' 
})

// Computed
const filteredUsers = computed(() => {
  let result = users.value
  
  if (search.value) {
    const searchLower = search.value.toLowerCase()
    result = result.filter(u => 
      u.name?.toLowerCase().includes(searchLower) ||
      u.email?.toLowerCase().includes(searchLower)
    )
  }
  
  if (filters.value.role) {
    result = result.filter(u => u.role === filters.value.role)
  }
  
  return result
})

const uniqueRoles = computed(() => {
  const roles = [...new Set(users.value.map(u => u.role).filter(Boolean))]
  return roles.length
})

// Helper functions
const getRowNumber = (index) => {
  return ((pagination.value.current_page - 1) * 10) + index + 1
}

const formatDate = (date) => {
  if (!date) return '-'
  return new Date(date).toLocaleDateString('id-ID', { day: 'numeric', month: 'short', year: 'numeric' })
}

const getRoleClass = (role) => {
  const classes = {
    Admin: 'bg-red-100 text-red-700',
    Guru: 'bg-blue-100 text-blue-700',
    Siswa: 'bg-green-100 text-green-700',
    Perusahaan: 'bg-purple-100 text-purple-700'
  }
  return classes[role] || 'bg-gray-100 text-gray-700'
}

const getRoleBgClass = (role) => {
  const classes = {
    Admin: 'bg-red-100 text-red-600',
    Guru: 'bg-blue-100 text-blue-600',
    Siswa: 'bg-green-100 text-green-600',
    Perusahaan: 'bg-purple-100 text-purple-600'
  }
  return classes[role] || 'bg-gray-100 text-gray-600'
}

const getRoleDotClass = (role) => {
  const classes = {
    Admin: 'bg-red-500',
    Guru: 'bg-blue-500',
    Siswa: 'bg-green-500',
    Perusahaan: 'bg-purple-500'
  }
  return classes[role] || 'bg-gray-500'
}

// Fetch data
const fetchUsers = async () => {
  loading.value = true
  error.value = ''
  try {
    const res = await axios.get(`/admin/users?page=${currentPage.value}`)
    users.value = res.data.data || []
    pagination.value = {
      current_page: res.data.current_page || 1,
      last_page: res.data.last_page || 1,
      total: res.data.total || 0
    }
  } catch (err) {
    error.value = err.response?.data?.message || 'Gagal memuat data'
    toast.error(error.value)
  } finally {
    loading.value = false
  }
}

const prevPage = () => {
  if (currentPage.value > 1) {
    currentPage.value--
    fetchUsers()
  }
}

const nextPage = () => {
  if (currentPage.value < pagination.value.last_page) {
    currentPage.value++
    fetchUsers()
  }
}

const resetFilters = () => {
  search.value = ''
  filters.value.role = ''
  currentPage.value = 1
  fetchUsers()
}

// Modal operations
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

const closeModal = () => {
  showModal.value = false
}

const saveUser = async () => {
  if (!isEdit.value && !form.value.password) {
    toast.error('Password harus diisi')
    return
  }
  
  saving.value = true
  try {
    if (isEdit.value) {
      await axios.put(`/admin/users/${form.value.id}`, form.value)
      toast.success('User berhasil diupdate')
    } else {
      await axios.post('/admin/users', form.value)
      toast.success('User berhasil ditambahkan')
    }
    closeModal()
    await fetchUsers()
  } catch (err) {
    toast.error(err.response?.data?.message || 'Gagal menyimpan')
  } finally {
    saving.value = false
  }
}

const deleteUser = async (user) => {
  if (confirm(`Hapus user "${user.name}"?`)) {
    try {
      await axios.delete(`/admin/users/${user.id}`)
      toast.success('User berhasil dihapus')
      await fetchUsers()
    } catch (err) {
      toast.error(err.response?.data?.message || 'Gagal menghapus')
    }
  }
}

onMounted(() => {
  fetchUsers()
})
</script>

<style scoped>
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.animate-fade-in-up {
  animation: fadeInUp 0.3s ease-out;
}
</style>