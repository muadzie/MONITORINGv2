<template>
  <div class="min-h-screen bg-gray-100">
    <div class="flex">
      <aside class="w-64 bg-white shadow-lg min-h-screen fixed">
        <div class="p-4 border-b"><h1 class="text-xl font-bold text-purple-600">Perusahaan Panel</h1><p class="text-xs text-gray-500">Monitoring PKL</p></div>
        <nav class="p-4 space-y-1">
          <router-link to="/perusahaan/dashboard" class="flex items-center space-x-3 px-4 py-2 rounded-lg hover:bg-purple-50" active-class="bg-purple-50 text-purple-600"><HomeIcon class="w-5 h-5"/><span>Dashboard</span></router-link>
          <router-link to="/perusahaan/assessment" class="flex items-center space-x-3 px-4 py-2 rounded-lg hover:bg-purple-50" active-class="bg-purple-50 text-purple-600"><StarIcon class="w-5 h-5"/><span>Penilaian</span></router-link>
          <router-link to="/perusahaan/progress" class="flex items-center space-x-3 px-4 py-2 rounded-lg hover:bg-purple-50" active-class="bg-purple-50 text-purple-600"><ChartBarIcon class="w-5 h-5"/><span>Progress Siswa</span></router-link>
        </nav>
        <div class="absolute bottom-0 w-64 p-4 border-t"><button @click="logout" class="flex items-center space-x-3 text-red-600 w-full px-4 py-2 rounded-lg hover:bg-red-50"><ArrowRightOnRectangleIcon class="w-5 h-5"/><span>Logout</span></button></div>
      </aside>
      <main class="ml-64 flex-1"><header class="bg-white shadow-sm px-6 py-4"><h2 class="text-xl font-semibold">{{ $route.path.split('/').pop() || 'Dashboard' }}</h2></header><div class="p-6"><router-view /></div></main>
    </div>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth'
import { HomeIcon, StarIcon, ChartBarIcon, ArrowRightOnRectangleIcon } from '@heroicons/vue/24/outline'
const router = useRouter()
const authStore = useAuthStore()
const logout = async () => { await authStore.logout(); router.push('/login') }
</script>