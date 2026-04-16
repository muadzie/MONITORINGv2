<template>
  <div class="space-y-6">
    <div class="bg-gradient-to-r from-green-600 to-teal-600 rounded-2xl p-6 text-white"><h1 class="text-2xl font-bold">Dashboard Siswa</h1><p>Selamat datang, {{ authStore.user?.name }}</p></div>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
      <div class="bg-white rounded-xl p-6 shadow-sm"><p class="text-gray-500">Kehadiran</p><p class="text-3xl font-bold text-green-600">{{ stats.attendance }}%</p></div>
      <div class="bg-white rounded-xl p-6 shadow-sm"><p class="text-gray-500">Logbook</p><p class="text-3xl font-bold text-blue-600">{{ stats.logbooks }}</p></div>
      <div class="bg-white rounded-xl p-6 shadow-sm"><p class="text-gray-500">Rata-rata Nilai</p><p class="text-3xl font-bold text-purple-600">{{ stats.grade }}</p></div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useAuthStore } from '../../stores/auth'
import axios from '../../plugins/axios'

const authStore = useAuthStore()
const stats = ref({ attendance: 0, logbooks: 0, grade: 0 })

onMounted(async () => {
  try { const res = await axios.get('/siswa/stats'); stats.value = res.data } catch(e) { console.error(e) }
})
</script>