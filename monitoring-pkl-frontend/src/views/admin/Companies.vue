<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex justify-between items-center">
      <div>
        <h1 class="text-2xl font-bold text-gray-800">Manajemen Perusahaan</h1>
        <p class="text-gray-500 mt-1">Kelola data perusahaan tempat PKL siswa</p>
      </div>
      <button 
        @click="openModal" 
        class="bg-indigo-600 text-white px-4 py-2 rounded-lg hover:bg-indigo-700 transition flex items-center gap-2"
      >
        <PlusIcon class="w-5 h-5" />
        Tambah Perusahaan
      </button>
    </div>

    <!-- Grid List Perusahaan -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <div v-for="company in companies" :key="company.id" class="bg-white rounded-xl shadow-sm hover:shadow-md transition overflow-hidden">
        <div class="h-28 bg-gradient-to-r from-indigo-500 to-purple-600 relative">
          <div class="absolute bottom-0 left-0 right-0 p-3 bg-gradient-to-t from-black/60 to-transparent">
            <h3 class="text-white font-bold text-lg">{{ company.name }}</h3>
          </div>
        </div>
        <div class="p-4">
          <p class="text-gray-600 text-sm flex items-start gap-2">
            <MapPinIcon class="w-4 h-4 text-gray-400 mt-0.5 flex-shrink-0" />
            <span class="line-clamp-2">{{ company.address }}</span>
          </p>
          <div class="mt-3 flex justify-between items-center">
            <div class="text-sm">
              <span class="text-gray-500">Radius:</span>
              <span class="font-semibold text-indigo-600 ml-1">{{ company.radius }} m</span>
            </div>
            <div class="flex gap-2">
              <button @click="editCompany(company)" class="text-indigo-600 hover:text-indigo-800">
                <PencilSquareIcon class="w-5 h-5" />
              </button>
              <button @click="deleteCompany(company)" class="text-red-600 hover:text-red-800">
                <TrashIcon class="w-5 h-5" />
              </button>
            </div>
          </div>
          <div class="mt-2 text-xs text-gray-400">
            📍 {{ company.latitude }}, {{ company.longitude }}
          </div>
        </div>
      </div>
    </div>

    <!-- Modal Form Tambah/Edit Perusahaan -->
    <div v-if="showModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
      <div class="bg-white rounded-xl w-full max-w-4xl max-h-[90vh] overflow-y-auto">
        <!-- Modal Header -->
        <div class="sticky top-0 bg-white p-4 border-b flex justify-between items-center">
          <h2 class="text-xl font-bold">{{ isEdit ? 'Edit Perusahaan' : 'Tambah Perusahaan' }}</h2>
          <button @click="closeModal" class="text-gray-400 hover:text-gray-600">
            <XMarkIcon class="w-6 h-6" />
          </button>
        </div>
        
        <!-- Form Body -->
        <form @submit.prevent="saveCompany" class="p-6">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            
            <!-- Kolom Kiri - Input Form -->
            <div class="space-y-4">
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Nama Perusahaan</label>
                <input 
                  v-model="form.name" 
                  type="text" 
                  class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent" 
                  required
                  placeholder="Contoh: PT. Teknologi Nusantara"
                >
              </div>
              
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Alamat Lengkap</label>
                <textarea 
                  v-model="form.address" 
                  rows="3" 
                  class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent" 
                  required
                  placeholder="Jl. Contoh No. 123, Kota, Provinsi"
                ></textarea>
              </div>
              
              <div class="grid grid-cols-2 gap-3">
                <div>
                  <label class="block text-sm font-medium text-gray-700 mb-1">Latitude</label>
                  <input 
                    v-model="form.latitude" 
                    type="number" 
                    step="any" 
                    class="w-full px-3 py-2 border border-gray-300 rounded-lg bg-gray-50" 
                    readonly
                  >
                </div>
                <div>
                  <label class="block text-sm font-medium text-gray-700 mb-1">Longitude</label>
                  <input 
                    v-model="form.longitude" 
                    type="number" 
                    step="any" 
                    class="w-full px-3 py-2 border border-gray-300 rounded-lg bg-gray-50" 
                    readonly
                  >
                </div>
              </div>
              
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Radius Absensi (meter)</label>
                <input 
                  v-model="form.radius" 
                  type="number" 
                  class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent" 
                  required
                  placeholder="Contoh: 100"
                >
                <p class="text-xs text-gray-500 mt-1">Siswa harus berada dalam radius ini untuk bisa melakukan absensi</p>
              </div>
            </div>
            
            <!-- Kolom Kanan - Maps -->
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">Pilih Lokasi di Maps</label>
              
              <!-- Map Container -->
              <div ref="mapContainer" class="h-96 w-full rounded-lg border overflow-hidden bg-gray-100"></div>
              
              <!-- Tools Maps -->
              <div class="mt-3 flex gap-2">
                <input 
                  v-model="searchAddress" 
                  type="text" 
                  placeholder="Cari alamat..." 
                  class="flex-1 px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                  @keyup.enter="searchLocation"
                >
                <button 
                  type="button" 
                  @click="searchLocation" 
                  class="px-3 py-2 bg-gray-100 rounded-lg hover:bg-gray-200 transition"
                >
                  🔍 Cari
                </button>
                <button 
                  type="button" 
                  @click="getCurrentLocation" 
                  class="px-3 py-2 bg-indigo-100 text-indigo-600 rounded-lg hover:bg-indigo-200 transition"
                >
                  📍 Lokasi Saya
                </button>
              </div>
              <div class="mt-2 flex gap-2">
                <button 
                  type="button" 
                  @click="zoomIn" 
                  class="px-2 py-1 bg-gray-100 rounded text-sm hover:bg-gray-200"
                >
                  ➕ Zoom In
                </button>
                <button 
                  type="button" 
                  @click="zoomOut" 
                  class="px-2 py-1 bg-gray-100 rounded text-sm hover:bg-gray-200"
                >
                  ➖ Zoom Out
                </button>
                <button 
                  type="button" 
                  @click="resetView" 
                  class="px-2 py-1 bg-gray-100 rounded text-sm hover:bg-gray-200"
                >
                  🔄 Reset View
                </button>
              </div>
              <p class="text-xs text-gray-500 mt-2">
                💡 <strong>Tips:</strong> Klik pada peta untuk menentukan lokasi perusahaan, atau drag marker untuk menyesuaikan
              </p>
            </div>

          </div>

          <!-- Tombol Submit -->
          <div class="flex justify-end gap-3 mt-6 pt-4 border-t">
            <button 
              type="button" 
              @click="closeModal" 
              class="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition"
            >
              Batal
            </button>
            <button 
              type="submit" 
              class="px-6 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition"
              :disabled="saving"
            >
              {{ saving ? 'Menyimpan...' : (isEdit ? 'Update' : 'Simpan') }}
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, nextTick } from 'vue'
import axios from '../../plugins/axios'
import { useToast } from 'vue-toastification'
import { PlusIcon, PencilSquareIcon, TrashIcon, MapPinIcon, XMarkIcon } from '@heroicons/vue/24/outline'
import L from 'leaflet'

// Fix Leaflet icon issue (important!)
delete L.Icon.Default.prototype._getIconUrl
L.Icon.Default.mergeOptions({
  iconRetinaUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-icon-2x.png',
  iconUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-icon.png',
  shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-shadow.png',
})

const toast = useToast()
const companies = ref([])
const showModal = ref(false)
const isEdit = ref(false)
const saving = ref(false)
const searchAddress = ref('')

const form = ref({
  id: null,
  name: '',
  address: '',
  latitude: -6.5696,
  longitude: 107.7583,
  radius: 100
})

// Map variables
let map = null
let marker = null
let circle = null
const mapContainer = ref(null)

// Initialize Map
const initMap = async () => {
  await nextTick()
  if (!mapContainer.value) {
    console.log('Map container not found')
    return
  }
  
  console.log('Initializing map...', mapContainer.value)
  
  // Destroy existing map if any
  if (map) {
    map.remove()
  }
  
  map = L.map(mapContainer.value).setView([form.value.latitude, form.value.longitude], 15)
  
  L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OSM</a> &copy; <a href="https://carto.com/attributions">CARTO</a>',
    subdomains: 'abcd',
    maxZoom: 19
  }).addTo(map)
  
  // Add draggable marker
  marker = L.marker([form.value.latitude, form.value.longitude], { draggable: true }).addTo(map)
  marker.on('dragend', (e) => {
    const pos = e.target.getLatLng()
    form.value.latitude = pos.lat
    form.value.longitude = pos.lng
    updateCircle()
    reverseGeocode(pos.lat, pos.lng)
  })
  
  // Add circle radius
  updateCircle()
  
  // Click on map to set location
  map.on('click', (e) => {
    form.value.latitude = e.latlng.lat
    form.value.longitude = e.latlng.lng
    marker.setLatLng(e.latlng)
    updateCircle()
    reverseGeocode(e.latlng.lat, e.latlng.lng)
  })
  
  console.log('Map initialized successfully')
}

const updateCircle = () => {
  if (circle) {
    map.removeLayer(circle)
  }
  circle = L.circle([form.value.latitude, form.value.longitude], {
    radius: form.value.radius,
    color: '#4F46E5',
    fillColor: '#4F46E5',
    fillOpacity: 0.1,
    weight: 2
  }).addTo(map)
}

const reverseGeocode = async (lat, lng) => {
  try {
    const response = await fetch(`https://nominatim.openstreetmap.org/reverse?format=json&lat=${lat}&lon=${lng}&zoom=18&addressdetails=1`)
    const data = await response.json()
    if (data.display_name) {
      form.value.address = data.display_name
    }
  } catch (error) {
    console.error('Reverse geocoding error:', error)
  }
}

const searchLocation = async () => {
  if (!searchAddress.value) {
    toast.warning('Masukkan alamat yang ingin dicari')
    return
  }
  
  try {
    const response = await fetch(`https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(searchAddress.value)}&limit=1`)
    const data = await response.json()
    
    if (data.length > 0) {
      form.value.latitude = parseFloat(data[0].lat)
      form.value.longitude = parseFloat(data[0].lon)
      form.value.address = data[0].display_name
      
      map.setView([form.value.latitude, form.value.longitude], 15)
      marker.setLatLng([form.value.latitude, form.value.longitude])
      updateCircle()
      toast.success('Lokasi ditemukan')
    } else {
      toast.warning('Lokasi tidak ditemukan')
    }
  } catch (error) {
    console.error('Search error:', error)
    toast.error('Gagal mencari lokasi')
  }
}

const getCurrentLocation = () => {
  if (!navigator.geolocation) {
    toast.error('Browser tidak mendukung geolocation')
    return
  }
  
  navigator.geolocation.getCurrentPosition(
    (pos) => {
      form.value.latitude = pos.coords.latitude
      form.value.longitude = pos.coords.longitude
      map.setView([pos.coords.latitude, pos.coords.longitude], 15)
      marker.setLatLng([pos.coords.latitude, pos.coords.longitude])
      updateCircle()
      reverseGeocode(pos.coords.latitude, pos.coords.longitude)
      toast.success('Lokasi berhasil diambil')
    },
    () => {
      toast.error('Gagal mengambil lokasi. Pastikan GPS aktif dan izinkan akses lokasi.')
    }
  )
}

const zoomIn = () => {
  if (map) map.zoomIn()
}

const zoomOut = () => {
  if (map) map.zoomOut()
}

const resetView = () => {
  if (map) map.setView([form.value.latitude, form.value.longitude], 15)
}

// CRUD Operations
const fetchCompanies = async () => {
  try {
    console.log('Fetching companies...')
    const token = localStorage.getItem('token')
    console.log('Token:', token)
    
    const res = await axios.get('/companies')
    console.log('Response:', res.data)
    companies.value = res.data
  } catch (error) {
    console.error('Fetch companies error:', error)
    console.error('Error response:', error.response)
    toast.error(error.response?.data?.message || 'Gagal memuat data perusahaan')
  }
}

const openModal = async () => {
  isEdit.value = false
  saving.value = false
  form.value = {
    id: null,
    name: '',
    address: '',
    latitude: -6.5696,
    longitude: 107.7583,
    radius: 100
  }
  searchAddress.value = ''
  showModal.value = true
  
  // Wait for modal to render, then init map
  setTimeout(async () => {
    await initMap()
  }, 300)
}

const editCompany = async (company) => {
  isEdit.value = true
  saving.value = false
  form.value = { ...company }
  searchAddress.value = ''
  showModal.value = true
  
  setTimeout(async () => {
    await initMap()
    if (map && company.latitude && company.longitude) {
      map.setView([company.latitude, company.longitude], 15)
      marker.setLatLng([company.latitude, company.longitude])
      updateCircle()
    }
  }, 300)
}

const closeModal = () => {
  showModal.value = false
  searchAddress.value = ''
  if (map) {
    map.remove()
    map = null
    marker = null
    circle = null
  }
}

const saveCompany = async () => {
  saving.value = true
  try {
    if (isEdit.value) {
      await axios.put(`/companies/${form.value.id}`, form.value)
      toast.success('Perusahaan berhasil diupdate')
    } else {
      await axios.post('/companies', form.value)
      toast.success('Perusahaan berhasil ditambahkan')
    }
    closeModal()
    await fetchCompanies()
  } catch (error) {
    console.error('Save company error:', error)
    toast.error(error.response?.data?.message || 'Gagal menyimpan perusahaan')
  } finally {
    saving.value = false
  }
}

const deleteCompany = async (company) => {
  if (confirm(`Apakah Anda yakin ingin menghapus perusahaan "${company.name}"?`)) {
    try {
      await axios.delete(`/companies/${company.id}`)
      toast.success('Perusahaan berhasil dihapus')
      await fetchCompanies()
    } catch (error) {
      console.error('Delete company error:', error)
      toast.error('Gagal menghapus perusahaan')
    }
  }
}

onMounted(() => {
  fetchCompanies()
})

onUnmounted(() => {
  if (map) {
    map.remove()
    map = null
  }
})
</script>

<style scoped>
.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>