<template>
  <div class="space-y-6">
    <!-- Welcome Banner -->
    <div class="relative overflow-hidden rounded-2xl bg-gradient-to-r from-indigo-600 via-purple-600 to-pink-600 p-8 text-white">
      <div class="relative z-10">
        <h1 class="text-2xl font-bold">Selamat Datang, {{ authStore.user?.name }}!</h1>
        <p class="mt-2 opacity-90">Sistem Monitoring PKL SMKN 1 Subang</p>
        <div class="mt-4 flex gap-4">
          <div class="bg-white/20 backdrop-blur-sm rounded-xl px-4 py-2">
            <p class="text-xs opacity-75">Periode PKL</p>
            <p class="font-semibold">Januari - Maret 2026</p>
          </div>
          <div class="bg-white/20 backdrop-blur-sm rounded-xl px-4 py-2">
            <p class="text-xs opacity-75">Minggu ke-</p>
            <p class="font-semibold">12</p>
          </div>
        </div>
      </div>
      <div class="absolute top-0 right-0 w-64 h-64 bg-white/10 rounded-full -mr-32 -mt-32"></div>
      <div class="absolute bottom-0 left-0 w-48 h-48 bg-white/10 rounded-full -ml-24 -mb-24"></div>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
      <div class="stat-card bg-white rounded-2xl p-6 shadow-sm hover:shadow-xl transition-all duration-300 group">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-gray-500 text-sm">Total Siswa</p>
            <p class="text-3xl font-bold text-gray-800">{{ stats.total_students || 0 }}</p>
            <p class="text-xs text-green-600 mt-1">+12% dari bulan lalu</p>
          </div>
          <div class="w-12 h-12 bg-indigo-100 rounded-xl flex items-center justify-center group-hover:scale-110 transition">
            <AcademicCapIcon class="w-6 h-6 text-indigo-600" />
          </div>
        </div>
        <div class="mt-4 h-1 bg-gray-100 rounded-full overflow-hidden">
          <div class="w-3/4 h-full bg-indigo-600 rounded-full"></div>
        </div>
      </div>

      <div class="stat-card bg-white rounded-2xl p-6 shadow-sm hover:shadow-xl transition-all duration-300 group">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-gray-500 text-sm">Total Guru</p>
            <p class="text-3xl font-bold text-gray-800">{{ stats.total_teachers || 0 }}</p>
            <p class="text-xs text-blue-600 mt-1">Pembimbing PKL</p>
          </div>
          <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center group-hover:scale-110 transition">
            <UserGroupIcon class="w-6 h-6 text-blue-600" />
          </div>
        </div>
      </div>

      <div class="stat-card bg-white rounded-2xl p-6 shadow-sm hover:shadow-xl transition-all duration-300 group">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-gray-500 text-sm">Perusahaan</p>
            <p class="text-3xl font-bold text-gray-800">{{ stats.total_companies || 0 }}</p>
            <p class="text-xs text-purple-600 mt-1">Mitra PKL</p>
          </div>
          <div class="w-12 h-12 bg-purple-100 rounded-xl flex items-center justify-center group-hover:scale-110 transition">
            <BuildingOffice2Icon class="w-6 h-6 text-purple-600" />
          </div>
        </div>
      </div>

      <div class="stat-card bg-white rounded-2xl p-6 shadow-sm hover:shadow-xl transition-all duration-300 group">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-gray-500 text-sm">Total Logbook</p>
            <p class="text-3xl font-bold text-gray-800">{{ stats.total_logbooks || 0 }}</p>
            <p class="text-xs text-yellow-600 mt-1">Perlu review: {{ stats.pending_logbooks || 0 }}</p>
          </div>
          <div class="w-12 h-12 bg-yellow-100 rounded-xl flex items-center justify-center group-hover:scale-110 transition">
            <BookOpenIcon class="w-6 h-6 text-yellow-600" />
          </div>
        </div>
      </div>
    </div>

    <!-- Charts Row -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <div class="bg-white rounded-2xl p-6 shadow-sm">
        <div class="flex justify-between items-center mb-4">
          <h3 class="font-semibold text-gray-800">Statistik Kehadiran</h3>
          <select class="text-sm border rounded-lg px-3 py-1">
            <option>Bulan Ini</option>
            <option>Bulan Lalu</option>
          </select>
        </div>
        <div class="space-y-3">
          <div v-for="stat in attendanceStats" :key="stat.label" class="flex items-center gap-3">
            <div class="w-24 text-sm text-gray-600">{{ stat.label }}</div>
            <div class="flex-1 h-2 bg-gray-100 rounded-full overflow-hidden">
              <div class="h-full rounded-full" :style="{ width: stat.percentage + '%', backgroundColor: stat.color }"></div>
            </div>
            <div class="w-12 text-sm font-semibold">{{ stat.value }}</div>
          </div>
        </div>
      </div>

      <div class="bg-white rounded-2xl p-6 shadow-sm">
        <h3 class="font-semibold text-gray-800 mb-4">Aktivitas Terbaru</h3>
        <div class="space-y-3">
          <div v-for="activity in recentActivities" :key="activity.id" class="flex items-start gap-3 p-3 rounded-xl hover:bg-gray-50 transition">
            <div class="w-2 h-2 mt-2 rounded-full" :class="activity.color"></div>
            <div class="flex-1">
              <p class="text-sm font-medium">{{ activity.description }}</p>
              <p class="text-xs text-gray-500">{{ activity.time }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useAuthStore } from '../../stores/auth'
import axios from '../../plugins/axios'
import { AcademicCapIcon, UserGroupIcon, BuildingOffice2Icon, BookOpenIcon } from '@heroicons/vue/24/outline'

const authStore = useAuthStore()
const stats = ref({})
const attendanceStats = ref([
  { label: 'Hadir', value: 0, percentage: 0, color: '#10b981' },
  { label: 'Terlambat', value: 0, percentage: 0, color: '#f59e0b' },
  { label: 'Alpha', value: 0, percentage: 0, color: '#ef4444' },
  { label: 'Sakit', value: 0, percentage: 0, color: '#3b82f6' },
  { label: 'Izin', value: 0, percentage: 0, color: '#8b5cf6' }
])
const recentActivities = ref([])

onMounted(async () => {
  try {
    const res = await axios.get('/admin/dashboard/stats')
    stats.value = res.data
  } catch (error) {
    console.error('Failed to load stats:', error)
  }
})
</script>