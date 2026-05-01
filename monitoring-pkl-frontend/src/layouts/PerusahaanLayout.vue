<template>
  <div class="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100">
    <!-- Sidebar -->
    <aside 
      class="fixed left-0 top-0 z-40 h-screen bg-white/90 backdrop-blur-xl shadow-2xl transition-all duration-300 ease-in-out"
      :class="[
        sidebarCollapsed ? 'w-20' : 'w-72',
        isMobile && !sidebarOpen ? '-translate-x-full' : 'translate-x-0'
      ]"
    >
      <!-- Logo Section -->
      <div class="flex items-center justify-between px-5 py-5 border-b border-gray-100" :class="sidebarCollapsed ? 'justify-center px-2' : ''">
        <div class="flex items-center gap-3" :class="sidebarCollapsed ? 'justify-center' : ''">
          <div class="w-10 h-10 bg-gradient-to-br from-purple-600 to-pink-600 rounded-xl flex items-center justify-center shadow-lg flex-shrink-0 group-hover:scale-105 transition-transform">
            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
            </svg>
          </div>
          <div v-if="!sidebarCollapsed" class="transition-opacity duration-300">
            <h1 class="text-xl font-bold bg-gradient-to-r from-purple-600 to-pink-600 bg-clip-text text-transparent">Perusahaan Panel</h1>
            <p class="text-xs text-gray-500">{{ authStore.user?.company?.name || 'Loading...' }}</p>
          </div>
        </div>
      </div>

      <!-- User Profile -->
      <div class="p-4 m-3 bg-gradient-to-r from-purple-50 to-pink-50 rounded-2xl transition-all duration-300" :class="sidebarCollapsed ? 'mx-2 p-2' : ''">
        <div class="flex items-center gap-3" :class="sidebarCollapsed ? 'flex-col text-center' : ''">
          <div class="relative flex-shrink-0 group">
            <div class="w-12 h-12 bg-gradient-to-br from-purple-600 to-pink-600 rounded-2xl flex items-center justify-center text-white font-bold text-lg shadow-lg group-hover:scale-105 transition-transform">
              {{ authStore.user?.name?.charAt(0) || 'P' }}
            </div>
            <div class="absolute -bottom-1 -right-1 w-3.5 h-3.5 bg-green-500 rounded-full border-2 border-white shadow-md"></div>
          </div>
          <div v-if="!sidebarCollapsed" class="flex-1 min-w-0">
            <p class="font-semibold text-gray-800 text-sm truncate">{{ authStore.user?.name }}</p>
            <p class="text-xs text-gray-500">Pembimbing Perusahaan</p>
          </div>
        </div>
      </div>

      <!-- Navigation Menu -->
      <nav class="flex-1 px-3 py-4 overflow-y-auto h-[calc(100vh-200px)] scrollbar-thin" :class="sidebarCollapsed ? 'px-2' : ''">
        
        <!-- MAIN Section -->
        <div class="mb-4">
          <div v-if="!sidebarCollapsed" class="px-3 mb-2">
            <p class="text-[10px] font-semibold text-gray-400 uppercase tracking-wider">MAIN</p>
          </div>
          <router-link 
            to="/perusahaan/dashboard" 
            class="flex items-center gap-3 px-3 py-3 rounded-xl transition-all duration-200 group relative"
            :class="[
              $route.path === '/perusahaan/dashboard' 
                ? 'bg-gradient-to-r from-purple-600 to-pink-600 text-white shadow-md' 
                : 'text-gray-600 hover:bg-gray-100',
              sidebarCollapsed ? 'justify-center' : ''
            ]"
            :title="sidebarCollapsed ? 'Dashboard' : ''"
          >
            <HomeIcon class="w-5 h-5 flex-shrink-0" :class="$route.path === '/perusahaan/dashboard' ? 'text-white' : 'text-gray-500 group-hover:text-purple-600'" />
            <span v-if="!sidebarCollapsed" class="text-sm font-medium">Dashboard</span>
            <div v-if="sidebarCollapsed" class="absolute left-full ml-2 px-2 py-1 bg-gray-900 text-white text-xs rounded-lg opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none z-50 whitespace-nowrap">
              Dashboard
            </div>
          </router-link>
        </div>

        <!-- PENILAIAN Section -->
        <div class="mb-4">
          <div v-if="!sidebarCollapsed" class="px-3 mb-2">
            <p class="text-[10px] font-semibold text-gray-400 uppercase tracking-wider">PENILAIAN</p>
          </div>
          <router-link 
            to="/perusahaan/assessment" 
            class="flex items-center gap-3 px-3 py-3 rounded-xl transition-all duration-200 mb-1 group relative"
            :class="[
              $route.path === '/perusahaan/assessment' 
                ? 'bg-gradient-to-r from-purple-600 to-pink-600 text-white shadow-md' 
                : 'text-gray-600 hover:bg-gray-100',
              sidebarCollapsed ? 'justify-center' : ''
            ]"
            :title="sidebarCollapsed ? 'Penilaian Logbook' : ''"
          >
            <StarIcon class="w-5 h-5 flex-shrink-0" :class="$route.path === '/perusahaan/assessment' ? 'text-white' : 'text-gray-500 group-hover:text-purple-600'" />
            <span v-if="!sidebarCollapsed" class="text-sm font-medium">Penilaian Logbook</span>
            <div v-if="sidebarCollapsed" class="absolute left-full ml-2 px-2 py-1 bg-gray-900 text-white text-xs rounded-lg opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none z-50 whitespace-nowrap">
              Penilaian Logbook
            </div>
          </router-link>
          
          <router-link 
            to="/perusahaan/progress" 
            class="flex items-center gap-3 px-3 py-3 rounded-xl transition-all duration-200 group relative"
            :class="[
              $route.path === '/perusahaan/progress' 
                ? 'bg-gradient-to-r from-purple-600 to-pink-600 text-white shadow-md' 
                : 'text-gray-600 hover:bg-gray-100',
              sidebarCollapsed ? 'justify-center' : ''
            ]"
            :title="sidebarCollapsed ? 'Progress Siswa' : ''"
          >
            <ChartBarIcon class="w-5 h-5 flex-shrink-0" :class="$route.path === '/perusahaan/progress' ? 'text-white' : 'text-gray-500 group-hover:text-purple-600'" />
            <span v-if="!sidebarCollapsed" class="text-sm font-medium">Progress Siswa</span>
            <div v-if="sidebarCollapsed" class="absolute left-full ml-2 px-2 py-1 bg-gray-900 text-white text-xs rounded-lg opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none z-50 whitespace-nowrap">
              Progress Siswa
            </div>
          </router-link>
        </div>


         <div class="mb-4">
    <div v-if="!sidebarCollapsed" class="px-3 mb-2">
      <p class="text-[10px] font-semibold text-gray-400 uppercase tracking-wider">LAPORAN</p>
    </div>
    <router-link 
      to="/perusahaan/report" 
      class="flex items-center gap-3 px-3 py-3 rounded-xl transition-all duration-200 group relative"
      :class="[
        $route.path === '/perusahaan/report' 
          ? 'bg-gradient-to-r from-purple-600 to-pink-600 text-white shadow-md' 
          : 'text-gray-600 hover:bg-gray-100',
        sidebarCollapsed ? 'justify-center' : ''
      ]"
      :title="sidebarCollapsed ? 'Laporan' : ''"
    >
      <DocumentChartBarIcon class="w-5 h-5 flex-shrink-0" />
      <span v-if="!sidebarCollapsed" class="text-sm font-medium">Laporan PKL</span>
      <div v-if="sidebarCollapsed" class="absolute left-full ml-2 px-2 py-1 bg-gray-900 text-white text-xs rounded-lg opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none z-50 whitespace-nowrap">
        Laporan PKL
      </div>
    </router-link>
  </div>
      </nav>

      <!-- Footer Menu Logout -->
      <div class="absolute bottom-0 left-0 right-0 p-3 border-t border-gray-100 bg-white/80 backdrop-blur-sm" :class="sidebarCollapsed ? 'p-2' : ''">
        <button 
          @click="logout" 
          class="w-full flex items-center gap-3 px-3 py-3 rounded-xl text-red-600 hover:bg-red-50 transition-all duration-200 group relative"
          :class="sidebarCollapsed ? 'justify-center px-2' : ''"
          :title="sidebarCollapsed ? 'Logout' : ''"
        >
          <ArrowRightOnRectangleIcon class="w-5 h-5 flex-shrink-0" />
          <span v-if="!sidebarCollapsed" class="text-sm font-medium">Logout</span>
          <div v-if="sidebarCollapsed" class="absolute left-full ml-2 px-2 py-1 bg-gray-900 text-white text-xs rounded-lg opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none z-50 whitespace-nowrap">
            Logout
          </div>
        </button>
      </div>
    </aside>

    <!-- Overlay untuk mobile -->
    <div 
      v-if="isMobile && sidebarOpen" 
      @click="closeSidebar" 
      class="fixed inset-0 bg-black/50 backdrop-blur-sm z-30 transition-all duration-300"
    ></div>

    <!-- Main Content -->
    <div 
      class="transition-all duration-300 ease-in-out"
      :class="[
        !sidebarCollapsed && !isMobile ? 'lg:ml-72' : (isMobile ? 'ml-0' : 'lg:ml-20'),
        isMobile && sidebarOpen ? 'ml-72' : ''
      ]"
    >
      <!-- Top Navbar with Glassmorphism -->
      <header class="sticky top-0 z-30 bg-white/70 backdrop-blur-xl border-b border-gray-100 shadow-sm">
        <div class="flex items-center justify-between px-6 py-4">
          <div class="flex items-center gap-4">
            <!-- Burger Menu Button -->
            <button 
              @click="toggleSidebar" 
              class="relative w-10 h-10 rounded-xl bg-gray-100 hover:bg-gray-200 transition-all duration-200 flex items-center justify-center group shadow-sm"
            >
              <div class="absolute inset-0 rounded-xl bg-gradient-to-r from-purple-500 to-pink-600 opacity-0 group-hover:opacity-100 transition-opacity -z-0"></div>
              <svg 
                class="relative w-5 h-5 text-gray-600 group-hover:text-white transition-colors z-10" 
                fill="none" 
                stroke="currentColor" 
                viewBox="0 0 24 24"
              >
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
              </svg>
            </button>
            <div class="hidden sm:block">
              <h2 class="text-xl font-bold bg-gradient-to-r from-purple-600 to-pink-600 bg-clip-text text-transparent">{{ pageTitle }}</h2>
              <p class="text-sm text-gray-500">{{ pageDescription }}</p>
            </div>
          </div>
          
          <div class="flex items-center gap-2">
            <!-- Notification Bell -->
            <div class="relative">
              <button 
                @click="toggleNotif" 
                class="relative w-10 h-10 rounded-xl bg-gray-100 hover:bg-gray-200 transition-all duration-200 flex items-center justify-center group"
              >
                <BellIcon class="w-5 h-5 text-gray-600 group-hover:text-purple-600 transition-colors" />
                <span v-if="unreadCount > 0" class="absolute -top-1 -right-1 w-4 h-4 bg-red-500 rounded-full text-white text-[10px] font-bold flex items-center justify-center shadow-md animate-pulse">
                  {{ unreadCount > 9 ? '9+' : unreadCount }}
                </span>
              </button>
              
              <!-- Notification Dropdown -->
              <transition name="fade-down">
                <div v-if="showNotif" class="absolute right-0 mt-3 w-80 bg-white rounded-2xl shadow-2xl border overflow-hidden z-50">
                  <div class="p-4 border-b bg-gradient-to-r from-purple-50 to-pink-50">
                    <div class="flex justify-between items-center">
                      <p class="font-semibold text-gray-800">Notifikasi</p>
                      <span class="text-xs text-gray-500">{{ unreadCount }} belum dibaca</span>
                    </div>
                  </div>
                  <div class="max-h-96 overflow-y-auto">
                    <div v-for="notif in notifications" :key="notif.id" class="p-4 border-b hover:bg-gray-50 transition cursor-pointer group">
                      <div class="flex items-start gap-3">
                        <div class="w-8 h-8 rounded-full bg-purple-100 flex items-center justify-center flex-shrink-0">
                          <BellIcon class="w-4 h-4 text-purple-600" />
                        </div>
                        <div class="flex-1">
                          <p class="text-sm font-semibold text-gray-800">{{ notif.title }}</p>
                          <p class="text-xs text-gray-500 mt-1">{{ notif.message }}</p>
                          <p class="text-xs text-gray-400 mt-2">{{ formatTime(notif.created_at) }}</p>
                        </div>
                      </div>
                    </div>
                    <div v-if="notifications.length === 0" class="p-8 text-center text-gray-500">
                      <BellIcon class="w-12 h-12 mx-auto text-gray-300 mb-3" />
                      <p class="text-sm">Tidak ada notifikasi</p>
                    </div>
                  </div>
                  <div class="p-2 border-t text-center bg-gray-50">
                    <button class="text-xs text-purple-600 hover:underline">Lihat semua</button>
                  </div>
                </div>
              </transition>
            </div>

            <!-- User Menu -->
            <div class="relative">
              <button 
                @click="toggleUserMenu" 
                class="flex items-center gap-2 p-1 rounded-xl hover:bg-gray-100 transition-all duration-200 group">
                <div class="w-9 h-9 bg-gradient-to-br from-purple-600 to-pink-600 rounded-xl flex items-center justify-center text-white text-sm font-bold shadow-md group-hover:scale-105 transition-transform">
                  {{ authStore.user?.name?.charAt(0) || 'P' }}
                </div>
                <ChevronDownIcon class="w-4 h-4 text-gray-500 hidden md:block transition-transform duration-200" :class="{ 'rotate-180': userMenuOpen }" />
              </button>
              
              <!-- Dropdown User Menu -->
              <transition name="fade-down">
                <div v-if="userMenuOpen" class="absolute right-0 mt-3 w-64 bg-white rounded-2xl shadow-2xl border overflow-hidden z-50">
                  <div class="p-4 bg-gradient-to-r from-purple-50 to-pink-50">
                    <div class="flex items-center gap-3">
                      <div class="w-10 h-10 bg-gradient-to-br from-purple-600 to-pink-600 rounded-xl flex items-center justify-center text-white font-bold shadow-md">
                        {{ authStore.user?.name?.charAt(0) || 'P' }}
                      </div>
                      <div>
                        <p class="font-semibold text-gray-800">{{ authStore.user?.name }}</p>
                        <p class="text-xs text-gray-500">{{ authStore.user?.email }}</p>
                      </div>
                    </div>
                  </div>
                  <div class="py-2">
                    <router-link to="/perusahaan/profile" class="flex items-center gap-3 px-4 py-3 hover:bg-gray-50 transition group">
                      <UserIcon class="w-4 h-4 text-gray-500 group-hover:text-purple-600" />
                      <span class="text-sm">Profile Perusahaan</span>
                    </router-link>
                  </div>
                  <div class="border-t"></div>
                  <div class="py-2">
                    <button @click="logout" class="w-full flex items-center gap-3 px-4 py-3 hover:bg-red-50 text-red-600 transition group">
                      <ArrowRightOnRectangleIcon class="w-4 h-4" />
                      <span class="text-sm">Keluar</span>
                    </button>
                  </div>
                </div>
              </transition>
            </div>
          </div>
        </div>
        
        <!-- Mobile Title -->
        <div class="block sm:hidden px-6 pb-3">
          <h2 class="text-lg font-bold text-gray-800">{{ pageTitle }}</h2>
          <p class="text-xs text-gray-500">{{ pageDescription }}</p>
        </div>
      </header>

      <!-- Page Content -->
      <main class="p-6 animate-fadeIn">
        <router-view />
      </main>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted, watch } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useAuthStore } from '../stores/auth'
import axios from '../plugins/axios'
import { 
  HomeIcon, 
  StarIcon, 
  ChartBarIcon, 
  DocumentChartBarIcon,
  ArrowRightOnRectangleIcon, 
  BellIcon, 
  UserIcon, 
  ChevronDownIcon 
} from '@heroicons/vue/24/outline'

const router = useRouter()
const route = useRoute()
const authStore = useAuthStore()

// State
const sidebarCollapsed = ref(false)
const sidebarOpen = ref(true)
const userMenuOpen = ref(false)
const showNotif = ref(false)
const notifications = ref([])
const unreadCount = ref(0)
const windowWidth = ref(window.innerWidth)

// Check if mobile
const isMobile = computed(() => windowWidth.value < 1024)

// Toggle functions
const toggleSidebar = () => {
  if (isMobile.value) {
    sidebarOpen.value = !sidebarOpen.value
    sidebarCollapsed.value = !sidebarOpen.value
  } else {
    sidebarCollapsed.value = !sidebarCollapsed.value
    sidebarOpen.value = !sidebarCollapsed.value
  }
  localStorage.setItem('perusahaanSidebarCollapsed', sidebarCollapsed.value)
}

const closeSidebar = () => {
  if (isMobile.value) {
    sidebarOpen.value = false
    sidebarCollapsed.value = true
  }
}

const toggleUserMenu = () => {
  userMenuOpen.value = !userMenuOpen.value
  if (showNotif.value) showNotif.value = false
}

const toggleNotif = () => {
  showNotif.value = !showNotif.value
  if (userMenuOpen.value) userMenuOpen.value = false
  if (showNotif.value && unreadCount.value > 0) {
    markNotificationsAsRead()
  }
}

const markNotificationsAsRead = async () => {
  try {
    await axios.put('/notifications/read-all')
    unreadCount.value = 0
  } catch (error) {
    console.error('Failed to mark notifications as read:', error)
  }
}

// Handle resize
const handleResize = () => {
  windowWidth.value = window.innerWidth
  if (windowWidth.value >= 1024) {
    const savedState = localStorage.getItem('perusahaanSidebarCollapsed')
    sidebarCollapsed.value = savedState === 'true'
    sidebarOpen.value = !sidebarCollapsed.value
  } else {
    sidebarCollapsed.value = true
    sidebarOpen.value = false
  }
}

// Format time
const formatTime = (date) => {
  if (!date) return ''
  const now = new Date()
  const notifDate = new Date(date)
  const diff = Math.floor((now - notifDate) / 1000 / 60)
  
  if (diff < 1) return 'Baru saja'
  if (diff < 60) return `${diff} menit lalu`
  if (diff < 1440) return `${Math.floor(diff / 60)} jam lalu`
  return `${Math.floor(diff / 1440)} hari lalu`
}

// Fetch notifications
const fetchNotifications = async () => {
  try {
    const res = await axios.get('/notifications')
    console.log('Notifications response:', res.data)
    
    // Pastikan mengambil array yang benar
    let data = []
    if (res.data && res.data.data && Array.isArray(res.data.data)) {
      data = res.data.data
    } else if (res.data && Array.isArray(res.data)) {
      data = res.data
    } else {
      data = []
    }
     notifications.value = data
    // Hitung unread count dengan aman
    if (Array.isArray(data)) {
      unreadCount.value = data.filter(n => !n.is_read).length
    } else {
      unreadCount.value = 0
    }
    console.log('Notifications loaded:', notifications.value.length, 'Unread:', unreadCount.value)
  } catch (error) {
    console.error('Failed to fetch notifications:', error)
    notifications.value = []
    unreadCount.value = 0
  }
}

// Page title
const pageTitle = computed(() => {
  const titles = {
    '/perusahaan/dashboard': 'Dashboard',
    '/perusahaan/assessment': 'Penilaian Logbook',
    '/perusahaan/progress': 'Progress Siswa',
    '/perusahaan/profile': 'Profile Perusahaan'
  }
  return titles[route.path] || 'Dashboard'
})

const pageDescription = computed(() => {
  const desc = {
    '/perusahaan/dashboard': 'Ringkasan aktivitas siswa PKL',
    '/perusahaan/assessment': 'Berikan penilaian untuk logbook siswa',
    '/perusahaan/progress': 'Pantau kemajuan siswa PKL'
  }
  return desc[route.path] || ''
})

// Logout
const logout = async () => {
  await authStore.logout()
  router.push('/login')
}

// Click outside handler
const handleClickOutside = (e) => {
  if (!e.target.closest('.relative')) {
    userMenuOpen.value = false
    showNotif.value = false
  }
}

// Watch route change
watch(() => route.path, () => {
  userMenuOpen.value = false
  showNotif.value = false
  if (isMobile.value) {
    sidebarOpen.value = false
    sidebarCollapsed.value = true
  }
})

// Lifecycle
onMounted(() => {
  handleResize()
  fetchNotifications()
  const interval = setInterval(fetchNotifications, 30000)
  window.addEventListener('resize', handleResize)
  document.addEventListener('click', handleClickOutside)
  
  return () => {
    clearInterval(interval)
    window.removeEventListener('resize', handleResize)
    document.removeEventListener('click', handleClickOutside)
  }
})

onUnmounted(() => {
  window.removeEventListener('resize', handleResize)
  document.removeEventListener('click', handleClickOutside)
})
</script>

<style scoped>
/* Scrollbar styling */
nav::-webkit-scrollbar {
  width: 4px;
}

nav::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 10px;
}

nav::-webkit-scrollbar-thumb {
  background: #cbd5e1;
  border-radius: 10px;
}

nav::-webkit-scrollbar-thumb:hover {
  background: #94a3b8;
}

/* Transisi smooth */
aside {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

/* Animasi fade in */
.animate-fadeIn {
  animation: fadeIn 0.3s ease-out;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Dropdown animation */
.fade-down-enter-active,
.fade-down-leave-active {
  transition: all 0.15s ease-out;
}

.fade-down-enter-from,
.fade-down-leave-to {
  opacity: 0;
  transform: translateY(-8px);
}

/* Pulse animation */
@keyframes pulse {
  0%, 100% { opacity: 1; transform: scale(1); }
  50% { opacity: 0.7; transform: scale(1.1); }
}

.animate-pulse {
  animation: pulse 1.5s ease-in-out infinite;
}

/* Glassmorphism effect */
.backdrop-blur-xl {
  backdrop-filter: blur(12px);
}
</style>