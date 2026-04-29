<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
      <div>
        <h1 class="text-2xl font-bold text-gray-800">Penilaian PKL</h1>
        <p class="text-gray-500 mt-1">Input nilai untuk siswa bimbingan Anda</p>
      </div>
      <div class="flex gap-2">
        <button 
          @click="fetchStudents" 
          class="px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition flex items-center gap-2"
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

    <!-- Stats -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
      <div class="bg-gradient-to-br from-indigo-500 to-indigo-700 rounded-xl p-5 text-white shadow-lg">
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
            <p class="text-sm opacity-90">Sudah Dinilai</p>
            <p class="text-3xl font-bold mt-1">{{ assessedCount }}</p>
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
            <p class="text-sm opacity-90">Belum Dinilai</p>
            <p class="text-3xl font-bold mt-1">{{ students.length - assessedCount }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
          </div>
        </div>
      </div>
      <div class="bg-gradient-to-br from-purple-500 to-purple-700 rounded-xl p-5 text-white shadow-lg">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Rata-rata Nilai</p>
            <p class="text-3xl font-bold mt-1">{{ averageScore }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
            </svg>
          </div>
        </div>
      </div>
    </div>

    <!-- Search -->
    <div class="bg-white rounded-xl shadow-md p-4 border border-gray-100">
      <div class="relative">
        <svg class="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
        </svg>
        <input 
          v-model="search" 
          type="text" 
          placeholder="Cari siswa (Nama, NISN)..." 
          class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
        >
      </div>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="flex justify-center py-12">
      <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-indigo-600 mx-auto"></div>
      <p class="mt-4 text-gray-500">Memuat data siswa...</p>
    </div>

    <!-- Students List -->
    <div v-else-if="filteredStudents.length > 0" class="space-y-4">
      <div v-for="student in filteredStudents" :key="student.id" class="bg-white rounded-xl shadow-md overflow-hidden border border-gray-100 hover:shadow-lg transition-all duration-300">
        <div class="p-4 border-b bg-gradient-to-r from-indigo-50 to-purple-50 flex flex-col md:flex-row justify-between items-start md:items-center gap-3">
          <div class="flex items-center gap-3">
            <div class="w-12 h-12 bg-gradient-to-br from-indigo-600 to-purple-600 rounded-xl flex items-center justify-center text-white font-bold text-lg shadow-md">
              {{ student.name?.charAt(0) || 'S' }}
            </div>
            <div>
              <h3 class="font-semibold text-gray-800">{{ student.name }}</h3>
              <p class="text-sm text-gray-500">NISN: {{ student.nisn }} | {{ student.company?.name || 'Belum ditempatkan' }}</p>
              <p class="text-xs text-gray-400 mt-1">📊 Kehadiran: {{ student.attendance_percentage || 0 }}% | 📝 Logbook: {{ student.logbook_count || 0 }} entri</p>
            </div>
          </div>
          <div class="flex items-center gap-2">
            <span :class="student.assessment ? 'bg-green-100 text-green-800' : 'bg-yellow-100 text-yellow-800'" class="px-3 py-1 rounded-full text-xs font-medium">
              {{ student.assessment ? '✓ Sudah Dinilai' : '⏳ Belum Dinilai' }}
            </span>
            <span v-if="student.assessment?.final_score" class="bg-purple-100 text-purple-800 px-3 py-1 rounded-full text-xs font-bold">
              🎯 {{ student.assessment.final_score }}
            </span>
          </div>
        </div>
        
        <div class="p-5">
          <form @submit.prevent="submitAssessment(student)">
            <!-- Bobot Nilai -->
            <div class="mb-4 p-3 bg-blue-50 rounded-lg">
              <p class="text-sm font-semibold text-blue-800 mb-2">📊 Bobot Penilaian</p>
              <div class="grid grid-cols-2 md:grid-cols-5 gap-2 text-xs text-gray-600">
                <div>Kehadiran: <span class="font-bold">20%</span></div>
                <div>Logbook: <span class="font-bold">30%</span></div>
                <div>Laporan: <span class="font-bold">25%</span></div>
                <div>Sikap: <span class="font-bold">15%</span></div>
                <div>Kinerja: <span class="font-bold">10%</span></div>
              </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-5 gap-4">
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Kehadiran <span class="text-xs text-gray-400">(20%)</span></label>
                <div class="relative">
                  <input 
                    type="number" 
                    v-model="student.form.attendance_score" 
                    min="0" 
                    max="100" 
                    class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-indigo-500"
                    @input="calculateFinalScore(student)"
                  >
                  <button 
                    type="button" 
                    @click="autoFillAttendance(student)" 
                    class="absolute right-2 top-1/2 transform -translate-y-1/2 text-xs text-indigo-600 hover:text-indigo-800"
                    title="Isi otomatis dari absensi"
                  >
                    🔄 Auto
                  </button>
                </div>
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Logbook <span class="text-xs text-gray-400">(30%)</span></label>
                <div class="relative">
                  <input 
                    type="number" 
                    v-model="student.form.logbook_score" 
                    min="0" 
                    max="100" 
                    class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-indigo-500"
                    @input="calculateFinalScore(student)"
                  >
                  <button 
                    type="button" 
                    @click="autoFillLogbook(student)" 
                    class="absolute right-2 top-1/2 transform -translate-y-1/2 text-xs text-indigo-600 hover:text-indigo-800"
                    title="Isi otomatis dari logbook"
                  >
                    🔄 Auto
                  </button>
                </div>
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Laporan <span class="text-xs text-gray-400">(25%)</span></label>
                <input type="number" v-model="student.form.report_score" min="0" max="100" class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-indigo-500" @input="calculateFinalScore(student)">
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Sikap <span class="text-xs text-gray-400">(15%)</span></label>
                <input type="number" v-model="student.form.attitude_score" min="0" max="100" class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-indigo-500" @input="calculateFinalScore(student)">
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Kinerja <span class="text-xs text-gray-400">(10%)</span></label>
                <input type="number" v-model="student.form.performance_score" min="0" max="100" class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-indigo-500" @input="calculateFinalScore(student)">
              </div>
            </div>
            
            <div class="mt-3 grid grid-cols-1 md:grid-cols-3 gap-3">
              <div class="md:col-span-2">
                <label class="block text-sm font-medium text-gray-700 mb-1">Catatan</label>
                <textarea v-model="student.form.notes" rows="2" class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-indigo-500" placeholder="Catatan untuk siswa..."></textarea>
              </div>
              <div class="flex flex-col justify-center items-center bg-gray-50 rounded-lg p-2">
                <p class="text-xs text-gray-500">Nilai Akhir</p>
                <p class="text-3xl font-bold" :class="getFinalScoreColor(student.form.final_score)">
                  {{ student.form.final_score || '-' }}
                </p>
              </div>
            </div>

            <div class="mt-4 flex justify-end gap-2">
              <button type="submit" class="px-5 py-2 bg-gradient-to-r from-indigo-600 to-purple-600 text-white rounded-lg hover:shadow-lg transition-all font-medium" :disabled="saving">
                {{ saving ? 'Menyimpan...' : '💾 Simpan Penilaian' }}
              </button>
            </div>
          </form>
          
          <!-- Tampilkan nilai terakhir -->
          <div v-if="student.assessment" class="mt-4 p-3 bg-gray-50 rounded-lg">
            <div class="flex justify-between items-center">
              <p class="text-sm font-semibold text-gray-700">📋 Nilai Terakhir</p>
              <span class="text-xs text-gray-400">{{ formatDate(student.assessment.updated_at) }}</span>
            </div>
            <div class="grid grid-cols-5 gap-2 mt-2 text-xs">
              <div>Kehadiran: <span class="font-semibold">{{ student.assessment.attendance_score || '-' }}</span></div>
              <div>Logbook: <span class="font-semibold">{{ student.assessment.logbook_score || '-' }}</span></div>
              <div>Laporan: <span class="font-semibold">{{ student.assessment.report_score || '-' }}</span></div>
              <div>Sikap: <span class="font-semibold">{{ student.assessment.attitude_score || '-' }}</span></div>
              <div>Kinerja: <span class="font-semibold">{{ student.assessment.performance_score || '-' }}</span></div>
            </div>
            <p class="text-sm mt-2">📝 Catatan: {{ student.assessment.notes || '-' }}</p>
          </div>
        </div>
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
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import axios from '../../plugins/axios'
import { useToast } from 'vue-toastification'
import * as XLSX from 'xlsx'

const toast = useToast()
const students = ref([])
const loading = ref(false)
const saving = ref(false)
const search = ref('')

// Bobot nilai
const weights = {
  attendance: 0.20,
  logbook: 0.30,
  report: 0.25,
  attitude: 0.15,
  performance: 0.10
}

// Computed
const assessedCount = computed(() => students.value.filter(s => s.assessment).length)

const averageScore = computed(() => {
  const withScores = students.value.filter(s => s.assessment?.final_score)
  if (withScores.length === 0) return 0
  const sum = withScores.reduce((acc, s) => acc + parseFloat(s.assessment.final_score), 0)
  return Math.round(sum / withScores.length)
})

const filteredStudents = computed(() => {
  if (!search.value) return students.value
  const searchLower = search.value.toLowerCase()
  return students.value.filter(s => 
    s.name?.toLowerCase().includes(searchLower) ||
    s.nisn?.toLowerCase().includes(searchLower)
  )
})

// Helper functions
const formatDate = (date) => {
  if (!date) return '-'
  return new Date(date).toLocaleDateString('id-ID')
}

const getFinalScoreColor = (score) => {
  if (!score) return 'text-gray-400'
  if (score >= 85) return 'text-green-600'
  if (score >= 70) return 'text-blue-600'
  if (score >= 60) return 'text-yellow-600'
  return 'text-red-600'
}

// Hitung nilai akhir
const calculateFinalScore = (student) => {
  const scores = student.form
  const final = 
    (parseFloat(scores.attendance_score) || 0) * weights.attendance +
    (parseFloat(scores.logbook_score) || 0) * weights.logbook +
    (parseFloat(scores.report_score) || 0) * weights.report +
    (parseFloat(scores.attitude_score) || 0) * weights.attitude +
    (parseFloat(scores.performance_score) || 0) * weights.performance
  
  student.form.final_score = Math.round(final)
  return student.form.final_score
}

// Auto fill dari data absensi
const autoFillAttendance = (student) => {
  if (student.attendance_percentage) {
    student.form.attendance_score = Math.round(student.attendance_percentage)
    calculateFinalScore(student)
    toast.info(`Nilai kehadiran diisi otomatis: ${student.attendance_percentage}%`)
  } else {
    toast.warning('Data kehadiran belum tersedia')
  }
}

// Auto fill dari data logbook
const autoFillLogbook = (student) => {
  // Logbook dinilai berdasarkan jumlah entri (target 30 logbook)
  const targetLogbook = 30
  const score = Math.min(100, (student.logbook_count || 0) / targetLogbook * 100)
  student.form.logbook_score = Math.round(score)
  calculateFinalScore(student)
  toast.info(`Nilai logbook diisi otomatis: ${Math.round(score)} (${student.logbook_count || 0}/${targetLogbook} entri)`)
}

// Fetch data
const fetchStudents = async () => {
  loading.value = true
  try {
    const res = await axios.get('/guru/assessments') // Ganti endpoint
    console.log('Raw response:', res.data)
    
    let data = []
    if (res.data && res.data.data && Array.isArray(res.data.data)) {
      data = res.data.data
    } else if (res.data && Array.isArray(res.data)) {
      data = res.data
    }
    
    students.value = data.map(s => ({
      ...s,
      form: {
        attendance_score: s.assessment?.attendance_score || '',
        logbook_score: s.assessment?.logbook_score || '',
        report_score: s.assessment?.report_score || '',
        attitude_score: s.assessment?.attitude_score || '',
        performance_score: s.assessment?.performance_score || '',
        notes: s.assessment?.notes || '',
        final_score: s.assessment?.final_score || ''
      }
    }))
    
    console.log('Students loaded:', students.value.length)
  } catch (error) {
    console.error('Failed to fetch students:', error)
    toast.error('Gagal memuat data siswa')
  } finally {
    loading.value = false
  }
}

const submitAssessment = async (student) => {
  const payload = {
    student_id: student.id,
    attendance_score: student.form.attendance_score || null,
    logbook_score: student.form.logbook_score || null,
    report_score: student.form.report_score || null,
    attitude_score: student.form.attitude_score || null,
    performance_score: student.form.performance_score || null,
    final_score: calculateFinalScore(student),
    notes: student.form.notes || null
  }
  
  saving.value = true
  try {
    await axios.post('/guru/assessments', payload) // Ganti endpoint
    toast.success('Penilaian berhasil disimpan')
    await fetchStudents()
  } catch (error) {
    console.error('Submit error:', error)
    toast.error(error.response?.data?.message || 'Gagal menyimpan penilaian')
  } finally {
    saving.value = false
  }
}

// Submit assessment

// Export to Excel
const exportToExcel = () => {
  const data = students.value.map((s, index) => ({
    'No': index + 1,
    'NISN': s.nisn,
    'Nama Siswa': s.name,
    'Kelas': s.class?.name || '-',
    'Perusahaan': s.company?.name || '-',
    'Nilai Kehadiran': s.assessment?.attendance_score || '-',
    'Nilai Logbook': s.assessment?.logbook_score || '-',
    'Nilai Laporan': s.assessment?.report_score || '-',
    'Nilai Sikap': s.assessment?.attitude_score || '-',
    'Nilai Kinerja': s.assessment?.performance_score || '-',
    'Nilai Akhir': s.assessment?.final_score || '-',
    'Catatan': s.assessment?.notes || '-'
  }))

  const ws = XLSX.utils.json_to_sheet(data)
  ws['!cols'] = [{ wch: 5 }, { wch: 12 }, { wch: 25 }, { wch: 12 }, { wch: 30 }, 
                 { wch: 12 }, { wch: 12 }, { wch: 12 }, { wch: 12 }, { wch: 12 }, { wch: 12 }, { wch: 30 }]
  
  const wb = XLSX.utils.book_new()
  XLSX.utils.book_append_sheet(wb, ws, 'Penilaian PKL')
  XLSX.writeFile(wb, `Penilaian_PKL_${new Date().toISOString().split('T')[0]}.xlsx`)
  toast.success('File Excel berhasil diunduh')
}

onMounted(() => {
  fetchStudents()
})
</script>