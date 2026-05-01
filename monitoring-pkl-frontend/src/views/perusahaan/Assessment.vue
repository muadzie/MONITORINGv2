<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
      <div>
        <h1 class="text-2xl font-bold text-gray-800">Penilaian Logbook</h1>
        <p class="text-gray-500 mt-1">Berikan penilaian untuk logbook siswa magang</p>
      </div>
      <div class="flex gap-2">
        <select v-model="filterStatus" class="px-4 py-2 border rounded-lg">
          <option value="all">Semua Logbook</option>
          <option value="pending">Menunggu Nilai</option>
          <option value="graded">Sudah Dinilai</option>
        </select>
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
            <p class="text-sm opacity-90">Total Logbook</p>
            <p class="text-3xl font-bold mt-1">{{ logbooks.length }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <BookOpenIcon class="w-6 h-6" />
          </div>
        </div>
      </div>
      <div class="bg-gradient-to-br from-yellow-500 to-yellow-700 rounded-xl p-5 text-white shadow-lg">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Menunggu Nilai</p>
            <p class="text-3xl font-bold mt-1">{{ pendingCount }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <ClockIcon class="w-6 h-6" />
          </div>
        </div>
      </div>
      <div class="bg-gradient-to-br from-green-500 to-green-700 rounded-xl p-5 text-white shadow-lg">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Sudah Dinilai</p>
            <p class="text-3xl font-bold mt-1">{{ gradedCount }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <CheckCircleIcon class="w-6 h-6" />
          </div>
        </div>
      </div>
    </div>

    <!-- Search -->
    <div class="bg-white rounded-xl shadow-md p-4 border border-gray-100">
      <div class="relative">
        <svg class="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
        </svg>
        <input v-model="search" type="text" placeholder="Cari siswa..." class="w-full pl-10 pr-4 py-2 border rounded-lg">
      </div>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="flex justify-center py-12">
      <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-purple-600 mx-auto"></div>
      <p class="mt-4 text-gray-500">Memuat data...</p>
    </div>

    <!-- Logbook Cards -->
    <div v-else-if="filteredLogbooks.length > 0" class="space-y-4">
      <div v-for="log in filteredLogbooks" :key="log.id" class="bg-white rounded-xl shadow-md overflow-hidden border border-gray-100 hover:shadow-lg transition">
        <div class="p-5">
          <div class="flex flex-col md:flex-row justify-between gap-4">
            <!-- Kiri: Informasi -->
            <div class="flex-1">
              <div class="flex items-center gap-3 mb-2">
                <div class="w-10 h-10 bg-gradient-to-br from-purple-100 to-pink-100 rounded-full flex items-center justify-center text-purple-600 font-bold">
                  {{ log.student?.name?.charAt(0) || 'S' }}
                </div>
                <div>
                  <p class="font-semibold text-gray-800">{{ log.student?.name }}</p>
                  <p class="text-xs text-gray-500">NISN: {{ log.student?.nisn }}</p>
                </div>
                <span v-if="log.grade" class="ml-auto px-2 py-1 bg-green-100 text-green-700 rounded-full text-xs">
                  ✓ Sudah Dinilai
                </span>
                <span v-else class="ml-auto px-2 py-1 bg-yellow-100 text-yellow-700 rounded-full text-xs">
                  ⏳ Menunggu Nilai
                </span>
              </div>
              <p class="text-sm text-gray-500 mb-2">
                📅 {{ formatDate(log.date) }} | {{ log.activity }}
              </p>
              <p class="text-gray-600">{{ log.description }}</p>
              <div v-if="log.attachment" class="mt-2">
                <a :href="log.attachment_url" target="_blank" class="text-purple-600 text-sm hover:underline flex items-center gap-1">
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.172 7l-6.586 6.586a2 2 0 102.828 2.828l6.414-6.586a4 4 0 00-5.656-5.656l-6.415 6.585a6 6 0 108.486 8.486L20.5 13" />
                  </svg>
                  Lihat Lampiran
                </a>
              </div>
            </div>
            
            <!-- Kanan: Form Penilaian -->
            <div class="w-full md:w-72 bg-gray-50 rounded-xl p-4">
              <div v-if="log.grade" class="mb-3 p-2 bg-green-50 rounded-lg">
                <p class="text-xs text-green-600">Nilai Sebelumnya: <span class="font-bold">{{ log.grade }}</span></p>
                <p class="text-xs text-gray-500">{{ log.feedback }}</p>
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Nilai (0-100)</label>
                <input v-model.number="log.form.grade" type="number" min="0" max="100" class="w-full px-3 py-2 border rounded-lg mb-2" placeholder="Masukkan nilai">
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Feedback</label>
                <textarea v-model="log.form.feedback" rows="2" class="w-full px-3 py-2 border rounded-lg mb-2" placeholder="Masukkan feedback..."></textarea>
              </div>
              <button @click="submitAssessment(log)" class="w-full bg-purple-600 text-white py-2 rounded-lg hover:bg-purple-700 transition" :disabled="submitting">
                {{ submitting ? 'Menyimpan...' : '💾 Simpan Penilaian' }}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Empty State -->
    <div v-else-if="!loading && filteredLogbooks.length === 0" class="bg-white rounded-xl p-12 text-center">
      <CheckCircleIcon class="w-16 h-16 mx-auto text-green-300 mb-3" />
      <p class="text-gray-500 text-lg">Belum ada logbook</p>
      <p class="text-sm text-gray-400 mt-1">Belum ada logbook dari siswa magang</p>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import axios from '../../plugins/axios'
import { useToast } from 'vue-toastification'
import { BookOpenIcon, ClockIcon, CheckCircleIcon } from '@heroicons/vue/24/outline'

const toast = useToast()

// State
const logbooks = ref([])
const loading = ref(false)
const submitting = ref(false)
const search = ref('')
const filterStatus = ref('all')

// Computed
const pendingCount = computed(() => logbooks.value.filter(l => !l.grade).length)
const gradedCount = computed(() => logbooks.value.filter(l => l.grade).length)

const filteredLogbooks = computed(() => {
  let result = logbooks.value
  
  if (filterStatus.value === 'pending') {
    result = result.filter(l => !l.grade)
  } else if (filterStatus.value === 'graded') {
    result = result.filter(l => l.grade)
  }
  
  if (search.value) {
    const searchLower = search.value.toLowerCase()
    result = result.filter(l => l.student?.name?.toLowerCase().includes(searchLower))
  }
  
  return result
})

// Helper functions
const formatDate = (date) => {
  if (!date) return '-'
  return new Date(date).toLocaleDateString('id-ID', { day: 'numeric', month: 'long', year: 'numeric' })
}

// Fetch data
const fetchLogbooks = async () => {
  loading.value = true
  try {
    const res = await axios.get('/perusahaan/logbooks')
    console.log('Logbooks response:', res.data)
    const data = res.data.data || res.data || []
    logbooks.value = data.map(l => ({
      ...l,
      form: {
        grade: l.grade || '',
        feedback: l.feedback || ''
      }
    }))
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
}

// Submit assessment
const submitAssessment = async (log) => {
  if (!log.form.grade) {
    toast.error('Masukkan nilai terlebih dahulu')
    return
  }
  if (log.form.grade < 0 || log.form.grade > 100) {
    toast.error('Nilai harus antara 0-100')
    return
  }
  
  submitting.value = true
  try {
    // GANTI METHOD POST MENJADI PUT
    await axios.put(`/perusahaan/logbooks/${log.id}/grade`, {
      grade: log.form.grade,
      feedback: log.form.feedback
    })
    toast.success('Penilaian berhasil disimpan')
    await fetchLogbooks()
  } catch (error) {
    console.error('Submit error:', error)
    toast.error(error.response?.data?.message || 'Gagal menyimpan penilaian')
  } finally {
    submitting.value = false
  }
}

onMounted(() => {
  fetchLogbooks()
})
</script>