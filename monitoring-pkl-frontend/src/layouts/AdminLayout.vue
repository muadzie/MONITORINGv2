<template>
  <div class="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100">
    <!-- Mobile Menu Button -->
    <div class="lg:hidden fixed top-4 left-4 z-50">
      <button @click="sidebarOpen = !sidebarOpen" class="p-2 bg-white rounded-xl shadow-lg">
        <Bars3Icon class="w-6 h-6 text-gray-600" />
      </button>
    </div>

    <!-- Overlay -->
    <div v-if="sidebarOpen" @click="sidebarOpen = false" class="fixed inset-0 bg-black/50 z-40 lg:hidden"></div>

    <!-- Sidebar -->
    <aside 
      :class="[
        'fixed left-0 top-0 z-40 h-screen w-72 bg-white shadow-2xl transition-all duration-300',
        sidebarOpen ? 'translate-x-0' : '-translate-x-full lg:translate-x-0'
      ]"
    >
      <!-- Logo Area -->
      <div class="p-6 border-b border-gray-100">
        <div class="flex items-center gap-3">
          <div class="w-10 h-10 bg-gradient-to-br from-indigo-600 to-purple-600 rounded-xl flex items-center justify-center shadow-lg">
            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
            </svg>
          </div>
          <div>
            <h1 class="text-xl font-bold text-gray-800">Monitoring PKL</h1>
            <p class="text-xs text-gray-500">SMKN 1 Subang</p>
          </div>
        </div>
      </div>

      <!-- User Profile -->
      <div class="p-6 border-b border-gray-100 bg-gradient-to-r from-indigo-50 to-purple-50">
        <div class="flex items-center gap-3">
          <div class="relative">
            <div class="w-12 h-12 bg-gradient-to-br from-indigo-600 to-purple-600 rounded-xl flex items-center justify-center text-white font-bold text-lg shadow-md">
              {{ authStore.user?.name?.charAt(0) || 'A' }}
            </div>
            <div class="absolute -bottom-1 -right-1 w-4 h-4 bg-green-500 rounded-full border-2 border-white"></div>
          </div>
          <div>
            <p class="font-semibold text-gray-800">{{ authStore.user?.name }}</p>
            <p class="text-xs text-gray-500">{{ authStore.role }}</p>
          </div>
        </div>
      </div>

      <!-- Navigation -->
      <nav class="flex-1 px-4 py-6 space-y-1 overflow-y-auto h-[calc(100vh-200px)]">
        <p class="px-4 text-xs font-semibold text-gray-400 uppercase tracking-wider mb-3">MAIN MENU</p>
        
        <router-link 
          v-for="item in menuItems" 
          :key="item.path"
          :to="item.path"
          @click="sidebarOpen = false"
          class="group flex items-center gap-3 px-4 py-3 rounded-xl transition-all duration-200"
          :class="[
            $route.path === item.path 
              ? 'bg-gradient-to-r from-indigo-600 to-purple-600 text-white shadow-lg' 
              : 'text-gray-600 hover:bg-gray-100'
          ]"
        >
          <component :is="item.icon" class="w-5 h-5" />
          <span class="text-sm font-medium">{{ item.name }}</span>
          <span v-if="item.badge" class="ml-auto text-xs bg-white/20 px-2 py-0.5 rounded-full">{{ item.badge }}</span>
        </router-link>
      </nav>

      <!-- Footer -->
      <div class="absolute bottom-0 left-0 right-0 p-4 border-t border-gray-100 bg-white">
        <button 
          @click="logout"
          class="w-full flex items-center gap-3 px-4 py-3 rounded-xl text-red-600 hover:bg-red-50 transition-all duration-200 group"
        >
          <ArrowRightOnRectangleIcon class="w-5 h-5" />
          <span class="text-sm font-medium">Logout</span>
        </button>
      </div>
    </aside>

    <!-- Main Content -->
    <div class="lg:ml-72 min-h-screen">
      <!-- Header -->
      <header class="sticky top-0 z-30 bg-white/80 backdrop-blur-lg border-b border-gray-100">
        <div class="flex items-center justify-between px-6 py-4">
          <div class="flex items-center gap-4">
            <button @click="sidebarOpen = true" class="lg:hidden p-2 rounded-lg hover:bg-gray-100">
              <Bars3Icon class="w-5 h-5 text-gray-600" />
            </button>
            <div>
              <h2 class="text-xl font-bold text-gray-800">{{ pageTitle }}</h2>
              <p class="text-sm text-gray-500">{{ pageDescription }}</p>
            </div>
          </div>
          
          <div class="flex items-center gap-4">
            <!-- Search -->
            <div class="hidden md:flex items-center bg-gray-100 rounded-xl px-4 py-2">
              <MagnifyingGlassIcon class="w-4 h-4 text-gray-400" />
              <input type="text" placeholder="Search..." class="bg-transparent border-none focus:outline-none text-sm ml-2 w-48">
            </div>

            <!-- Notification -->
            <button class="relative p-2 rounded-xl hover:bg-gray-100 transition">
              <BellIcon class="w-5 h-5 text-gray-600" />
              <span class="absolute top-1 right-1 w-2 h-2 bg-red-500 rounded-full"></span>
            </button>

            <!-- Theme Toggle -->
            <button @click="toggleTheme" class="p-2 rounded-xl hover:bg-gray-100 transition">
              <SunIcon v-if="isDark" class="w-5 h-5 text-yellow-500" />
              <MoonIcon v-else class="w-5 h-5 text-gray-600" />
            </button>

            <!-- User Dropdown -->
            <div class="relative">
              <button @click="userMenuOpen = !userMenuOpen" class="flex items-center gap-2 p-1 rounded-xl hover:bg-gray-100 transition">
                <div class="w-8 h-8 bg-gradient-to-br from-indigo-600 to-purple-600 rounded-lg flex items-center justify-center text-white text-sm font-bold">
                  {{ authStore.user?.name?.charAt(0) || 'A' }}
                </div>
                <ChevronDownIcon class="w-4 h-4 text-gray-500" />
              </button>
              
              <div v-if="userMenuOpen" class="absolute right-0 mt-2 w-56 bg-white rounded-xl shadow-xl border border-gray-100 overflow-hidden">
                <div class="p-3 border-b border-gray-100">
                  <p class="font-semibold text-gray-800">{{ authStore.user?.name }}</p>
                  <p class="text-xs text-gray-500">{{ authStore.user?.email }}</p>
                </div>
                <router-link to="/profile" class="flex items-center gap-3 px-4 py-3 hover:bg-gray-50 transition">
                  <UserIcon class="w-4 h-4 text-gray-500" />
                  <span class="text-sm">Profile</span>
                </router-link>
                <router-link to="/settings" class="flex items-center gap-3 px-4 py-3 hover:bg-gray-50 transition">
                  <Cog6ToothIcon class="w-4 h-4 text-gray-500" />
                  <span class="text-sm">Settings</span>
                </router-link>
                <hr>
                <button @click="logout" class="w-full flex items-center gap-3 px-4 py-3 hover:bg-red-50 text-red-600 transition">
                  <ArrowRightOnRectangleIcon class="w-4 h-4" />
                  <span class="text-sm">Logout</span>
                </button>
              </div>
            </div>
          </div>
        </div>
      </header>

      <!-- Page Content -->
      <main class="p-6">
        <router-view />
      </main>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useAuthStore } from '../stores/auth'
import {
  HomeIcon, UsersIcon, AcademicCapIcon, UserGroupIcon,
  BuildingOffice2Icon, ViewfinderCircleIcon, DocumentChartBarIcon,
  BellIcon, MagnifyingGlassIcon, SunIcon, MoonIcon,
  UserIcon, Cog6ToothIcon, ArrowRightOnRectangleIcon,
  Bars3Icon, ChevronDownIcon
} from '@heroicons/vue/24/outline'

const router = useRouter()
const route = useRoute()
const authStore = useAuthStore()

const sidebarOpen = ref(false)
const userMenuOpen = ref(false)
const isDark = ref(false)

const menuItems = computed(() => [
  { name: 'Dashboard', path: '/admin/dashboard', icon: HomeIcon },
  { name: 'Manajemen User', path: '/admin/users', icon: UsersIcon },
  { name: 'Manajemen Siswa', path: '/admin/students', icon: AcademicCapIcon },
  { name: 'Manajemen Guru', path: '/admin/teachers', icon: UserGroupIcon },
  { name: 'Manajemen Perusahaan', path: '/admin/companies', icon: BuildingOffice2Icon },
  { name: 'Monitoring PKL', path: '/admin/monitoring', icon: ViewfinderCircleIcon },
  { name: 'Laporan', path: '/admin/reports', icon: DocumentChartBarIcon },
])

const pageTitle = computed(() => {
  const found = menuItems.value.find(m => m.path === route.path)
  return found?.name || 'Dashboard'
})

const pageDescription = computed(() => {
  const descriptions = {
    '/admin/dashboard': 'Ringkasan data PKL',
    '/admin/users': 'Kelola semua pengguna sistem',
    '/admin/students': 'Kelola data siswa peserta PKL',
    '/admin/teachers': 'Kelola data guru pembimbing',
    '/admin/companies': 'Kelola data perusahaan mitra PKL',
    '/admin/monitoring': 'Pantau aktivitas PKL siswa',
    '/admin/reports': 'Download laporan PKL'
  }
  return descriptions[route.path] || ''
})

const toggleTheme = () => {
  isDark.value = !isDark.value
  if (isDark.value) {
    document.documentElement.classList.add('dark')
  } else {
    document.documentElement.classList.remove('dark')
  }
}

const logout = async () => {
  await authStore.logout()
  router.push('/login')
}
</script>