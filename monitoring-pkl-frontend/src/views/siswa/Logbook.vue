<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
      <div>
        <h1 class="text-2xl font-bold text-gray-800">Logbook PKL</h1>
        <p class="text-gray-500 mt-1">Catat kegiatan harian Anda selama PKL</p>
      </div>
      <button 
        @click="openModal" 
        class="bg-gradient-to-r from-green-600 to-teal-600 text-white px-5 py-2.5 rounded-xl hover:shadow-lg transition-all duration-300 hover:scale-105 flex items-center gap-2"
      >
        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
        </svg>
        + Buat Logbook
      </button>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
      <div class="bg-gradient-to-br from-blue-500 to-blue-700 rounded-xl p-5 text-white shadow-lg">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Total Logbook</p>
            <p class="text-3xl font-bold mt-1">{{ logbooks.length }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
            </svg>
          </div>
        </div>
      </div>
      <div class="bg-gradient-to-br from-yellow-500 to-yellow-700 rounded-xl p-5 text-white shadow-lg">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Menunggu Review</p>
            <p class="text-3xl font-bold mt-1">{{ pendingCount }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
          </div>
        </div>
      </div>
      <div class="bg-gradient-to-br from-green-500 to-green-700 rounded-xl p-5 text-white shadow-lg">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Disetujui</p>
            <p class="text-3xl font-bold mt-1">{{ approvedCount }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
            </svg>
          </div>
        </div>
      </div>
      <div class="bg-gradient-to-br from-red-500 to-red-700 rounded-xl p-5 text-white shadow-lg">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm opacity-90">Ditolak</p>
            <p class="text-3xl font-bold mt-1">{{ rejectedCount }}</p>
          </div>
          <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
            </svg>
          </div>
        </div>
      </div>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="flex justify-center py-12">
      <div class="text-center">
        <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-green-600 mx-auto"></div>
        <p class="mt-4 text-gray-500">Memuat logbook...</p>
      </div>
    </div>

    <!-- Logbook List -->
    <div v-else-if="logbooks.length > 0" class="space-y-4">
      <div v-for="log in logbooks" :key="log.id" class="bg-white rounded-xl shadow-md hover:shadow-lg transition-all duration-300 overflow-hidden border border-gray-100">
        <div class="p-5">
          <div class="flex flex-col md:flex-row justify-between gap-4">
            <!-- Kiri: Informasi -->
            <div class="flex-1">
              <div class="flex items-center gap-2 mb-2">
                <div class="w-8 h-8 bg-gradient-to-br from-green-100 to-teal-100 rounded-full flex items-center justify-center text-green-600 font-bold text-sm">
                  {{ log.activity?.charAt(0) || 'L' }}
                </div>
                <h3 class="font-semibold text-gray-800 text-lg">{{ log.activity }}</h3>
              </div>
              <p class="text-sm text-gray-500 flex items-center gap-2 mb-3">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                </svg>
                {{ formatDate(log.date) }}
              </p>
              <p class="text-gray-600 leading-relaxed">{{ log.description || '-' }}</p>
              
              <!-- Attachment -->
              <div v-if="log.attachment" class="mt-3">
                <a :href="log.attachment_url" target="_blank" class="inline-flex items-center gap-2 text-sm text-blue-600 hover:text-blue-800">
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.172 7l-6.586 6.586a2 2 0 102.828 2.828l6.414-6.586a4 4 0 00-5.656-5.656l-6.415 6.585a6 6 0 108.486 8.486L20.5 13"></path>
                  </svg>
                  Lihat Lampiran
                </a>
              </div>
              
              <!-- Feedback -->
              <div v-if="log.feedback" class="mt-3 p-3 bg-blue-50 rounded-lg">
                <p class="text-sm font-semibold text-blue-800 flex items-center gap-1">
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z"></path>
                  </svg>
                  Feedback:
                </p>
                <p class="text-sm text-gray-700 mt-1">{{ log.feedback }}</p>
              </div>
            </div>
            
            <!-- Kanan: Status & Aksi -->
            <div class="md:text-right">
              <span :class="getStatusClass(log.status)" class="inline-flex items-center gap-1 px-3 py-1.5 rounded-full text-xs font-semibold">
                <span class="w-1.5 h-1.5 rounded-full" :class="getStatusDotClass(log.status)"></span>
                {{ getStatusText(log.status) }}
              </span>
              <div v-if="log.grade" class="mt-2">
                <span class="text-2xl font-bold text-yellow-600">{{ log.grade }}</span>
                <span class="text-xs text-gray-500">/100</span>
              </div>
              
              <!-- Action Buttons (only for pending) -->
              <div v-if="log.status === 'pending'" class="flex md:justify-end gap-2 mt-3">
                <button @click="editLogbook(log)" class="p-2 text-indigo-600 hover:bg-indigo-50 rounded-lg transition" title="Edit">
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"></path>
                  </svg>
                </button>
                <button @click="deleteLogbook(log)" class="p-2 text-red-600 hover:bg-red-50 rounded-lg transition" title="Hapus">
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                  </svg>
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Empty State -->
    <div v-else-if="!loading && logbooks.length === 0" class="bg-white rounded-xl p-12 text-center">
      <svg class="w-20 h-20 mx-auto text-gray-300 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
      </svg>
      <p class="text-gray-500 text-lg">Belum ada logbook</p>
      <p class="text-sm text-gray-400 mt-1">Catat kegiatan harian PKL Anda</p>
      <button @click="openModal" class="mt-4 px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 transition">Buat Logbook Pertama</button>
    </div>

    <!-- Modal Tambah/Edit Logbook -->
    <div v-if="showModal" class="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50" @click.self="closeModal">
      <div class="bg-white rounded-2xl w-full max-w-lg max-h-[90vh] overflow-y-auto animate-fade-in-up shadow-2xl">
        <div class="sticky top-0 bg-white p-5 border-b rounded-t-2xl">
          <div class="flex justify-between items-center">
            <div class="flex items-center gap-3">
              <div class="w-10 h-10 bg-gradient-to-br from-green-600 to-teal-600 rounded-xl flex items-center justify-center shadow-lg">
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                </svg>
              </div>
              <div>
                <h3 class="text-xl font-bold text-gray-800">{{ isEdit ? 'Edit Logbook' : 'Buat Logbook Baru' }}</h3>
                <p class="text-sm text-gray-500">{{ isEdit ? 'Ubah kegiatan harian' : 'Catat kegiatan harian PKL Anda' }}</p>
              </div>
            </div>
            <button @click="closeModal" class="text-gray-400 hover:text-gray-600 transition">
              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
              </svg>
            </button>
          </div>
        </div>

        <form @submit.prevent="submitLogbook" class="p-6 space-y-4">
          <div>
            <label class="block text-sm font-semibold text-gray-700 mb-1">Tanggal <span class="text-red-500">*</span></label>
            <input v-model="form.date" type="date" class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent" required>
          </div>
          
          <div>
            <label class="block text-sm font-semibold text-gray-700 mb-1">Kegiatan <span class="text-red-500">*</span></label>
            <input v-model="form.activity" type="text" class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent" placeholder="Contoh: Membuat program absensi" required>
          </div>
          
          <div>
            <label class="block text-sm font-semibold text-gray-700 mb-1">Deskripsi</label>
            <textarea v-model="form.description" rows="4" class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent" placeholder="Deskripsi kegiatan secara detail..."></textarea>
          </div>
          
          <div>
            <label class="block text-sm font-semibold text-gray-700 mb-1">Lampiran</label>
            <div class="border-2 border-dashed border-gray-300 rounded-lg p-4 text-center cursor-pointer hover:border-green-500 transition" @click="$refs.fileInput.click()">
              <input type="file" ref="fileInput" class="hidden" accept=".jpg,.jpeg,.png,.pdf,.doc,.docx" @change="handleFile">
              <div class="flex flex-col items-center gap-2">
                <svg class="w-8 h-8 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                </svg>
                <p class="text-sm text-gray-500">{{ selectedFileName || 'Klik untuk upload file (opsional)' }}</p>
                <p class="text-xs text-gray-400">JPG, PNG, PDF, DOC, DOCX (Max 5MB)</p>
              </div>
            </div>
          </div>

          <div class="flex justify-end gap-3 pt-4 border-t">
            <button type="button" @click="closeModal" class="px-5 py-2.5 border border-gray-300 rounded-lg hover:bg-gray-50 transition font-medium">Batal</button>
            <button type="submit" class="px-6 py-2.5 bg-gradient-to-r from-green-600 to-teal-600 text-white rounded-lg hover:shadow-lg transition-all font-medium" :disabled="saving">
              {{ saving ? 'Menyimpan...' : (isEdit ? 'Update' : 'Simpan') }}
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import axios from '../../plugins/axios'
import { useToast } from 'vue-toastification'

const toast = useToast()

// State
const logbooks = ref([])
const loading = ref(false)
const saving = ref(false)
const showModal = ref(false)
const isEdit = ref(false)
const selectedFile = ref(null)
const selectedFileName = ref('')

const form = ref({
  id: null,
  date: new Date().toISOString().split('T')[0],
  activity: '',
  description: '',
  attachment: null
})

// Computed
const pendingCount = computed(() => logbooks.value.filter(l => l.status === 'pending').length)
const approvedCount = computed(() => logbooks.value.filter(l => l.status === 'approved').length)
const rejectedCount = computed(() => logbooks.value.filter(l => l.status === 'rejected').length)

// Helper functions
const formatDate = (date) => {
  if (!date) return '-'
  return new Date(date).toLocaleDateString('id-ID', { day: 'numeric', month: 'long', year: 'numeric' })
}

const getStatusText = (status) => {
  const map = { pending: 'Menunggu Review', approved: 'Disetujui', rejected: 'Ditolak' }
  return map[status] || status
}

const getStatusClass = (status) => {
  const map = {
    pending: 'bg-yellow-100 text-yellow-800',
    approved: 'bg-green-100 text-green-800',
    rejected: 'bg-red-100 text-red-800'
  }
  return map[status] || 'bg-gray-100 text-gray-800'
}

const getStatusDotClass = (status) => {
  const map = {
    pending: 'bg-yellow-500',
    approved: 'bg-green-500',
    rejected: 'bg-red-500'
  }
  return map[status] || 'bg-gray-500'
}

// Fetch data
const fetchLogbooks = async () => {
  loading.value = true
  try {
    const res = await axios.get('/siswa/logbooks')
    logbooks.value = res.data.data || res.data || []
    console.log('Logbooks loaded:', logbooks.value.length)
  } catch (error) {
    console.error('Fetch error:', error)
    toast.error('Gagal memuat data logbook')
  } finally {
    loading.value = false
  }
}

// File handling
const handleFile = (e) => {
  const file = e.target.files[0]
  if (file) {
    const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document']
    const maxSize = 5 * 1024 * 1024 // 5MB
    
    if (!allowedTypes.includes(file.type)) {
      toast.error('Format file tidak didukung')
      return
    }
    if (file.size > maxSize) {
      toast.error('Ukuran file maksimal 5MB')
      return
    }
    selectedFile.value = file
    selectedFileName.value = file.name
    form.value.attachment = file
  }
}

// Modal operations
const openModal = () => {
  isEdit.value = false
  form.value = {
    id: null,
    date: new Date().toISOString().split('T')[0],
    activity: '',
    description: '',
    attachment: null
  }
  selectedFile.value = null
  selectedFileName.value = ''
  showModal.value = true
}

const editLogbook = (logbook) => {
  isEdit.value = true
  form.value = {
    id: logbook.id,
    date: logbook.date,
    activity: logbook.activity,
    description: logbook.description || '',
    attachment: null
  }
  selectedFile.value = null
  selectedFileName.value = logbook.attachment ? 'File sudah diupload' : ''
  showModal.value = true
}

const closeModal = () => {
  showModal.value = false
  form.value = {
    id: null,
    date: new Date().toISOString().split('T')[0],
    activity: '',
    description: '',
    attachment: null
  }
  selectedFile.value = null
  selectedFileName.value = ''
}

// Submit logbook
const submitLogbook = async () => {
  if (!form.value.date) {
    toast.error('Tanggal harus diisi')
    return
  }
  if (!form.value.activity) {
    toast.error('Kegiatan harus diisi')
    return
  }
  
  saving.value = true
  const formData = new FormData()
  formData.append('date', form.value.date)
  formData.append('activity', form.value.activity)
  formData.append('description', form.value.description || '')
  if (selectedFile.value) {
    formData.append('attachment', selectedFile.value)
  }
  
  try {
    if (isEdit.value) {
      formData.append('_method', 'PUT')
      await axios.post(`/siswa/logbooks/${form.value.id}`, formData, {
        headers: { 'Content-Type': 'multipart/form-data' }
      })
      toast.success('Logbook berhasil diupdate')
    } else {
      await axios.post('/siswa/logbooks', formData, {
        headers: { 'Content-Type': 'multipart/form-data' }
      })
      toast.success('Logbook berhasil ditambahkan')
    }
    closeModal()
    await fetchLogbooks()
  } catch (error) {
    console.error('Submit error:', error)
    const message = error.response?.data?.message || 'Gagal menyimpan logbook'
    toast.error(message)
  } finally {
    saving.value = false
  }
}

// Delete logbook
const deleteLogbook = async (logbook) => {
  if (!confirm(`Hapus logbook tanggal ${formatDate(logbook.date)}?`)) return
  
  try {
    await axios.delete(`/siswa/logbooks/${logbook.id}`)
    toast.success('Logbook berhasil dihapus')
    await fetchLogbooks()
  } catch (error) {
    console.error('Delete error:', error)
    toast.error(error.response?.data?.message || 'Gagal menghapus logbook')
  }
}

onMounted(() => {
  fetchLogbooks()
})
</script>

<style scoped>
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.animate-fade-in-up {
  animation: fadeInUp 0.3s ease-out;
}
</style>