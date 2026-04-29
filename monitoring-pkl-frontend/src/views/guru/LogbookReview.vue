<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
      <div>
        <h1 class="text-2xl font-bold text-gray-800">Review Logbook Siswa</h1>
        <p class="text-gray-500 mt-1">Review logbook harian siswa PKL</p>
      </div>
      <div class="flex gap-2">
        <!-- Tab Navigation -->
        <div class="flex bg-gray-100 rounded-lg p-1">
          <button 
            @click="activeTab = 'pending'; fetchLogbooks()" 
            class="px-4 py-2 rounded-lg text-sm font-medium transition-all duration-200"
            :class="activeTab === 'pending' ? 'bg-white shadow-md text-indigo-600' : 'text-gray-600 hover:text-gray-800'"
          >
            📋 Menunggu Review
          </button>
          <button 
            @click="activeTab = 'all'; fetchLogbooks()" 
            class="px-4 py-2 rounded-lg text-sm font-medium transition-all duration-200"
            :class="activeTab === 'all' ? 'bg-white shadow-md text-indigo-600' : 'text-gray-600 hover:text-gray-800'"
          >
            📚 Semua Logbook
          </button>
        </div>
        <button 
          @click="refreshData" 
          class="px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition flex items-center gap-2"
        >
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path>
          </svg>
          Refresh
        </button>
      </div>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
      <div class="bg-gradient-to-br from-blue-500 to-blue-700 rounded-xl p-5 text-white shadow-lg">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Total Logbook</p>
            <p class="text-3xl font-bold mt-1">{{ logbooks.length }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
            </svg>
          </div>
        </div>
      </div>
      <div class="bg-gradient-to-br from-yellow-500 to-yellow-700 rounded-xl p-5 text-white shadow-lg">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Menunggu Review</p>
            <p class="text-3xl font-bold mt-1">{{ pendingCount }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
          </div>
        </div>
      </div>
      <div class="bg-gradient-to-br from-green-500 to-green-700 rounded-xl p-5 text-white shadow-lg">
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
      </div>
      <div class="bg-gradient-to-br from-red-500 to-red-700 rounded-xl p-5 text-white shadow-lg">
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
            placeholder="Cari berdasarkan nama siswa..." 
            class="w-full pl-10 pr-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
          >
        </div>
        <select v-model="filterStatus" class="px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 bg-white">
          <option value="all">📌 Semua Status</option>
          <option value="pending">⏳ Menunggu Review</option>
          <option value="approved">✅ Disetujui</option>
          <option value="rejected">❌ Ditolak</option>
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
        <p class="mt-4 text-gray-500">Memuat data logbook...</p>
      </div>
    </div>

    <!-- Table -->
    <div v-else-if="filteredLogbooks.length > 0" class="bg-white rounded-xl shadow-md overflow-hidden border border-gray-100">
      <div class="overflow-x-auto">
        <table class="min-w-[1000px] lg:min-w-full bg-white">
          <thead>
            <tr class="bg-gradient-to-r from-indigo-600 to-purple-600">
              <th class="px-4 py-3 text-center text-xs font-semibold text-white uppercase w-12">No</th>
              <th class="px-4 py-3 text-left text-xs font-semibold text-white uppercase w-28">NISN</th>
              <th class="px-4 py-3 text-left text-xs font-semibold text-white uppercase w-32">Siswa</th>
              <th class="px-4 py-3 text-left text-xs font-semibold text-white uppercase w-44">Kegiatan</th>
              <th class="px-4 py-3 text-left text-xs font-semibold text-white uppercase w-36">Tanggal</th>
              <th class="px-4 py-3 text-left text-xs font-semibold text-white uppercase w-40">Perusahaan</th>
              <th class="px-4 py-3 text-center text-xs font-semibold text-white uppercase w-24">Status</th>
              <th class="px-4 py-3 text-center text-xs font-semibold text-white uppercase w-20">Aksi</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-100">
            <tr v-for="(logbook, index) in filteredLogbooks" :key="logbook.id" class="hover:bg-gray-50 transition duration-200">
              <td class="px-4 py-3 text-sm text-gray-500 text-center">{{ index + 1 }}</td>
              <td class="px-4 py-3 text-sm font-mono text-gray-600">{{ logbook.student?.nisn || '-' }}</td>
              <td class="px-4 py-3 font-medium text-gray-800">{{ logbook.student?.name || '-' }}</td>
              <td class="px-4 py-3 text-sm text-gray-600">
                <div class="max-w-md truncate">{{ logbook.activity || '-' }}</div>
              </td>
              <td class="px-4 py-3 text-sm text-gray-600 whitespace-nowrap">{{ formatDate(logbook.date) }}</td>
              <td class="px-4 py-3">
                <span class="inline-flex items-center gap-1 px-2 py-1 bg-green-100 text-green-700 rounded-lg text-xs font-medium">
                  <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path>
                  </svg>
                  {{ logbook.company?.name || '-' }}
                </span>
              </td>
              <td class="px-4 py-3 text-center">
                <span :class="getStatusClass(logbook.status)" class="inline-flex items-center gap-1 px-2 py-1 rounded-full text-xs font-medium">
                  <span class="w-1.5 h-1.5 rounded-full" :class="getStatusDotClass(logbook.status)"></span>
                  {{ getStatusText(logbook.status) }}
                </span>
              </td>
              <td class="px-4 py-3 text-center">
                <button 
                  @click="openReviewModal(logbook)" 
                  class="px-3 py-1.5 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition text-sm flex items-center gap-1 mx-auto"
                  :disabled="submitting"
                >
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                  </svg>
                  Review
                </button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Empty State -->
    <div v-else-if="!loading && filteredLogbooks.length === 0" class="bg-white rounded-xl p-12 text-center">
      <svg class="w-20 h-20 mx-auto text-gray-300 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
      </svg>
      <p class="text-gray-500 text-lg">Belum ada data logbook</p>
      <p class="text-sm text-gray-400 mt-1">Belum ada logbook dari siswa bimbingan Anda</p>
    </div>

    <!-- Modal Review -->
    <div v-if="showModal" class="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50" @click.self="closeModal">
      <div class="bg-white rounded-2xl w-full max-w-2xl max-h-[90vh] overflow-y-auto animate-fade-in-up shadow-2xl">
        <div class="sticky top-0 bg-white p-5 border-b rounded-t-2xl">
          <div class="flex justify-between items-center">
            <div class="flex items-center gap-3">
              <div class="w-10 h-10 bg-gradient-to-br from-indigo-600 to-purple-600 rounded-xl flex items-center justify-center shadow-lg">
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                </svg>
              </div>
              <div>
                <h2 class="text-xl font-bold text-gray-800">Review Logbook</h2>
                <p class="text-sm text-gray-500">Review kegiatan harian siswa</p>
              </div>
            </div>
            <button @click="closeModal" class="text-gray-400 hover:text-gray-600 transition">
              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
              </svg>
            </button>
          </div>
        </div>

        <div class="p-6 space-y-4">
          <!-- Informasi Siswa -->
          <div class="bg-gradient-to-r from-indigo-50 to-purple-50 rounded-xl p-4">
            <p class="text-sm font-medium text-gray-700">Informasi Siswa</p>
            <p class="text-lg font-semibold text-gray-800">{{ selectedLogbook?.student?.name }}</p>
            <p class="text-sm text-gray-500">NISN: {{ selectedLogbook?.student?.nisn || '-' }}</p>
            <p class="text-sm text-gray-500 mt-1">📅 {{ formatDate(selectedLogbook?.date) }}</p>
            <p class="text-sm text-gray-500 mt-1">🏢 Perusahaan: {{ selectedLogbook?.company?.name || 'Belum ditentukan' }}</p>
          </div>

          <!-- Detail Logbook -->
          <div class="bg-gray-50 rounded-xl p-4">
            <p class="text-sm font-semibold text-gray-700 mb-2">📝 Kegiatan</p>
            <p class="text-gray-800">{{ selectedLogbook?.activity || '-' }}</p>
          </div>

          <div class="bg-gray-50 rounded-xl p-4">
            <p class="text-sm font-semibold text-gray-700 mb-2">📄 Deskripsi</p>
            <p class="text-gray-800">{{ selectedLogbook?.description || '-' }}</p>
          </div>

          <!-- Lampiran -->
         <!-- Lampiran -->
<div v-if="selectedLogbook?.attachment" class="bg-gray-50 rounded-xl p-4">
  <p class="text-sm font-semibold text-gray-700 mb-2">📎 Lampiran</p>
  <a 
    :href="getFileUrl(selectedLogbook.attachment)" 
    target="_blank" 
    class="text-indigo-600 hover:text-indigo-800 text-sm flex items-center gap-2"
  >
    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.172 7l-6.586 6.586a2 2 0 102.828 2.828l6.414-6.586a4 4 0 00-5.656-5.656l-6.415 6.585a6 6 0 108.486 8.486L20.5 13"></path>
    </svg>
    Lihat Lampiran
  </a>
</div>

          <!-- Catatan Review -->
          <div>
            <label class="block text-sm font-semibold text-gray-700 mb-1">💬 Catatan Review</label>
            <textarea 
              v-model="reviewNotes" 
              rows="3" 
              class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
              placeholder="Masukkan catatan review (wajib untuk penolakan)..."
            ></textarea>
          </div>

          <!-- Tombol Aksi -->
          <div class="flex justify-end gap-3 pt-4 border-t">
            <button type="button" @click="closeModal" class="px-5 py-2.5 border border-gray-300 rounded-lg hover:bg-gray-50 transition font-medium">Batal</button>
            <button 
              @click="approveLogbook" 
              class="px-6 py-2.5 bg-gradient-to-r from-green-600 to-green-700 text-white rounded-lg hover:shadow-lg transition-all font-medium"
              :disabled="submitting"
            >
              {{ submitting ? 'Menyimpan...' : '✅ Setujui' }}
            </button>
            <button 
              @click="rejectLogbook" 
              class="px-6 py-2.5 bg-gradient-to-r from-red-600 to-red-700 text-white rounded-lg hover:shadow-lg transition-all font-medium"
              :disabled="submitting"
            >
              {{ submitting ? 'Menyimpan...' : '❌ Tolak' }}
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import axios from '../../plugins/axios'
import { useToast } from 'vue-toastification'

const toast = useToast()

// State
const logbooks = ref([])
const loading = ref(false)
const submitting = ref(false)
const showModal = ref(false)
const selectedLogbook = ref(null)
const reviewNotes = ref('')
const search = ref('')
const filterStatus = ref('all')
const activeTab = ref('pending')

// Computed
const pendingCount = computed(() => logbooks.value.filter(l => l.status === 'pending').length)
const approvedCount = computed(() => logbooks.value.filter(l => l.status === 'approved').length)
const rejectedCount = computed(() => logbooks.value.filter(l => l.status === 'rejected').length)

const filteredLogbooks = computed(() => {
  let result = logbooks.value
  
  if (filterStatus.value !== 'all') {
    result = result.filter(l => l.status === filterStatus.value)
  }
  
  if (search.value) {
    const searchLower = search.value.toLowerCase()
    result = result.filter(l => 
      l.student?.name?.toLowerCase().includes(searchLower)
    )
  }
  
  return result
})

// Helper untuk mendapatkan URL file
const getFileUrl = (path) => {
  if (!path) return '#'
  // Jika path sudah berupa URL lengkap
  if (path.startsWith('http')) return path
  // Jika path relatif
  return `http://localhost:8000/storage/${path}`
}

// Helper functions
const formatDate = (date) => {
  if (!date) return '-'
  return new Date(date).toLocaleDateString('id-ID', { day: 'numeric', month: 'long', year: 'numeric' })
}

const getStatusText = (status) => {
  const map = { pending: 'Menunggu', approved: 'Disetujui', rejected: 'Ditolak' }
  return map[status] || status
}

const getStatusClass = (status) => {
  const map = {
    pending: 'bg-yellow-100 text-yellow-800',
    approved: 'bg-green-100 text-green-800',
    rejected: 'bg-red-100 text-red-800'
  }
  return map[status] || 'bg-gray-100 text-gray-800'
}

const getStatusDotClass = (status) => {
  const map = {
    pending: 'bg-yellow-500',
    approved: 'bg-green-500',
    rejected: 'bg-red-500'
  }
  return map[status] || 'bg-gray-500'
}

// Fetch data
const fetchLogbooks = async () => {
  loading.value = true
  try {
    const endpoint = activeTab.value === 'pending' ? '/guru/logbooks/pending' : '/guru/logbooks'
    const res = await axios.get(endpoint)
    logbooks.value = res.data.data || res.data || []
    console.log('Logbooks loaded:', logbooks.value.length)
  } catch (error) {
    console.error('Fetch logbooks error:', error)
    toast.error('Gagal memuat data logbook')
  } finally {
    loading.value = false
  }
}

const refreshData = () => {
  fetchLogbooks()
  toast.info('Data berhasil diperbarui')
}

const resetFilters = () => {
  search.value = ''
  filterStatus.value = 'all'
}

// Review actions
const openReviewModal = (logbook) => {
  selectedLogbook.value = logbook
  reviewNotes.value = logbook.feedback || ''
  showModal.value = true
}

const closeModal = () => {
  showModal.value = false
  selectedLogbook.value = null
  reviewNotes.value = ''
}

const approveLogbook = async () => {
  if (!selectedLogbook.value) return
  
  submitting.value = true
  try {
    await axios.put(`/guru/logbooks/${selectedLogbook.value.id}/approve`, {
      notes: reviewNotes.value
    })
    toast.success('Logbook berhasil disetujui')
    closeModal()
    await fetchLogbooks()
  } catch (error) {
    console.error('Approve error:', error)
    toast.error(error.response?.data?.message || 'Gagal menyetujui logbook')
  } finally {
    submitting.value = false
  }
}

const rejectLogbook = async () => {
  if (!selectedLogbook.value) return
  
  if (!reviewNotes.value) {
    toast.error('Mohon isi catatan penolakan')
    return
  }
  
  submitting.value = true
  try {
    await axios.put(`/guru/logbooks/${selectedLogbook.value.id}/reject`, {
      notes: reviewNotes.value
    })
    toast.success('Logbook ditolak')
    closeModal()
    await fetchLogbooks()
  } catch (error) {
    console.error('Reject error:', error)
    toast.error(error.response?.data?.message || 'Gagal menolak logbook')
  } finally {
    submitting.value = false
  }
}

// Watch for tab change
watch(activeTab, () => {
  fetchLogbooks()
})

onMounted(() => {
  fetchLogbooks()
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