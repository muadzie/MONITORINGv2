<template>
  <div class="space-y-6">
    <div class="bg-white rounded-xl p-6 shadow-sm"><h1 class="text-2xl font-bold">Absensi PKL</h1><p class="text-gray-500">Lakukan check-in/out sesuai lokasi PKL Anda</p></div>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
      <div class="bg-white rounded-xl p-6 shadow-sm"><div class="text-center p-6"><div class="text-6xl mb-4">{{ statusIcon }}</div><p class="text-xl font-bold">{{ statusText }}</p><p class="text-gray-500 mt-2">{{ todayDate }}</p><div class="mt-6 space-y-3"><button @click="checkIn" :disabled="hasCheckedIn" class="w-full bg-green-600 text-white py-3 rounded-lg">Check In</button><button @click="checkOut" :disabled="!hasCheckedIn || hasCheckedOut" class="w-full bg-red-600 text-white py-3 rounded-lg">Check Out</button></div></div></div>
      <div class="bg-white rounded-xl p-6 shadow-sm"><div ref="mapContainer" class="h-96 w-full rounded-lg"></div><div class="mt-4 p-3 bg-gray-50 rounded-lg"><p class="text-sm">Lokasi Perusahaan: {{ companyName }}</p><p class="text-xs text-gray-500 mt-1">Jarak Anda: {{ distance }} meter (Radius: {{ radius }}m)</p></div></div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import { useAuthStore } from '../../stores/auth'
import axios from '../../plugins/axios'
import { useToast } from 'vue-toastification'
import L from 'leaflet'

const authStore = useAuthStore()
const toast = useToast()
const hasCheckedIn = ref(false)
const hasCheckedOut = ref(false)
const statusText = ref('Belum Absen')
const todayDate = ref(new Date().toLocaleDateString('id-ID'))
const companyName = ref('')
const radius = ref(100)
const distance = ref(0)
let map = null

const statusIcon = computed(() => {
  if (hasCheckedOut.value) return '✅'
  if (hasCheckedIn.value) return '📌'
  return '📍'
})

const checkIn = async () => {
  navigator.geolocation.getCurrentPosition(async (pos) => {
    try { await axios.post('/attendance/check-in', { latitude: pos.coords.latitude, longitude: pos.coords.longitude }); toast.success('Check in berhasil'); hasCheckedIn.value = true; statusText.value = 'Sudah Check In' } catch(e) { toast.error(e.response?.data?.message) }
  }, () => toast.error('Gagal获取 lokasi'))
}

const checkOut = async () => {
  navigator.geolocation.getCurrentPosition(async (pos) => {
    try { await axios.post('/attendance/check-out', { latitude: pos.coords.latitude, longitude: pos.coords.longitude }); toast.success('Check out berhasil'); hasCheckedOut.value = true; statusText.value = 'Selesai' } catch(e) { toast.error(e.response?.data?.message) }
  }, () => toast.error('Gagal获取 lokasi'))
}

onMounted(() => {
  if (authStore.user?.company) { companyName.value = authStore.user.company.name; radius.value = authStore.user.company.radius }
  map = L.map(mapContainer.value).setView([-6.2088, 106.8456], 13); L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map)
  navigator.geolocation.watchPosition((pos) => { if (map) map.setView([pos.coords.latitude, pos.coords.longitude], 15) })
})
onUnmounted(() => { if (map) map.remove() })
</script>