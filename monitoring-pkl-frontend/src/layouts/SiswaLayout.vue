<template>
  <div class="min-h-screen bg-gray-100">
    <aside class="fixed left-0 top-0 w-64 h-full bg-white shadow-lg">
      <div class="p-4 border-b"><h1 class="text-xl font-bold text-green-600">Siswa Panel</h1><p class="text-xs text-gray-500">Monitoring PKL</p></div>
      <nav class="p-4 space-y-1">
        <router-link to="/siswa/dashboard" class="flex items-center space-x-3 px-4 py-2 rounded-lg hover:bg-green-50">📊 Dashboard</router-link>
        <router-link to="/siswa/attendance" class="flex items-center space-x-3 px-4 py-2 rounded-lg hover:bg-green-50">📍 Absensi</router-link>
        <router-link to="/siswa/logbook" class="flex items-center space-x-3 px-4 py-2 rounded-lg hover:bg-green-50">📝 Logbook</router-link>
        <router-link to="/siswa/permission" class="flex items-center space-x-3 px-4 py-2 rounded-lg hover:bg-green-50">📄 Izin</router-link>
      </nav>
      <div class="absolute bottom-0 w-64 p-4 border-t"><button @click="logout" class="flex items-center space-x-3 text-red-600">🚪 Logout</button></div>
    </aside>
    <div class="ml-64">
      <header class="bg-white shadow-sm px-6 py-4"><h2 class="text-xl font-semibold">{{ title }}</h2></header>
      <main class="p-6"><router-view /></main>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth'

const route = useRoute(), router = useRouter(), authStore = useAuthStore()
const title = computed(() => route.path.split('/').pop() || 'Dashboard')
const logout = async () => { await authStore.logout(); router.push('/login') }
</script>