<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
      <div>
        <h1 class="text-2xl font-bold text-gray-800">Progress Siswa</h1>
        <p class="text-gray-500 mt-1">Pantau kemajuan siswa magang</p>
      </div>
      <button @click="refreshData" class="px-4 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700 transition flex items-center gap-2">
        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
        </svg>
        Refresh
      </button>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
      <div class="bg-gradient-to-br from-purple-500 to-purple-700 rounded-xl p-5 text-white shadow-lg">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Total Siswa</p>
            <p class="text-3xl font-bold mt-1">{{ students.length }}</p>
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
            <p class="text-3xl font-bold mt-1">{{ totalLogbooks }}</p>
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
            <p class="text-3xl font-bold mt-1">{{ averageGrade }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <StarIcon class="w-6 h-6" />
          </div>
        </div>
      </div>
      <div class="bg-gradient-to-br from-yellow-500 to-yellow-700 rounded-xl p-5 text-white shadow-lg">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Progress Rata-rata</p>
            <p class="text-3xl font-bold mt-1">{{ averageProgress }}%</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <ChartBarIcon class="w-6 h-6" />
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

    <!-- Student Cards -->
    <div v-else-if="filteredStudents.length > 0" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <div v-for="student in filteredStudents" :key="student.id" class="bg-white rounded-xl shadow-md overflow-hidden border border-gray-100 hover:shadow-lg transition">
        <!-- Header -->
        <div class="p-4 bg-gradient-to-r from-purple-500 to-pink-500 text-white">
          <div class="flex items-center gap-3">
            <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center text-white font-bold text-lg">
              {{ student.name?.charAt(0) || 'S' }}
            </div>
            <div>
              <h3 class="font-semibold">{{ student.name }}</h3>
              <p class="text-xs opacity-80">NISN: {{ student.nisn }}</p>
            </div>
          </div>
        </div>
        
        <!-- Body -->
        <div class="p-4">
          <!-- Stats -->
          <div class="grid grid-cols-2 gap-3 mb-4">
            <div class="text-center p-3 bg-blue-50 rounded-xl">
              <p class="text-2xl font-bold text-blue-600">{{ student.logbook_count || 0 }}</p>
              <p class="text-xs text-gray-500">Logbook</p>
            </div>
            <div class="text-center p-3 bg-green-50 rounded-xl">
              <p class="text-2xl font-bold text-green-600">{{ student.average_grade || 0 }}</p>
              <p class="text-xs text-gray-500">Rata-rata Nilai</p>
            </div>
          </div>
          
          <!-- Progress Bar -->
          <div class="mb-3">
            <div class="flex justify-between text-xs text-gray-500 mb-1">
              <span>Progress Logbook</span>
              <span>{{ progressPercentage(student) }}%</span>
            </div>
            <div class="w-full bg-gray-200 rounded-full h-2">
              <div class="bg-purple-600 h-2 rounded-full" :style="{ width: progressPercentage(student) + '%' }"></div>
            </div>
            <p class="text-xs text-gray-400 mt-1">Target 30 logbook</p>
          </div>
          
          <!-- Last Logbook -->
          <div v-if="student.last_logbook" class="mt-3 p-2 bg-gray-50 rounded-lg">
            <p class="text-xs font-semibold text-gray-600">Logbook Terakhir:</p>
            <p class="text-xs text-gray-500">{{ student.last_logbook.activity }}</p>
            <p class="text-xs text-gray-400">{{ formatDate(student.last_logbook.date) }}</p>
          </div>
          
          <!-- Action Buttons -->
          <div class="mt-4 flex gap-2">
            <router-link :to="`/perusahaan/assessment/${student.id}`" class="flex-1 text-center px-3 py-2 bg-purple-600 text-white rounded-lg text-sm hover:bg-purple-700 transition">
              Beri Nilai
            </router-link>
            <router-link :to="`/perusahaan/progress/${student.id}`" class="px-3 py-2 bg-gray-100 text-gray-600 rounded-lg text-sm hover:bg-gray-200 transition">
              Detail
            </router-link>
          </div>
        </div>
      </div>
    </div>

    <!-- Empty State -->
    <div v-else-if="!loading && filteredStudents.length === 0" class="bg-white rounded-xl p-12 text-center">
      <UserGroupIcon class="w-16 h-16 mx-auto text-gray-300 mb-3" />
      <p class="text-gray-500 text-lg">Belum ada siswa magang</p>
      <p class="text-sm text-gray-400 mt-1">Belum ada siswa yang magang di perusahaan Anda</p>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import axios from '../../plugins/axios'
import { useToast } from 'vue-toastification'
import { UserGroupIcon, BookOpenIcon, StarIcon, ChartBarIcon } from '@heroicons/vue/24/outline'

const toast = useToast()

// State
const students = ref([])
const loading = ref(false)
const search = ref('')

// Computed
const totalLogbooks = computed(() => students.value.reduce((sum, s) => sum + (s.logbook_count || 0), 0))
const averageGrade = computed(() => {
  const withGrade = students.value.filter(s => s.average_grade)
  if (withGrade.length === 0) return 0
  const sum = withGrade.reduce((acc, s) => acc + (s.average_grade || 0), 0)
  return Math.round(sum / withGrade.length)
})
const averageProgress = computed(() => {
  if (students.value.length === 0) return 0
  const sum = students.value.reduce((acc, s) => acc + progressPercentage(s), 0)
  return Math.round(sum / students.value.length)
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

const progressPercentage = (student) => {
  const target = 30
  const count = student.logbook_count || 0
  return Math.min(100, Math.round((count / target) * 100))
}

// Fetch data
const fetchStudents = async () => {
  loading.value = true
  try {
    const res = await axios.get('/perusahaan/progress')
    students.value = res.data.data || res.data || []
  } catch (error) {
    console.error('Fetch students error:', error)
    toast.error('Gagal memuat data siswa')
  } finally {
    loading.value = false
  }
}

const refreshData = () => {
  fetchStudents()
}

onMounted(() => {
  fetchStudents()
})
</script>