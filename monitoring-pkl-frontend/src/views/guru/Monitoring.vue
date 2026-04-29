<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
      <div>
        <h1 class="text-2xl font-bold text-gray-800">Monitoring Siswa Bimbingan</h1>
        <p class="text-gray-500 mt-1">Pantau aktivitas dan progres siswa bimbingan PKL Anda</p>
      </div>
      <div class="flex gap-2">
        <button 
          @click="refreshData" 
          class="px-4 py-2 bg-gradient-to-r from-indigo-600 to-purple-600 text-white rounded-lg hover:shadow-lg transition-all duration-300 flex items-center gap-2"
        >
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path>
          </svg>
          Refresh
        </button>
        <button 
          @click="exportToExcel" 
          class="px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 transition flex items-center gap-2"
        >
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"></path>
          </svg>
          Export Excel
        </button>
      </div>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 md:grid-cols-5 gap-4">
      <div class="bg-gradient-to-br from-blue-500 to-blue-700 rounded-xl p-5 text-white shadow-lg">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Total Siswa</p>
            <p class="text-3xl font-bold mt-1">{{ students.length }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path>
            </svg>
          </div>
        </div>
      </div>
      <div class="bg-gradient-to-br from-green-500 to-green-700 rounded-xl p-5 text-white shadow-lg">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Hadir Hari Ini</p>
            <p class="text-3xl font-bold mt-1">{{ presentToday }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
            </svg>
          </div>
        </div>
      </div>
      <div class="bg-gradient-to-br from-yellow-500 to-yellow-700 rounded-xl p-5 text-white shadow-lg">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Terlambat</p>
            <p class="text-3xl font-bold mt-1">{{ lateToday }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
          </div>
        </div>
      </div>
      <div class="bg-gradient-to-br from-red-500 to-red-700 rounded-xl p-5 text-white shadow-lg">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Alpha Hari Ini</p>
            <p class="text-3xl font-bold mt-1">{{ absentToday }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
            </svg>
          </div>
        </div>
      </div>
      <div class="bg-gradient-to-br from-purple-500 to-purple-700 rounded-xl p-5 text-white shadow-lg">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Total Logbook</p>
            <p class="text-3xl font-bold mt-1">{{ totalLogbook }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
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
            placeholder="Cari siswa (NISN, Nama)..." 
            class="w-full pl-10 pr-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
          >
        </div>
        <select v-model="filters.company" class="px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 bg-white">
          <option value="">📌 Semua Perusahaan</option>
          <option v-for="c in uniqueCompanies" :key="c" :value="c">{{ c }}</option>
        </select>
        <select v-model="filters.status" class="px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 bg-white">
          <option value="">🏷️ Semua Status</option>
          <option value="present">✅ Hadir</option>
          <option value="late">⏰ Terlambat</option>
          <option value="absent">❌ Alpha</option>
          <option value="sick">🤒 Sakit</option>
          <option value="permit">📝 Izin</option>
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
        <p class="mt-4 text-gray-500">Memuat data siswa...</p>
      </div>
    </div>

    <!-- Table -->
    <div v-else-if="filteredStudents.length > 0" class="bg-white rounded-xl shadow-md overflow-hidden border border-gray-100">
      <div class="overflow-x-auto">
        <table class="min-w-[1000px] lg:min-w-full bg-white">
          <thead>
            <tr class="bg-gradient-to-r from-indigo-600 to-purple-600">
              <th class="px-4 py-3 text-center text-xs font-semibold text-white uppercase w-12">No</th>
              <th class="px-4 py-3 text-left text-xs font-semibold text-white uppercase w-28">NISN</th>
              <th class="px-4 py-3 text-left text-xs font-semibold text-white uppercase w-36">Nama Siswa</th>
              <th class="px-4 py-3 text-left text-xs font-semibold text-white uppercase w-40">Perusahaan</th>
              <th class="px-4 py-3 text-left text-xs font-semibold text-white uppercase w-28">Kelas</th>
              <th class="px-4 py-3 text-center text-xs font-semibold text-white uppercase w-24">Status Hari Ini</th>
              <th class="px-4 py-3 text-center text-xs font-semibold text-white uppercase w-20">Logbook</th>
              <th class="px-4 py-3 text-center text-xs font-semibold text-white uppercase w-20">Aksi</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-100">
            <tr v-for="(student, index) in filteredStudents" :key="student.id" class="hover:bg-gray-50 transition duration-200">
              <td class="px-4 py-3 text-sm text-gray-500 text-center">{{ index + 1 }}</td>
              <td class="px-4 py-3 text-sm font-mono text-gray-600 whitespace-nowrap">{{ student.nisn }}</td>
              <td class="px-4 py-3 font-medium text-gray-800 whitespace-nowrap">
                <div class="flex items-center gap-2">
                  <div class="w-8 h-8 bg-gradient-to-br from-indigo-100 to-purple-100 rounded-full flex items-center justify-center text-indigo-600 font-bold text-sm shadow-sm">
                    {{ student.name?.charAt(0) || 'S' }}
                  </div>
                  {{ student.name }}
                </div>
              </td>
              <td class="px-4 py-3 text-sm text-gray-600">
                <span class="inline-flex items-center gap-1 px-2 py-1 bg-indigo-100 text-indigo-700 rounded-lg text-xs font-medium">
                  <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path>
                  </svg>
                  {{ student.company?.name || '-' }}
                </span>
              </td>
              <td class="px-4 py-3 text-sm text-gray-600 whitespace-nowrap">{{ student.class?.name || '-' }}</td>
              <td class="px-4 py-3 text-center">
                <span :class="getStatusClass(student.today_status)" class="inline-flex items-center gap-1 px-2 py-1 rounded-full text-xs font-medium">
                  <span class="w-1.5 h-1.5 rounded-full" :class="getStatusDotClass(student.today_status)"></span>
                  {{ getStatusText(student.today_status) }}
                </span>
              </td>
              <td class="px-4 py-3 text-center">
                <span class="inline-flex items-center gap-1 px-2 py-1 bg-blue-100 text-blue-700 rounded-lg text-xs font-medium">
                  <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                  </svg>
                  {{ student.logbook_count || 0 }} Entri
                </span>
              </td>
              <td class="px-4 py-3 text-center">
                <button 
                  @click="viewDetail(student)" 
                  class="px-3 py-1.5 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition text-sm flex items-center gap-1 mx-auto"
                >
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                  </svg>
                  Detail
                </button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Empty State -->
    <div v-else-if="!loading && filteredStudents.length === 0" class="bg-white rounded-xl p-12 text-center">
      <svg class="w-20 h-20 mx-auto text-gray-300 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path>
      </svg>
      <p class="text-gray-500 text-lg">Belum ada siswa bimbingan</p>
      <p class="text-sm text-gray-400 mt-1">Anda belum memiliki siswa bimbingan PKL</p>
    </div>

    <!-- Modal Detail Siswa -->
    <div v-if="showModal" class="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50" @click.self="closeModal">
      <div class="bg-white rounded-2xl w-full max-w-2xl max-h-[90vh] overflow-y-auto animate-fade-in-up shadow-2xl">
        <div class="sticky top-0 bg-white p-5 border-b rounded-t-2xl">
          <div class="flex justify-between items-center">
            <div class="flex items-center gap-3">
              <div class="w-10 h-10 bg-gradient-to-br from-indigo-600 to-purple-600 rounded-xl flex items-center justify-center shadow-lg">
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path>
                </svg>
              </div>
              <div>
                <h3 class="text-xl font-bold text-gray-800">Detail Siswa</h3>
                <p class="text-sm text-gray-500">Informasi lengkap siswa bimbingan</p>
              </div>
            </div>
            <button @click="closeModal" class="text-gray-400 hover:text-gray-600 transition">
              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
              </svg>
            </button>
          </div>
        </div>

        <div class="p-6 space-y-6">
          <!-- Profile Section -->
          <div class="flex items-center gap-4 pb-4 border-b">
            <div class="w-20 h-20 bg-gradient-to-br from-indigo-100 to-purple-100 rounded-full flex items-center justify-center text-indigo-600 font-bold text-2xl shadow-sm">
              {{ selectedStudent?.name?.charAt(0) || 'S' }}
            </div>
            <div>
              <h2 class="text-xl font-bold text-gray-800">{{ selectedStudent?.name }}</h2>
              <p class="text-gray-500">NISN: {{ selectedStudent?.nisn }}</p>
              <p class="text-gray-500">Kelas: {{ selectedStudent?.class?.name || '-' }}</p>
            </div>
          </div>

          <!-- Info Perusahaan -->
          <div class="bg-indigo-50 rounded-xl p-4">
            <h4 class="font-semibold text-indigo-800 mb-2 flex items-center gap-2">
              <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path>
              </svg>
              Perusahaan PKL
            </h4>
            <p class="text-gray-700">{{ selectedStudent?.company?.name || '-' }}</p>
            <p class="text-sm text-gray-500 mt-1">{{ selectedStudent?.company?.address || '-' }}</p>
          </div>

          <!-- Statistik -->
          <div class="grid grid-cols-2 gap-4">
            <div class="bg-green-50 rounded-xl p-4 text-center">
              <p class="text-2xl font-bold text-green-600">{{ selectedStudent?.logbook_count || 0 }}</p>
              <p class="text-xs text-gray-500">Total Logbook</p>
            </div>
            <div class="bg-blue-50 rounded-xl p-4 text-center">
              <p class="text-2xl font-bold text-blue-600">{{ selectedStudent?.attendance_count || 0 }}</p>
              <p class="text-xs text-gray-500">Total Kehadiran</p>
            </div>
          </div>

          <!-- Kehadiran Hari Ini -->
          <div class="bg-gray-50 rounded-xl p-4">
            <h4 class="font-semibold text-gray-800 mb-2">Kehadiran Hari Ini</h4>
            <div class="flex items-center justify-between">
              <span>Status</span>
              <span :class="getStatusClass(selectedStudent?.today_status)" class="px-2 py-1 rounded-full text-xs font-medium">
                {{ getStatusText(selectedStudent?.today_status) }}
              </span>
            </div>
            <div v-if="selectedStudent?.today_check_in" class="flex items-center justify-between mt-2">
              <span>Check In</span>
              <span class="font-medium">{{ selectedStudent?.today_check_in }}</span>
            </div>
            <div v-if="selectedStudent?.today_check_out" class="flex items-center justify-between mt-2">
              <span>Check Out</span>
              <span class="font-medium">{{ selectedStudent?.today_check_out }}</span>
            </div>
          </div>

          <!-- Tombol Aksi -->
          <div class="flex justify-end gap-3 pt-4 border-t">
            <router-link 
              :to="`/guru/logbook-review?student_id=${selectedStudent?.id}`" 
              class="px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition"
            >
              Lihat Logbook
            </router-link>
            <button @click="closeModal" class="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition">Tutup</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import axios from '../../plugins/axios'
import { useToast } from 'vue-toastification'
import * as XLSX from 'xlsx'

const toast = useToast()

// State
const students = ref([])
const loading = ref(false)
const showModal = ref(false)
const selectedStudent = ref(null)
const search = ref('')
const filters = ref({ company: '', status: '' })

// Computed
const uniqueCompanies = computed(() => {
  const companies = students.value.map(s => s.company?.name).filter(Boolean)
  return [...new Set(companies)]
})

const presentToday = computed(() => students.value.filter(s => s.today_status === 'present').length)
const lateToday = computed(() => students.value.filter(s => s.today_status === 'late').length)
const absentToday = computed(() => students.value.filter(s => s.today_status === 'absent').length)
const totalLogbook = computed(() => students.value.reduce((sum, s) => sum + (s.logbook_count || 0), 0))

const filteredStudents = computed(() => {
  let result = students.value

  if (search.value) {
    const searchLower = search.value.toLowerCase()
    result = result.filter(s => 
      s.nisn?.toLowerCase().includes(searchLower) ||
      s.name?.toLowerCase().includes(searchLower)
    )
  }

  if (filters.value.company) {
    result = result.filter(s => s.company?.name === filters.value.company)
  }

  if (filters.value.status) {
    result = result.filter(s => s.today_status === filters.value.status)
  }

  return result
})

// Helper functions
const getStatusText = (status) => {
  const map = { present: 'Hadir', late: 'Terlambat', absent: 'Alpha', sick: 'Sakit', permit: 'Izin' }
  return map[status] || status || '-'
}

const getStatusClass = (status) => {
  const map = {
    present: 'bg-green-100 text-green-700',
    late: 'bg-yellow-100 text-yellow-700',
    absent: 'bg-red-100 text-red-700',
    sick: 'bg-blue-100 text-blue-700',
    permit: 'bg-purple-100 text-purple-700'
  }
  return map[status] || 'bg-gray-100 text-gray-700'
}

const getStatusDotClass = (status) => {
  const map = {
    present: 'bg-green-500',
    late: 'bg-yellow-500',
    absent: 'bg-red-500',
    sick: 'bg-blue-500',
    permit: 'bg-purple-500'
  }
  return map[status] || 'bg-gray-500'
}

// Fetch data
const fetchStudents = async () => {
  loading.value = true
  try {
    const res = await axios.get('/guru/monitoring')
    students.value = res.data.data || res.data || []
    console.log('Students loaded:', students.value.length)
  } catch (error) {
    console.error('Fetch error:', error)
    toast.error('Gagal memuat data siswa')
  } finally {
    loading.value = false
  }
}

const refreshData = () => {
  fetchStudents()
  toast.info('Data berhasil diperbarui')
}

const resetFilters = () => {
  search.value = ''
  filters.value = { company: '', status: '' }
}

const viewDetail = (student) => {
  selectedStudent.value = student
  showModal.value = true
}

const closeModal = () => {
  showModal.value = false
  selectedStudent.value = null
}

// Export to Excel
const exportToExcel = () => {
  const excelData = filteredStudents.value.map((s, index) => ({
    'No': index + 1,
    'NISN': s.nisn,
    'Nama Siswa': s.name,
    'Kelas': s.class?.name || '-',
    'Perusahaan': s.company?.name || '-',
    'Status Hari Ini': getStatusText(s.today_status),
    'Total Logbook': s.logbook_count || 0
  }))

  const ws = XLSX.utils.json_to_sheet(excelData)
  ws['!cols'] = [
    { wch: 5 }, { wch: 12 }, { wch: 25 }, { wch: 12 }, { wch: 30 }, { wch: 15 }, { wch: 12 }
  ]
  
  const wb = XLSX.utils.book_new()
  XLSX.utils.book_append_sheet(wb, ws, 'Monitoring Siswa')
  XLSX.writeFile(wb, `Monitoring_Siswa_${new Date().toISOString().split('T')[0]}.xlsx`)
  toast.success('File Excel berhasil diunduh')
}

onMounted(() => {
  fetchStudents()
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