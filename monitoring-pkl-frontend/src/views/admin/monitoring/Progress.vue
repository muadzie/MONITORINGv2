<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
      <div>
        <h1 class="text-2xl font-bold text-gray-800">📈 Progress Siswa PKL</h1>
        <p class="text-gray-500 mt-1">Pantau perkembangan dan capaian logbook siswa secara实时</p>
      </div>
      <div class="flex gap-3">
        <button 
          @click="refreshData" 
          class="bg-indigo-50 text-indigo-600 px-4 py-2 rounded-xl hover:bg-indigo-100 transition flex items-center gap-2"
          :disabled="loading"
        >
          <svg class="w-5 h-5" :class="{'animate-spin': loading}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path>
          </svg>
          Refresh
        </button>
        <button 
          @click="exportData" 
          class="bg-gradient-to-r from-green-600 to-emerald-600 text-white px-5 py-2 rounded-xl hover:shadow-lg transition-all duration-300 flex items-center gap-2"
        >
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"></path>
          </svg>
          Export Excel
        </button>
      </div>
    </div>

    <!-- Stats Cards Premium -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
      <div class="bg-gradient-to-br from-indigo-500 to-indigo-700 rounded-2xl p-5 text-white shadow-lg hover:shadow-xl transition-all duration-300">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Total Siswa PKL</p>
            <p class="text-3xl font-bold mt-1">{{ students.length }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path>
            </svg>
          </div>
        </div>
        <div class="mt-2 text-xs opacity-75">
          <span class="font-bold">{{ students.filter(s => s.company).length }}</span> sudah ditempatkan
        </div>
      </div>
      
      <div class="bg-gradient-to-br from-green-500 to-green-700 rounded-2xl p-5 text-white shadow-lg hover:shadow-xl transition-all duration-300 cursor-pointer" @click="filterByProgress('high')">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Progress Tinggi</p>
            <p class="text-3xl font-bold mt-1">{{ highProgress }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"></path>
            </svg>
          </div>
        </div>
        <div class="mt-2 text-xs opacity-75">Progress > 80%</div>
        <div class="mt-1 text-xs opacity-60">Sangat Baik</div>
      </div>
      
      <div class="bg-gradient-to-br from-yellow-500 to-yellow-700 rounded-2xl p-5 text-white shadow-lg hover:shadow-xl transition-all duration-300 cursor-pointer" @click="filterByProgress('medium')">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Progress Sedang</p>
            <p class="text-3xl font-bold mt-1">{{ mediumProgress }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
          </div>
        </div>
        <div class="mt-2 text-xs opacity-75">Progress 50-80%</div>
        <div class="mt-1 text-xs opacity-60">Cukup</div>
      </div>
      
      <div class="bg-gradient-to-br from-red-500 to-red-700 rounded-2xl p-5 text-white shadow-lg hover:shadow-xl transition-all duration-300 cursor-pointer" @click="filterByProgress('low')">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Progress Rendah</p>
            <p class="text-3xl font-bold mt-1">{{ lowProgress }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
          </div>
        </div>
        <div class="mt-2 text-xs opacity-75">Progress < 50%</div>
        <div class="mt-1 text-xs opacity-60">Perlu Bimbingan</div>
      </div>
    </div>

    <!-- Advanced Filters -->
    <div class="bg-white rounded-2xl shadow-lg p-6 border border-gray-100">
      <div class="flex items-center justify-between mb-4">
        <h3 class="font-semibold text-gray-800">🔍 Filter Data Progress</h3>
        <button @click="resetFilters" class="text-sm text-gray-500 hover:text-indigo-600 transition flex items-center gap-1">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path>
          </svg>
          Reset Filter
        </button>
      </div>
      
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">🏫 Kelas</label>
          <select v-model="filters.class_id" class="w-full px-4 py-2.5 border border-gray-300 rounded-xl focus:ring-2 focus:ring-indigo-500 bg-white">
            <option value="">Semua Kelas</option>
            <option v-for="cls in classes" :key="cls.id" :value="cls.id">📚 {{ cls.name }}</option>
          </select>
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">🏢 Perusahaan</label>
          <select v-model="filters.company_id" class="w-full px-4 py-2.5 border border-gray-300 rounded-xl focus:ring-2 focus:ring-indigo-500 bg-white">
            <option value="">Semua Perusahaan</option>
            <option v-for="company in companies" :key="company.id" :value="company.id">🏢 {{ company.name }}</option>
          </select>
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">👨‍🎓 Nama Siswa</label>
          <input 
            v-model="filters.student_name" 
            type="text" 
            placeholder="Cari nama siswa..."
            class="w-full px-4 py-2.5 border border-gray-300 rounded-xl focus:ring-2 focus:ring-indigo-500"
          >
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">⭐ Range Nilai</label>
          <select v-model="filters.grade_range" class="w-full px-4 py-2.5 border border-gray-300 rounded-xl focus:ring-2 focus:ring-indigo-500 bg-white">
            <option value="">Semua Nilai</option>
            <option value="90-100">A (90-100) - Sangat Baik</option>
            <option value="80-89">B (80-89) - Baik</option>
            <option value="70-79">C (70-79) - Cukup</option>
            <option value="0-69">D (0-69) - Kurang</option>
          </select>
        </div>
      </div>
      
      <div class="mt-4 flex justify-end gap-3">
        <button 
          @click="fetchData" 
          class="bg-gradient-to-r from-indigo-600 to-purple-600 text-white px-6 py-2.5 rounded-xl hover:shadow-lg transition-all duration-300 flex items-center gap-2"
          :disabled="loading"
        >
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
          </svg>
          Terapkan Filter
        </button>
      </div>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="bg-white rounded-2xl shadow-sm p-12 text-center">
      <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-indigo-600 mx-auto"></div>
      <p class="mt-4 text-gray-500">Memuat data progress siswa...</p>
    </div>

    <!-- Table -->
    <div v-else-if="filteredStudents.length > 0" class="bg-white rounded-2xl shadow-lg overflow-hidden border border-gray-100">
      <div class="overflow-x-auto">
        <table class="min-w-[1200px] w-full">
          <thead>
            <tr class="bg-gradient-to-r from-indigo-600 to-purple-600">
              <th class="px-6 py-4 text-left text-xs font-semibold text-white uppercase">No</th>
              <th class="px-6 py-4 text-left text-xs font-semibold text-white uppercase">NISN</th>
              <th class="px-6 py-4 text-left text-xs font-semibold text-white uppercase">Nama Siswa</th>
              <th class="px-6 py-4 text-left text-xs font-semibold text-white uppercase">Kelas</th>
              <th class="px-6 py-4 text-left text-xs font-semibold text-white uppercase">Perusahaan</th>
              <th class="px-6 py-4 text-left text-xs font-semibold text-white uppercase">Guru Pembimbing</th>
              <th class="px-6 py-4 text-left text-xs font-semibold text-white uppercase">Logbook</th>
              <th class="px-6 py-4 text-left text-xs font-semibold text-white uppercase">Progress</th>
              <th class="px-6 py-4 text-center text-xs font-semibold text-white uppercase">Rata-rata Nilai</th>
              <th class="px-6 py-4 text-center text-xs font-semibold text-white uppercase">Status</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-100">
            <tr v-for="(student, index) in paginatedStudents" :key="student.id" class="hover:bg-gray-50 transition duration-200">
              <td class="px-6 py-4 text-sm text-gray-500">{{ index + 1 + (currentPage - 1) * itemsPerPage }}</td>
              <td class="px-6 py-4 text-sm font-mono text-gray-600">{{ student.nisn || '-' }}</td>
              <td class="px-6 py-4">
                <div class="flex items-center gap-2">
                  <div class="w-8 h-8 bg-gradient-to-br from-indigo-100 to-purple-100 rounded-full flex items-center justify-center text-indigo-600 font-bold text-sm">
                    {{ student.name?.charAt(0) || 'S' }}
                  </div>
                  <span class="font-medium text-gray-800">{{ student.name }}</span>
                </div>
              </td>
              <td class="px-6 py-4">
                <span class="inline-flex items-center gap-1 px-2 py-1 bg-blue-100 text-blue-800 rounded-lg text-xs font-medium">
                  <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path>
                  </svg>
                  {{ student.class?.name || '-' }}
                </span>
              </td>
              <td class="px-6 py-4">
                <span v-if="student.company" class="inline-flex items-center gap-1 px-2 py-1 bg-indigo-100 text-indigo-800 rounded-lg text-xs font-medium">
                  <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path>
                  </svg>
                  {{ student.company.name }}
                </span>
                <span v-else class="text-gray-400 text-xs">-</span>
              </td>
              <td class="px-6 py-4">
                <span v-if="student.teacher" class="inline-flex items-center gap-1 px-2 py-1 bg-purple-100 text-purple-800 rounded-lg text-xs font-medium">
                  <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path>
                  </svg>
                  {{ student.teacher.name }}
                </span>
                <span v-else class="text-gray-400 text-xs">-</span>
              </td>
              <td class="px-6 py-4">
                <div class="flex items-center gap-1">
                  <span class="text-sm font-semibold text-indigo-600">{{ student.logbook_count || 0 }}</span>
                  <span class="text-xs text-gray-400">/ 30</span>
                </div>
              </td>
              <td class="px-6 py-4">
                <div class="flex items-center gap-2">
                  <div class="flex-1 h-2 bg-gray-200 rounded-full overflow-hidden">
                    <div class="h-full rounded-full transition-all duration-500" :class="getProgressColor(student.progress)" :style="{ width: (student.progress || 0) + '%' }"></div>
                  </div>
                  <span class="text-xs font-medium" :class="getProgressTextColor(student.progress)">{{ student.progress || 0 }}%</span>
                </div>
              </td>
              <td class="px-6 py-4 text-center">
                <div class="flex items-center justify-center">
                  <span :class="getGradeColor(student.avg_grade)" class="inline-flex items-center justify-center w-10 h-10 rounded-full font-bold text-sm">
                    {{ student.avg_grade || 0 }}
                  </span>
                </div>
              </td>
              <td class="px-6 py-4 text-center">
                <span :class="getStatusClass(student.progress)" class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-medium">
                  <span class="w-1.5 h-1.5 rounded-full" :class="getStatusDotClass(student.progress)"></span>
                  {{ getStatusText(student.progress) }}
                </span>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Pagination -->
      <div class="px-6 py-4 border-t border-gray-100 flex justify-between items-center">
        <div class="text-sm text-gray-500">
          Menampilkan {{ ((currentPage - 1) * itemsPerPage) + 1 }} - {{ Math.min(currentPage * itemsPerPage, filteredStudents.length) }} dari {{ filteredStudents.length }} siswa
        </div>
        <div class="flex gap-2">
          <button 
            @click="prevPage" 
            :disabled="currentPage === 1"
            class="px-3 py-1 border rounded-lg hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed transition"
          >
            Previous
          </button>
          <button 
            @click="nextPage" 
            :disabled="currentPage === totalPages"
            class="px-3 py-1 border rounded-lg hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed transition"
          >
            Next
          </button>
        </div>
      </div>
    </div>

    <!-- Empty State -->
    <div v-else-if="!loading && filteredStudents.length === 0" class="bg-white rounded-2xl shadow-sm p-12 text-center">
      <svg class="w-20 h-20 mx-auto text-gray-300 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
      </svg>
      <p class="text-gray-500 text-lg">Belum ada data siswa</p>
      <p class="text-sm text-gray-400 mt-1">Tidak ada siswa yang ditemukan dengan filter yang dipilih</p>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import axios from '../../../plugins/axios'
import { useToast } from 'vue-toastification'

const toast = useToast()
const loading = ref(false)
const students = ref([])
const classes = ref([])
const companies = ref([])
const currentPage = ref(1)
const itemsPerPage = ref(10)

const filters = ref({
  class_id: '',
  company_id: '',
  student_name: '',
  grade_range: '',
  progress_filter: '' // untuk filter dari card
})

const getProgressColor = (progress) => {
  if (progress >= 80) return 'bg-green-500'
  if (progress >= 50) return 'bg-yellow-500'
  return 'bg-red-500'
}

const getProgressTextColor = (progress) => {
  if (progress >= 80) return 'text-green-600'
  if (progress >= 50) return 'text-yellow-600'
  return 'text-red-600'
}

const getGradeColor = (grade) => {
  if (grade >= 90) return 'bg-green-100 text-green-700'
  if (grade >= 80) return 'bg-emerald-100 text-emerald-700'
  if (grade >= 70) return 'bg-yellow-100 text-yellow-700'
  return 'bg-red-100 text-red-700'
}

const getStatusClass = (progress) => {
  if (progress >= 80) return 'bg-green-100 text-green-800'
  if (progress >= 50) return 'bg-yellow-100 text-yellow-800'
  return 'bg-red-100 text-red-800'
}

const getStatusDotClass = (progress) => {
  if (progress >= 80) return 'bg-green-500'
  if (progress >= 50) return 'bg-yellow-500'
  return 'bg-red-500'
}

const getStatusText = (progress) => {
  if (progress >= 80) return 'Sangat Baik'
  if (progress >= 50) return 'Cukup'
  return 'Perlu Bimbingan'
}

// Computed untuk statistik
const highProgress = computed(() => students.value.filter(s => s.progress > 80).length)
const mediumProgress = computed(() => students.value.filter(s => s.progress >= 50 && s.progress <= 80).length)
const lowProgress = computed(() => students.value.filter(s => s.progress < 50).length)

// Filter data
const filteredStudents = computed(() => {
  let result = [...students.value]
  
  if (filters.value.class_id) {
    result = result.filter(s => s.class_id === parseInt(filters.value.class_id))
  }
  
  if (filters.value.company_id) {
    result = result.filter(s => s.company_id === parseInt(filters.value.company_id))
  }
  
  if (filters.value.student_name) {
    const searchLower = filters.value.student_name.toLowerCase()
    result = result.filter(s => s.name?.toLowerCase().includes(searchLower))
  }
  
  if (filters.value.grade_range) {
    const [min, max] = filters.value.grade_range.split('-').map(Number)
    result = result.filter(s => {
      const grade = Number(s.avg_grade)
      return grade && grade >= min && grade <= max
    })
  }
  
  if (filters.value.progress_filter === 'high') {
    result = result.filter(s => s.progress > 80)
  } else if (filters.value.progress_filter === 'medium') {
    result = result.filter(s => s.progress >= 50 && s.progress <= 80)
  } else if (filters.value.progress_filter === 'low') {
    result = result.filter(s => s.progress < 50)
  }
  
  return result
})

const totalPages = computed(() => Math.ceil(filteredStudents.value.length / itemsPerPage.value))
const paginatedStudents = computed(() => {
  const start = (currentPage.value - 1) * itemsPerPage.value
  const end = start + itemsPerPage.value
  return filteredStudents.value.slice(start, end)
})

const filterByProgress = (type) => {
  if (filters.value.progress_filter === type) {
    filters.value.progress_filter = ''
  } else {
    filters.value.progress_filter = type
  }
  currentPage.value = 1
}

const resetFilters = () => {
  filters.value = {
    class_id: '',
    company_id: '',
    student_name: '',
    grade_range: '',
    progress_filter: ''
  }
  fetchData()
}

const refreshData = () => {
  fetchData()
}

const fetchData = async () => {
  loading.value = true
  try {
    const params = {
      class_id: filters.value.class_id,
      company_id: filters.value.company_id
    }
    const res = await axios.get('/admin/monitoring/progress', { params })
    students.value = res.data
    currentPage.value = 1
    toast.success(`Berhasil memuat ${students.value.length} data siswa`)
  } catch (error) {
    console.error('Fetch error:', error)
    toast.error('Gagal memuat data progress')
  } finally {
    loading.value = false
  }
}

const fetchClasses = async () => {
  try {
    const res = await axios.get('/admin/classes')
    classes.value = res.data.data || res.data || []
  } catch (error) {
    console.error('Classes fetch error:', error)
  }
}

const fetchCompanies = async () => {
  try {
    const res = await axios.get('/companies')
    companies.value = res.data.data || res.data || []
  } catch (error) {
    console.error('Companies fetch error:', error)
  }
}

const exportData = async () => {
  try {
    const params = {
      class_id: filters.value.class_id,
      company_id: filters.value.company_id
    }
    const res = await axios.get('/admin/monitoring/progress/export', { 
      params, 
      responseType: 'blob' 
    })
    const url = window.URL.createObjectURL(new Blob([res.data]))
    const link = document.createElement('a')
    link.href = url
    const filename = `progress_siswa_${new Date().toISOString().split('T')[0]}.xlsx`
    link.download = filename
    link.click()
    window.URL.revokeObjectURL(url)
    toast.success('Export data berhasil')
  } catch (error) {
    console.error('Export error:', error)
    toast.error('Gagal mengexport data')
  }
}

const prevPage = () => {
  if (currentPage.value > 1) {
    currentPage.value--
  }
}

const nextPage = () => {
  if (currentPage.value < totalPages.value) {
    currentPage.value++
  }
}

// Watch untuk reset page
watch([() => filters.value.class_id, () => filters.value.company_id, () => filters.value.student_name, () => filters.value.grade_range, () => filters.value.progress_filter], () => {
  currentPage.value = 1
})

onMounted(() => {
  fetchData()
  fetchClasses()
  fetchCompanies()
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

.cursor-pointer {
  cursor: pointer;
}
</style>