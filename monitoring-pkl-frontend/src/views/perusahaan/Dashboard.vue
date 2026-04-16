<template>
  <div class="space-y-6"><div class="bg-gradient-to-r from-purple-600 to-pink-600 rounded-2xl p-6 text-white"><h1 class="text-2xl font-bold">Dashboard Perusahaan</h1><p>Selamat datang, {{ authStore.user?.name }}</p></div>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6"><div class="bg-white rounded-xl p-6 shadow-sm"><p class="text-gray-500">Total Siswa Magang</p><p class="text-3xl font-bold">{{ stats.students }}</p></div><div class="bg-white rounded-xl p-6 shadow-sm"><p class="text-gray-500">Total Logbook</p><p class="text-3xl font-bold text-purple-600">{{ stats.logbooks }}</p></div><div class="bg-white rounded-xl p-6 shadow-sm"><p class="text-gray-500">Perlu Dinilai</p><p class="text-3xl font-bold text-yellow-600">{{ stats.pending_assessment }}</p></div></div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useAuthStore } from '../../stores/auth'
import axios from '../../plugins/axios'

const authStore = useAuthStore()
const stats = ref({ students: 0, logbooks: 0, pending_assessment: 0 })

onMounted(async () => { try { const res = await axios.get('/perusahaan/stats'); stats.value = res.data } catch(e) {} })
</script>