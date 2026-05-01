<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
      <div>
        <h1 class="text-2xl font-bold text-gray-800">Laporan PKL</h1>
        <p class="text-gray-500 mt-1">Download laporan aktivitas dan penilaian siswa</p>
      </div>
      <div class="flex gap-2">
        <button @click="exportToExcel" class="px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 transition flex items-center gap-2">
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
          </svg>
          Export Excel
        </button>
        <button @click="refreshData" class="px-4 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700 transition">
          Refresh
        </button>
      </div>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
      <div class="bg-gradient-to-br from-purple-500 to-purple-700 rounded-xl p-5 text-white shadow-lg">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Total Siswa</p>
            <p class="text-3xl font-bold mt-1">{{ summary.total_students || 0 }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <UserGroupIcon class="w-6 h-6" />
          </div>
        </div>
      </div>
      <div class="bg-gradient-to-br from-blue-500 to-blue-700 rounded-xl p-5 text-white shadow-lg">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Total Logbook</p>
            <p class="text-3xl font-bold mt-1">{{ summary.total_logbooks || 0 }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <BookOpenIcon class="w-6 h-6" />
          </div>
        </div>
      </div>
      <div class="bg-gradient-to-br from-green-500 to-green-700 rounded-xl p-5 text-white shadow-lg">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Rata-rata Nilai</p>
            <p class="text-3xl font-bold mt-1">{{ summary.overall_average || 0 }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <StarIcon class="w-6 h-6" />
          </div>
        </div>
      </div>
    </div>

    <!-- Filter -->
    <div class="bg-white rounded-xl shadow-md p-5 border border-gray-100">
      <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Tanggal Mulai</label>
          <input type="date" v-model="startDate" class="w-full px-3 py-2 border rounded-lg">
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Tanggal Selesai</label>
          <input type="date" v-model="endDate" class="w-full px-3 py-2 border rounded-lg">
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Status</label>
          <select v-model="filterStatus" class="w-full px-3 py-2 border rounded-lg">
            <option value="all">Semua</option>
            <option value="graded">Sudah Dinilai</option>
            <option value="pending">Belum Dinilai</option>
          </select>
        </div>
        <div class="flex items-end gap-2">
          <button @click="applyFilter" class="px-4 py-2 bg-purple-600 text-white rounded-lg">Filter</button>
          <button @click="resetFilter" class="px-4 py-2 bg-gray-500 text-white rounded-lg">Reset</button>
        </div>
      </div>
    </div>

    <!-- Loading -->
    <div v-if="loading" class="flex justify-center py-12">
      <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-purple-600 mx-auto"></div>
    </div>

    <!-- Table -->
    <div v-else-if="filteredReports.length > 0" class="bg-white rounded-xl shadow-md overflow-hidden border border-gray-100">
      <div class="overflow-x-auto">
        <table class="min-w-full bg-white">
          <thead class="bg-gradient-to-r from-purple-600 to-pink-600">
            <tr>
              <th class="px-4 py-3 text-left text-xs font-semibold text-white">No</th>
              <th class="px-4 py-3 text-left text-xs font-semibold text-white">NISN</th>
              <th class="px-4 py-3 text-left text-xs font-semibold text-white">Nama Siswa</th>
              <th class="px-4 py-3 text-left text-xs font-semibold text-white">Tanggal</th>
              <th class="px-4 py-3 text-left text-xs font-semibold text-white">Kegiatan</th>
              <th class="px-4 py-3 text-center text-xs font-semibold text-white">Nilai</th>
              <th class="px-4 py-3 text-center text-xs font-semibold text-white">Status</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-100">
            <tr v-for="(report, index) in filteredReports" :key="report.id" class="hover:bg-gray-50">
              <td class="px-4 py-3 text-sm">{{ index + 1 }}</td>
              <td class="px-4 py-3 text-sm font-mono">{{ report.user?.nisn || '-' }}</td>
              <td class="px-4 py-3 font-medium">{{ report.user?.name || '-' }}</td>
              <td class="px-4 py-3 text-sm">{{ report.date }}</td>
              <td class="px-4 py-3 text-sm">{{ report.activity }}</td>
              <td class="px-4 py-3 text-center">
                <span class="font-bold" :class="report.grade ? 'text-green-600' : 'text-gray-400'">
                  {{ report.grade || '-' }}
                </span>
              </td>
              <td class="px-4 py-3 text-center">
                <span v-if="report.grade" class="px-2 py-1 bg-green-100 text-green-800 rounded-full text-xs">Sudah Dinilai</span>
                <span v-else class="px-2 py-1 bg-yellow-100 text-yellow-800 rounded-full text-xs">Menunggu</span>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Empty State -->
    <div v-else-if="!loading && filteredReports.length === 0" class="bg-white rounded-xl p-12 text-center">
      <svg class="w-20 h-20 mx-auto text-gray-300 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
      </svg>
      <p class="text-gray-500 text-lg">Belum ada data laporan</p>
      <p class="text-sm text-gray-400 mt-1">Belum ada logbook dari siswa magang</p>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import axios from '../../plugins/axios'
import { useToast } from 'vue-toastification'
import { UserGroupIcon, BookOpenIcon, StarIcon } from '@heroicons/vue/24/outline'
import * as XLSX from 'xlsx'

const toast = useToast()

// State
const reports = ref([])
const loading = ref(false)
const startDate = ref('')
const endDate = ref('')
const filterStatus = ref('all')
const summary = ref({})

// Computed
const filteredReports = computed(() => {
  let result = reports.value
  
  if (filterStatus.value === 'graded') {
    result = result.filter(r => r.grade)
  } else if (filterStatus.value === 'pending') {
    result = result.filter(r => !r.grade)
  }
  
  return result
})

// Fetch data
const fetchReports = async () => {
  loading.value = true
  try {
    const params = {}
    if (startDate.value) params.start_date = startDate.value
    if (endDate.value) params.end_date = endDate.value
    
    const res = await axios.get('/perusahaan/reports/logbook', { params })
    reports.value = res.data.data || []
    summary.value = res.data.summary || {}
  } catch (error) {
    console.error('Fetch reports error:', error)
    toast.error('Gagal memuat data laporan')
  } finally {
    loading.value = false
  }
}

const applyFilter = () => {
  fetchReports()
}

const resetFilter = () => {
  startDate.value = ''
  endDate.value = ''
  filterStatus.value = 'all'
  fetchReports()
}

const refreshData = () => {
  fetchReports()
}

// Export to Excel
const exportToExcel = () => {
  const data = filteredReports.value.map((r, idx) => ({
    'No': idx + 1,
    'NISN': r.user?.nisn || '-',
    'Nama Siswa': r.user?.name || '-',
    'Tanggal': r.date,
    'Kegiatan': r.activity,
    'Nilai': r.grade || '-',
    'Status': r.grade ? 'Sudah Dinilai' : 'Menunggu'
  }))
  
  const ws = XLSX.utils.json_to_sheet(data)
  const wb = XLSX.utils.book_new()
  XLSX.utils.book_append_sheet(wb, ws, 'Laporan PKL')
  XLSX.writeFile(wb, `Laporan_PKL_${new Date().toISOString().split('T')[0]}.xlsx`)
  toast.success('File Excel berhasil diunduh')
}

onMounted(() => {
  fetchReports()
})
</script>