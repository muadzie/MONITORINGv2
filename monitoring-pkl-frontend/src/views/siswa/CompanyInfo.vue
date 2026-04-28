<template>
  <div class="space-y-6">
    <!-- Header -->
    <div>
      <h1 class="text-2xl font-bold text-gray-800">Info Perusahaan PKL</h1>
      <p class="text-gray-500 mt-1">Detail perusahaan tempat Anda melaksanakan PKL</p>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="bg-white rounded-2xl shadow-sm p-12 text-center">
      <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-green-600 mx-auto"></div>
      <p class="mt-4 text-gray-500">Memuat data...</p>
    </div>

    <!-- Company Card -->
    <div v-else-if="company" class="bg-white rounded-2xl shadow-sm overflow-hidden">
      <div class="bg-gradient-to-r from-green-600 to-teal-600 px-6 py-4">
        <h2 class="text-xl font-bold text-white">{{ company.name }}</h2>
      </div>
      <div class="p-6 space-y-4">
        <div class="flex items-start gap-3">
          <MapPinIcon class="w-5 h-5 text-gray-400 mt-0.5" />
          <div>
            <p class="text-sm font-medium text-gray-700">Alamat</p>
            <p class="text-gray-600">{{ company.address || '-' }}</p>
          </div>
        </div>
        <div class="flex items-start gap-3">
          <svg class="w-5 h-5 text-gray-400 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
          </svg>
          <div>
            <p class="text-sm font-medium text-gray-700">Radius Absensi</p>
            <p class="text-gray-600">{{ company.radius || 100 }} meter</p>
            <p class="text-xs text-gray-500 mt-1">Anda harus berada dalam radius ini untuk melakukan absensi</p>
          </div>
        </div>
        <div class="flex items-start gap-3">
          <svg class="w-5 h-5 text-gray-400 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 20l-5.447-2.724A1 1 0 013 16.382V5.618a1 1 0 011.447-.894L9 7m0 13l6-3m-6 3V7m6 10l4.553 2.276A1 1 0 0021 18.382V7.618a1 1 0 00-.553-.894L15 4m0 13V4m0 0L9 7"></path>
          </svg>
          <div>
            <p class="text-sm font-medium text-gray-700">Koordinat</p>
            <p class="text-gray-600">Latitude: {{ company.latitude }}, Longitude: {{ company.longitude }}</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Empty State -->
    <div v-else-if="!loading && !company" class="bg-white rounded-2xl shadow-sm p-12 text-center">
      <svg class="w-16 h-16 mx-auto text-gray-300 mb-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path>
      </svg>
      <p class="text-gray-500">Belum ada penempatan PKL</p>
      <p class="text-sm text-gray-400 mt-1">Silakan hubungi admin untuk mendapatkan penempatan</p>
    </div>

    <!-- Map Preview -->
    <div v-if="company?.latitude" class="bg-white rounded-2xl shadow-sm overflow-hidden">
      <div class="px-6 py-4 border-b">
        <h3 class="font-semibold text-gray-800">Lokasi Perusahaan</h3>
      </div>
      <div ref="mapContainer" class="h-96 w-full"></div>
    </div>

    <!-- GURU PEMBIMBING (bukan pembimbing perusahaan) -->
    <div class="bg-white rounded-2xl shadow-sm p-6">
      <h3 class="font-semibold text-gray-800 mb-4">Guru Pembimbing PKL</h3>
      <div v-if="guruPembimbing" class="flex items-center gap-4">
        <div class="w-12 h-12 bg-purple-100 rounded-full flex items-center justify-center">
          <svg class="w-6 h-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path>
          </svg>
        </div>
        <div>
          <p class="font-medium text-gray-800">{{ guruPembimbing.name }}</p>
          <p class="text-sm text-gray-500">{{ guruPembimbing.email || '-' }}</p>
          <p class="text-sm text-gray-500">{{ guruPembimbing.phone || '-' }}</p>
          <p class="text-sm text-gray-500 mt-1">Mata Pelajaran: {{ guruPembimbing.mata_pelajaran || '-' }}</p>
          <p class="text-sm text-gray-500">NIP: {{ guruPembimbing.nip || '-' }}</p>
        </div>
      </div>
      <div v-else class="flex flex-col items-center py-6 text-center">
        <svg class="w-12 h-12 text-gray-300 mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path>
        </svg>
        <p class="text-gray-500">Belum ditentukan</p>
        <p class="text-sm text-gray-400 mt-1">Guru pembimbing akan ditentukan oleh admin</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, nextTick } from 'vue'
import axios from '../../plugins/axios'
import { MapPinIcon } from '@heroicons/vue/24/outline'
import L from 'leaflet'
import 'leaflet/dist/leaflet.css'

// Fix Leaflet icon issue
delete L.Icon.Default.prototype._getIconUrl
L.Icon.Default.mergeOptions({
  iconRetinaUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-icon-2x.png',
  iconUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-icon.png',
  shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-shadow.png',
})

const company = ref(null)
const guruPembimbing = ref(null)
const loading = ref(false)
const mapContainer = ref(null)
let map = null

// Ambil data dari API
const fetchData = async () => {
  loading.value = true
  try {
    console.log('🟡 Mengambil data dari /siswa/company...')
    const res = await axios.get('/siswa/company')
    console.log('📦 Response:', res.data)
    
    if (res.data) {
      // Set data perusahaan
      if (res.data.company) {
        company.value = res.data.company
        console.log('📍 Perusahaan:', company.value.name)
        console.log('📍 Koordinat:', company.value.latitude, company.value.longitude)
      }
      
      // Set guru pembimbing
      if (res.data.guru_pembimbing) {
        guruPembimbing.value = res.data.guru_pembimbing
        console.log('✅ Guru pembimbing:', guruPembimbing.value.name)
      } else {
        console.warn('⚠️ Guru pembimbing belum ditentukan')
      }
    }
  } catch (error) {
    console.error('❌ Error:', error.response?.data || error.message)
  } finally {
    loading.value = false
  }
}

// Inisialisasi Map
const initMap = () => {
  if (!company.value) {
    console.warn('⚠️ Tidak ada data perusahaan')
    return
  }
  
  if (!mapContainer.value) {
    console.warn('⚠️ Map container tidak ditemukan')
    return
  }
  
  if (!company.value.latitude || !company.value.longitude) {
    console.error('❌ Koordinat tidak valid:', company.value.latitude, company.value.longitude)
    return
  }
  
  console.log('🗺️ Membuat map di:', company.value.latitude, company.value.longitude)
  
  if (map) map.remove()
  
  map = L.map(mapContainer.value).setView([company.value.latitude, company.value.longitude], 15)
  
  L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(map)
  
  // Add marker
  L.marker([company.value.latitude, company.value.longitude])
    .addTo(map)
    .bindPopup(`<b>${company.value.name}</b><br>${company.value.address}`)
    .openPopup()
  
  // Add circle radius
  L.circle([company.value.latitude, company.value.longitude], {
    radius: company.value.radius || 100,
    color: '#10b981',
    fillColor: '#10b981',
    fillOpacity: 0.1,
    weight: 2
  }).addTo(map)
  
  // Force resize setelah map dibuat
  setTimeout(() => {
    if (map) map.invalidateSize()
  }, 100)
}

// Watch untuk koordinat
import { watch } from 'vue'
watch(company, (newVal) => {
  if (newVal?.latitude && newVal?.longitude) {
    nextTick(() => initMap())
  }
})

onMounted(async () => {
  await fetchData()
  
  // Jika data sudah ada, init map
  if (company.value?.latitude) {
    nextTick(() => initMap())
  }
})

onUnmounted(() => {
  if (map) map.remove()
})
</script>