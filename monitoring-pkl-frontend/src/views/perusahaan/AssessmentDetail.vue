<template>
  <div class="space-y-6">
    <div class="flex items-center gap-4">
      <router-link to="/perusahaan/assessment" class="text-purple-600 hover:text-purple-800">
        ← Kembali
      </router-link>
      <h1 class="text-2xl font-bold text-gray-800">Detail Penilaian Siswa</h1>
    </div>

    <div v-if="loading" class="flex justify-center py-12">
      <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-purple-600 mx-auto"></div>
    </div>

    <div v-else-if="student" class="bg-white rounded-xl shadow-md overflow-hidden">
      <!-- Header -->
      <div class="p-5 bg-gradient-to-r from-purple-600 to-pink-600 text-white">
        <div class="flex items-center gap-3">
          <div class="w-16 h-16 bg-white/20 rounded-full flex items-center justify-center text-2xl font-bold">
            {{ student.name?.charAt(0) }}
          </div>
          <div>
            <h2 class="text-xl font-bold">{{ student.name }}</h2>
            <p class="text-purple-200">NISN: {{ student.nisn }}</p>
          </div>
        </div>
      </div>

      <!-- Stats -->
      <div class="grid grid-cols-2 md:grid-cols-4 gap-4 p-5 border-b">
        <div class="text-center p-3 bg-blue-50 rounded-xl">
          <p class="text-2xl font-bold text-blue-600">{{ stats.total_logbooks || 0 }}</p>
          <p class="text-xs text-gray-500">Total Logbook</p>
        </div>
        <div class="text-center p-3 bg-green-50 rounded-xl">
          <p class="text-2xl font-bold text-green-600">{{ stats.graded_logbooks || 0 }}</p>
          <p class="text-xs text-gray-500">Sudah Dinilai</p>
        </div>
        <div class="text-center p-3 bg-yellow-50 rounded-xl">
          <p class="text-2xl font-bold text-yellow-600">{{ stats.pending_logbooks || 0 }}</p>
          <p class="text-xs text-gray-500">Belum Dinilai</p>
        </div>
        <div class="text-center p-3 bg-purple-50 rounded-xl">
          <p class="text-2xl font-bold text-purple-600">{{ stats.average_grade || 0 }}</p>
          <p class="text-xs text-gray-500">Rata-rata Nilai</p>
        </div>
      </div>

      <!-- Logbook List -->
      <div class="p-5">
        <h3 class="font-semibold text-gray-800 mb-4">📝 Daftar Logbook</h3>
        <div class="space-y-3">
          <div v-for="log in logbooks" :key="log.id" class="p-4 bg-gray-50 rounded-xl">
            <div class="flex justify-between items-start">
              <div class="flex-1">
                <div class="flex items-center gap-2 mb-1">
                  <p class="font-medium">{{ log.activity }}</p>
                  <span class="text-xs text-gray-400">{{ log.date }}</span>
                </div>
                <p class="text-sm text-gray-600">{{ log.description }}</p>
              </div>
              <div class="text-right ml-4">
                <span v-if="log.grade" class="text-xl font-bold text-green-600">{{ log.grade }}</span>
                <span v-else class="text-sm text-yellow-600">Belum dinilai</span>
              </div>
            </div>
            <div v-if="log.feedback" class="mt-2 p-2 bg-indigo-50 rounded-lg">
              <p class="text-xs font-semibold text-indigo-600">Feedback:</p>
              <p class="text-sm">{{ log.feedback }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import axios from '../../plugins/axios'
import { useToast } from 'vue-toastification'

const route = useRoute()
const toast = useToast()

const student = ref(null)
const logbooks = ref([])
const stats = ref({})
const loading = ref(false)

const fetchDetail = async () => {
  loading.value = true
  try {
    const id = route.params.id
    const res = await axios.get(`/perusahaan/progress/${id}`)
    const data = res.data.data || res.data
    student.value = data.student
    logbooks.value = data.logbooks || []
    stats.value = data.stats || {}
  } catch (error) {
    console.error('Fetch detail error:', error)
    toast.error('Gagal memuat data')
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchDetail()
})
</script>