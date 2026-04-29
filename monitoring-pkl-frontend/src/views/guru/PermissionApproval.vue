<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
      <div>
        <h1 class="text-2xl font-bold text-gray-800">Approval Izin/Sakit</h1>
        <p class="text-gray-500 mt-1">Setujui atau tolak pengajuan izin/sakit siswa</p>
      </div>
      <button @click="refreshData" class="px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition flex items-center gap-2">
        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path>
        </svg>
        Refresh
      </button>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
      <div class="bg-gradient-to-br from-yellow-500 to-yellow-700 rounded-xl p-5 text-white shadow-lg transition-all duration-300 hover:scale-105">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Menunggu</p>
            <p class="text-3xl font-bold mt-1">{{ pendingPermissions.length }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
          </div>
        </div>
        <p class="text-xs opacity-75 mt-2">Perlu ditinjau</p>
      </div>
      <div class="bg-gradient-to-br from-green-500 to-green-700 rounded-xl p-5 text-white shadow-lg transition-all duration-300 hover:scale-105">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Disetujui</p>
            <p class="text-3xl font-bold mt-1">{{ approvedCount }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
            </svg>
          </div>
        </div>
        <p class="text-xs opacity-75 mt-2">Telah disetujui</p>
      </div>
      <div class="bg-gradient-to-br from-red-500 to-red-700 rounded-xl p-5 text-white shadow-lg transition-all duration-300 hover:scale-105">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Ditolak</p>
            <p class="text-3xl font-bold mt-1">{{ rejectedCount }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
            </svg>
          </div>
        </div>
        <p class="text-xs opacity-75 mt-2">Telah ditolak</p>
      </div>
    </div>

    <!-- Search & Filter -->
    <div class="bg-white rounded-xl shadow-md p-4 border border-gray-100">
      <div class="flex flex-col md:flex-row gap-4">
        <div class="flex-1 relative">
          <svg class="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
          </svg>
          <input 
            v-model="search" 
            type="text" 
            placeholder="Cari berdasarkan nama siswa..." 
            class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
          >
        </div>
        <select v-model="filterType" class="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 bg-white">
          <option value="all">📌 Semua Jenis</option>
          <option value="sick">🤒 Sakit</option>
          <option value="permit">📝 Izin</option>
        </select>
        <select v-model="filterDate" class="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 bg-white">
          <option value="all">📅 Semua Tanggal</option>
          <option value="today">Hari Ini</option>
          <option value="week">Minggu Ini</option>
          <option value="month">Bulan Ini</option>
        </select>
        <button @click="resetFilters" class="px-4 py-2 text-gray-600 hover:bg-gray-100 rounded-lg transition flex items-center gap-2">
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
        <p class="mt-4 text-gray-500">Memuat data...</p>
      </div>
    </div>

    <!-- Content -->
    <div v-else class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <!-- Menunggu Persetujuan -->
      <div class="bg-white rounded-xl shadow-md overflow-hidden border border-gray-100">
        <div class="p-4 bg-gradient-to-r from-yellow-500 to-yellow-600 text-white">
          <div class="flex justify-between items-center">
            <h3 class="font-semibold flex items-center gap-2">
              <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
              </svg>
              Menunggu Persetujuan
            </h3>
            <span class="bg-white/20 px-2 py-1 rounded-full text-xs">{{ pendingPermissions.length }}</span>
          </div>
        </div>
        <div v-if="filteredPending.length === 0" class="p-8 text-center text-gray-500">
          <svg class="w-12 h-12 mx-auto text-gray-300 mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
          </svg>
          Tidak ada pengajuan yang menunggu
        </div>
        <div v-else class="divide-y divide-gray-100 max-h-[600px] overflow-y-auto">
          <div v-for="item in filteredPending" :key="item.id" class="p-4 hover:bg-gray-50 transition-all duration-200">
            <div class="flex flex-col md:flex-row justify-between items-start gap-3">
              <div class="flex-1">
                <div class="flex items-center gap-2 mb-2">
                  <div class="w-9 h-9 bg-gradient-to-br from-indigo-100 to-purple-100 rounded-full flex items-center justify-center text-indigo-600 font-bold text-sm shadow-sm">
                    {{ item.user_name?.charAt(0) || 'S' }}
                  </div>
                  <div>
                    <p class="font-semibold text-gray-800">{{ item.user_name }}</p>
                    <p class="text-xs text-gray-400">NISN: {{ item.user_nisn }}</p>
                  </div>
                </div>
                <div class="flex flex-wrap items-center gap-2 mb-2">
                  <span class="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-xs font-medium" :class="item.type === 'sick' ? 'bg-blue-100 text-blue-700' : 'bg-orange-100 text-orange-700'">
                    {{ item.type === 'sick' ? '🤒 Sakit' : '📝 Izin' }}
                  </span>
                  <span class="text-xs text-gray-500 flex items-center gap-1">
                    <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                    </svg>
                    {{ formatDate(item.date) }}
                  </span>
                </div>
                <div class="bg-gray-50 rounded-lg p-2 mt-1">
                  <p class="text-sm text-gray-600">{{ item.reason }}</p>
                </div>
                <div v-if="item.attachment" class="mt-2">
                  <a :href="item.attachment_url" target="_blank" class="text-indigo-600 hover:text-indigo-800 text-xs flex items-center gap-1">
                    <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.172 7l-6.586 6.586a2 2 0 102.828 2.828l6.414-6.586a4 4 0 00-5.656-5.656l-6.415 6.585a6 6 0 108.486 8.486L20.5 13"></path>
                    </svg>
                    Lihat Lampiran
                  </a>
                </div>
              </div>
              <div class="flex gap-2">
                <button @click="openApproveModal(item)" class="px-3 py-1.5 bg-green-600 text-white rounded-lg text-sm hover:bg-green-700 transition flex items-center gap-1">
                  <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                  </svg>
                  Setujui
                </button>
                <button @click="openRejectModal(item)" class="px-3 py-1.5 bg-red-600 text-white rounded-lg text-sm hover:bg-red-700 transition flex items-center gap-1">
                  <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                  </svg>
                  Tolak
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Riwayat Persetujuan -->
      <div class="bg-white rounded-xl shadow-md overflow-hidden border border-gray-100">
        <div class="p-4 bg-gradient-to-r from-gray-600 to-gray-700 text-white">
          <div class="flex justify-between items-center">
            <h3 class="font-semibold flex items-center gap-2">
              <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
              </svg>
              Riwayat Persetujuan
            </h3>
            <span class="bg-white/20 px-2 py-1 rounded-full text-xs">{{ history.length }}</span>
          </div>
        </div>
        <div v-if="filteredHistory.length === 0" class="p-8 text-center text-gray-500">
          <svg class="w-12 h-12 mx-auto text-gray-300 mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
          </svg>
          Belum ada riwayat persetujuan
        </div>
        <div v-else class="divide-y divide-gray-100 max-h-[600px] overflow-y-auto">
          <div v-for="item in filteredHistory" :key="item.id" class="p-4 hover:bg-gray-50 transition-all duration-200">
            <div class="flex justify-between items-start">
              <div class="flex-1">
                <div class="flex items-center gap-2 mb-2">
                  <div class="w-9 h-9 bg-gradient-to-br from-gray-100 to-gray-200 rounded-full flex items-center justify-center text-gray-600 font-bold text-sm">
                    {{ item.user_name?.charAt(0) || 'S' }}
                  </div>
                  <div>
                    <p class="font-medium text-gray-800">{{ item.user_name }}</p>
                    <p class="text-xs text-gray-400">NISN: {{ item.user_nisn }}</p>
                  </div>
                </div>
                <div class="flex flex-wrap items-center gap-2 mb-2">
                  <span class="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-xs font-medium" :class="item.type === 'sick' ? 'bg-blue-100 text-blue-700' : 'bg-orange-100 text-orange-700'">
                    {{ item.type === 'sick' ? '🤒 Sakit' : '📝 Izin' }}
                  </span>
                  <span class="text-xs text-gray-500 flex items-center gap-1">
                    <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                    </svg>
                    {{ formatDate(item.date) }}
                  </span>
                </div>
                <p v-if="item.reason" class="text-sm text-gray-600 bg-gray-50 p-2 rounded-lg mb-1">{{ item.reason }}</p>
                <p v-if="item.feedback" class="text-xs text-indigo-600 mt-1 flex items-center gap-1">
                  <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z"></path>
                  </svg>
                                  {{ item.feedback }}
                </p>
              </div>
              <span :class="item.status === 'approved' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'" class="px-2 py-1 rounded-full text-xs font-medium whitespace-nowrap ml-2">
                {{ item.status === 'approved' ? '✅ Disetujui' : '❌ Ditolak' }}
              </span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal Approve -->
    <div v-if="showApproveModal" class="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50" @click.self="closeModals">
      <div class="bg-white rounded-2xl w-full max-w-md animate-fade-in-up shadow-2xl">
        <div class="p-5 border-b">
          <div class="flex items-center gap-3">
            <div class="w-10 h-10 bg-green-100 rounded-xl flex items-center justify-center">
              <svg class="w-5 h-5 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
              </svg>
            </div>
            <div>
              <h2 class="text-xl font-bold text-gray-800">Setujui Pengajuan</h2>
              <p class="text-sm text-gray-500">Konfirmasi persetujuan izin/sakit</p>
            </div>
          </div>
        </div>
        <div class="p-5">
          <div class="bg-gray-50 rounded-lg p-3 mb-4">
            <p class="text-sm text-gray-600">Dari: <strong class="text-gray-800">{{ selectedItem?.user_name }}</strong></p>
            <p class="text-sm text-gray-600">Jenis: <strong>{{ selectedItem?.type === 'sick' ? 'Sakit' : 'Izin' }}</strong></p>
            <p class="text-sm text-gray-600">Tanggal: <strong>{{ formatDate(selectedItem?.date) }}</strong></p>
          </div>
          <label class="block text-sm font-semibold text-gray-700 mb-1">💬 Catatan (Opsional)</label>
          <textarea v-model="approveNotes" class="w-full p-3 border rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent" rows="3" placeholder="Tambahkan catatan untuk siswa..."></textarea>
        </div>
        <div class="p-5 border-t flex justify-end gap-3">
          <button @click="closeModals" class="px-4 py-2 border rounded-lg hover:bg-gray-50 transition">Batal</button>
          <button @click="confirmApprove" class="px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 transition" :disabled="submitting">
            {{ submitting ? 'Memproses...' : 'Ya, Setujui' }}
          </button>
        </div>
      </div>
    </div>

    <!-- Modal Reject -->
    <div v-if="showRejectModal" class="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50" @click.self="closeModals">
      <div class="bg-white rounded-2xl w-full max-w-md animate-fade-in-up shadow-2xl">
        <div class="p-5 border-b">
          <div class="flex items-center gap-3">
            <div class="w-10 h-10 bg-red-100 rounded-xl flex items-center justify-center">
              <svg class="w-5 h-5 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
              </svg>
            </div>
            <div>
              <h2 class="text-xl font-bold text-gray-800">Tolak Pengajuan</h2>
              <p class="text-sm text-gray-500">Konfirmasi penolakan izin/sakit</p>
            </div>
          </div>
        </div>
        <div class="p-5">
          <div class="bg-gray-50 rounded-lg p-3 mb-4">
            <p class="text-sm text-gray-600">Dari: <strong class="text-gray-800">{{ selectedItem?.user_name }}</strong></p>
            <p class="text-sm text-gray-600">Jenis: <strong>{{ selectedItem?.type === 'sick' ? 'Sakit' : 'Izin' }}</strong></p>
            <p class="text-sm text-gray-600">Tanggal: <strong>{{ formatDate(selectedItem?.date) }}</strong></p>
          </div>
          <label class="block text-sm font-semibold text-gray-700 mb-1">💬 Catatan Penolakan <span class="text-red-500">*</span></label>
          <textarea v-model="rejectNotes" class="w-full p-3 border rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent" rows="3" placeholder="Berikan alasan penolakan..."></textarea>
        </div>
        <div class="p-5 border-t flex justify-end gap-3">
          <button @click="closeModals" class="px-4 py-2 border rounded-lg hover:bg-gray-50 transition">Batal</button>
          <button @click="confirmReject" class="px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 transition" :disabled="submitting">
            {{ submitting ? 'Memproses...' : 'Ya, Tolak' }}
          </button>
        </div>
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
const pendingPermissions = ref([])
const history = ref([])
const loading = ref(false)
const submitting = ref(false)
const showApproveModal = ref(false)
const showRejectModal = ref(false)
const selectedItem = ref(null)
const approveNotes = ref('')
const rejectNotes = ref('')
const search = ref('')
const filterType = ref('all')
const filterDate = ref('all')

// Computed
const approvedCount = computed(() => history.value.filter(h => h.status === 'approved').length)
const rejectedCount = computed(() => history.value.filter(h => h.status === 'rejected').length)

const filteredPending = computed(() => {
  let result = pendingPermissions.value
  
  if (search.value) {
    result = result.filter(p => p.user_name?.toLowerCase().includes(search.value.toLowerCase()))
  }
  
  if (filterType.value !== 'all') {
    result = result.filter(p => p.type === filterType.value)
  }
  
  if (filterDate.value !== 'all') {
    const today = new Date()
    result = result.filter(p => {
      const itemDate = new Date(p.date)
      if (filterDate.value === 'today') {
        return itemDate.toDateString() === today.toDateString()
      } else if (filterDate.value === 'week') {
        const weekAgo = new Date(today.setDate(today.getDate() - 7))
        return itemDate >= weekAgo
      } else if (filterDate.value === 'month') {
        return itemDate.getMonth() === new Date().getMonth()
      }
      return true
    })
  }
  
  return result
})

const filteredHistory = computed(() => {
  let result = history.value
  
  if (search.value) {
    result = result.filter(h => h.user_name?.toLowerCase().includes(search.value.toLowerCase()))
  }
  
  if (filterType.value !== 'all') {
    result = result.filter(h => h.type === filterType.value)
  }
  
  if (filterDate.value !== 'all') {
    const today = new Date()
    result = result.filter(h => {
      const itemDate = new Date(h.date)
      if (filterDate.value === 'today') {
        return itemDate.toDateString() === today.toDateString()
      } else if (filterDate.value === 'week') {
        const weekAgo = new Date(today.setDate(today.getDate() - 7))
        return itemDate >= weekAgo
      } else if (filterDate.value === 'month') {
        return itemDate.getMonth() === new Date().getMonth()
      }
      return true
    })
  }
  
  return result
})

// Helper functions
const formatDate = (date) => {
  if (!date) return '-'
  return new Date(date).toLocaleDateString('id-ID', { day: 'numeric', month: 'long', year: 'numeric' })
}

const resetFilters = () => {
  search.value = ''
  filterType.value = 'all'
  filterDate.value = 'all'
}

// Fetch data
const loadData = async () => {
  loading.value = true
  try {
    const [res1, res2] = await Promise.all([
      axios.get('/guru/permissions/pending'),
      axios.get('/guru/permissions/history')
    ])
    pendingPermissions.value = res1.data.data || res1.data || []
    history.value = res2.data.data || res2.data || []
  } catch (error) {
    console.error('Load data error:', error)
    toast.error('Gagal memuat data')
  } finally {
    loading.value = false
  }
}

const refreshData = () => {
  loadData()
  toast.info('Data berhasil diperbarui')
}

// Modal handlers
const openApproveModal = (item) => {
  selectedItem.value = item
  approveNotes.value = ''
  showApproveModal.value = true
}

const openRejectModal = (item) => {
  selectedItem.value = item
  rejectNotes.value = ''
  showRejectModal.value = true
}

const closeModals = () => {
  showApproveModal.value = false
  showRejectModal.value = false
  selectedItem.value = null
  approveNotes.value = ''
  rejectNotes.value = ''
}

const confirmApprove = async () => {
  if (!selectedItem.value) return
  
  submitting.value = true
  try {
    await axios.put(`/guru/permissions/${selectedItem.value.id}/approve`, {
      feedback: approveNotes.value
    })
    toast.success('✅ Izin berhasil disetujui')
    closeModals()
    await loadData()
  } catch (error) {
    console.error('Approve error:', error)
    toast.error('Gagal menyetujui')
  } finally {
    submitting.value = false
  }
}

const confirmReject = async () => {
  if (!selectedItem.value) return
  
  if (!rejectNotes.value) {
    toast.error('Mohon isi catatan penolakan')
    return
  }
  
  submitting.value = true
  try {
    await axios.put(`/guru/permissions/${selectedItem.value.id}/reject`, {
      feedback: rejectNotes.value
    })
    toast.success('❌ Izin ditolak')
    closeModals()
    await loadData()
  } catch (error) {
    console.error('Reject error:', error)
    toast.error('Gagal menolak')
  } finally {
    submitting.value = false
  }
}

onMounted(() => {
  loadData()
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