<template>
  <div class="space-y-6"><div class="bg-gradient-to-r from-blue-600 to-cyan-600 rounded-2xl p-6 text-white"><h1 class="text-2xl font-bold">Dashboard Guru</h1><p>Selamat datang, {{ authStore.user?.name }}</p></div>
    <div class="grid grid-cols-1 md:grid-cols-4 gap-6"><div class="bg-white rounded-xl p-6 shadow-sm"><p class="text-gray-500">Total Siswa</p><p class="text-3xl font-bold">{{ stats.students }}</p></div><div class="bg-white rounded-xl p-6 shadow-sm"><p class="text-gray-500">Hadir Hari Ini</p><p class="text-3xl font-bold text-green-600">{{ stats.present_today }}</p></div><div class="bg-white rounded-xl p-6 shadow-sm"><p class="text-gray-500">Logbook Perlu Review</p><p class="text-3xl font-bold text-yellow-600">{{ stats.pending_logbooks }}</p></div><div class="bg-white rounded-xl p-6 shadow-sm"><p class="text-gray-500">Izin Menunggu</p><p class="text-3xl font-bold text-orange-600">{{ stats.pending_permissions }}</p></div></div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useAuthStore } from '../../stores/auth'
import axios from '../../plugins/axios'

const authStore = useAuthStore()
const stats = ref({ students: 0, present_today: 0, pending_logbooks: 0, pending_permissions: 0 })

onMounted(async () => { try { const res = await axios.get('/guru/stats'); stats.value = res.data } catch(e) {} })
</script>