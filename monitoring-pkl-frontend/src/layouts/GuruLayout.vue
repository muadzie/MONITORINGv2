<template>
  <div class="min-h-screen bg-gray-50">
    <!-- Sidebar -->
    <aside 
      class="fixed left-0 top-0 z-40 h-screen bg-white shadow-2xl transition-all duration-300"
      :class="[
        sidebarCollapsed ? '-translate-x-full lg:w-20' : 'translate-x-0 w-72',
        'lg:translate-x-0'
      ]"
    >
      <!-- Logo Section -->
      <div class="flex items-center justify-between px-6 py-5 border-b" :class="sidebarCollapsed ? 'justify-center px-3' : ''">
        <div class="flex items-center gap-3" :class="sidebarCollapsed ? 'flex-col' : ''">
          <div class="w-10 h-10 bg-gradient-to-br from-blue-600 to-cyan-600 rounded-xl flex items-center justify-center shadow-lg flex-shrink-0">
            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
            </svg>
          </div>
          <div v-if="!sidebarCollapsed">
            <h1 class="text-xl font-bold text-gray-800">Guru Panel</h1>
            <p class="text-xs text-gray-500">SMKN 1 Subang</p>
          </div>
        </div>
        <button 
          @click="toggleSidebar" 
          class="lg:hidden text-gray-500 hover:text-gray-700 transition"
          :class="sidebarCollapsed ? 'absolute right-2 top-5' : ''"
        >
          <XMarkIcon class="w-6 h-6" />
        </button>
      </div>

      <!-- User Profile -->
      <div class="p-4 m-4 bg-gradient-to-r from-blue-50 to-cyan-50 rounded-xl" :class="sidebarCollapsed ? 'mx-2 p-2' : ''">
        <div class="flex items-center gap-3" :class="sidebarCollapsed ? 'flex-col text-center' : ''">
          <div class="w-12 h-12 bg-gradient-to-br from-blue-600 to-cyan-600 rounded-xl flex items-center justify-center text-white font-bold text-lg shadow-md flex-shrink-0">
            {{ authStore.user?.name?.charAt(0) || 'G' }}
          </div>
          <div v-if="!sidebarCollapsed" class="flex-1 min-w-0">
            <p class="font-semibold text-gray-800 text-sm truncate">{{ authStore.user?.name }}</p>
            <p class="text-xs text-gray-500">Guru Pembimbing</p>
          </div>
        </div>
      </div>

      <!-- Navigation Menu -->
      <nav class="flex-1 px-4 py-4 overflow-y-auto h-[calc(100vh-200px)]" :class="sidebarCollapsed ? 'px-2' : ''">
        <router-link 
          to="/guru/dashboard" 
          class="flex items-center gap-3 px-4 py-3 rounded-xl mb-1 transition-all duration-200"
          :class="[
            $route.path === '/guru/dashboard' 
              ? 'bg-gradient-to-r from-blue-600 to-cyan-600 text-white shadow-md' 
              : 'text-gray-600 hover:bg-gray-100',
            sidebarCollapsed ? 'justify-center px-2' : ''
          ]"
          :title="sidebarCollapsed ? 'Dashboard' : ''"
        >
          <HomeIcon class="w-5 h-5 flex-shrink-0" />
          <span v-if="!sidebarCollapsed">Dashboard</span>
        </router-link>

        <router-link 
          to="/guru/monitoring" 
          class="flex items-center gap-3 px-4 py-3 rounded-xl mb-1 transition-all duration-200"
          :class="[
            $route.path === '/guru/monitoring' 
              ? 'bg-gradient-to-r from-blue-600 to-cyan-600 text-white shadow-md' 
              : 'text-gray-600 hover:bg-gray-100',
            sidebarCollapsed ? 'justify-center px-2' : ''
          ]"
          :title="sidebarCollapsed ? 'Monitoring Siswa' : ''"
        >
          <UserGroupIcon class="w-5 h-5 flex-shrink-0" />
          <span v-if="!sidebarCollapsed">Monitoring Siswa</span>
        </router-link>

        <router-link 
          to="/guru/attendance-monitoring" 
          class="flex items-center gap-3 px-4 py-3 rounded-xl mb-1 transition-all duration-200"
          :class="[
            $route.path === '/guru/attendance-monitoring' 
              ? 'bg-gradient-to-r from-blue-600 to-cyan-600 text-white shadow-md' 
              : 'text-gray-600 hover:bg-gray-100',
            sidebarCollapsed ? 'justify-center px-2' : ''
          ]"
          :title="sidebarCollapsed ? 'Monitoring Absensi' : ''"
        >
          <ClipboardDocumentListIcon class="w-5 h-5 flex-shrink-0" />
          <span v-if="!sidebarCollapsed">Monitoring Absensi</span>
        </router-link>

        <router-link 
          to="/guru/logbook-review" 
          class="flex items-center gap-3 px-4 py-3 rounded-xl mb-1 transition-all duration-200"
          :class="[
            $route.path === '/guru/logbook-review' 
              ? 'bg-gradient-to-r from-blue-600 to-cyan-600 text-white shadow-md' 
              : 'text-gray-600 hover:bg-gray-100',
            sidebarCollapsed ? 'justify-center px-2' : ''
          ]"
          :title="sidebarCollapsed ? 'Review Logbook' : ''"
        >
          <BookOpenIcon class="w-5 h-5 flex-shrink-0" />
          <span v-if="!sidebarCollapsed">Review Logbook</span>
        </router-link>

        <router-link 
          to="/guru/permissions" 
          class="flex items-center gap-3 px-4 py-3 rounded-xl mb-1 transition-all duration-200"
          :class="[
            $route.path === '/guru/permissions' 
              ? 'bg-gradient-to-r from-blue-600 to-cyan-600 text-white shadow-md' 
              : 'text-gray-600 hover:bg-gray-100',
            sidebarCollapsed ? 'justify-center px-2' : ''
          ]"
          :title="sidebarCollapsed ? 'Approval Izin' : ''"
        >
          <DocumentTextIcon class="w-5 h-5 flex-shrink-0" />
          <span v-if="!sidebarCollapsed">Approval Izin</span>
        </router-link>

        <router-link 
          to="/guru/report-review" 
          class="flex items-center gap-3 px-4 py-3 rounded-xl mb-1 transition-all duration-200"
          :class="[
            $route.path === '/guru/report-review' 
              ? 'bg-gradient-to-r from-blue-600 to-cyan-600 text-white shadow-md' 
              : 'text-gray-600 hover:bg-gray-100',
            sidebarCollapsed ? 'justify-center px-2' : ''
          ]"
          :title="sidebarCollapsed ? 'Review Laporan PKL' : ''"
        >
          <DocumentChartBarIcon class="w-5 h-5 flex-shrink-0" />
          <span v-if="!sidebarCollapsed">Review Laporan PKL</span>
        </router-link>

        <router-link 
          to="/guru/assessment" 
          class="flex items-center gap-3 px-4 py-3 rounded-xl mb-1 transition-all duration-200"
          :class="[
            $route.path === '/guru/assessment' 
              ? 'bg-gradient-to-r from-blue-600 to-cyan-600 text-white shadow-md' 
              : 'text-gray-600 hover:bg-gray-100',
            sidebarCollapsed ? 'justify-center px-2' : ''
          ]"
          :title="sidebarCollapsed ? 'Penilaian PKL' : ''"
        >
          <ClipboardDocumentListIcon class="w-5 h-5 flex-shrink-0" />
          <span v-if="!sidebarCollapsed">Penilaian PKL</span>
        </router-link>
      </nav>

      <!-- Footer -->
      <div class="absolute bottom-0 left-0 right-0 p-4 border-t bg-white" :class="sidebarCollapsed ? 'p-2' : ''">
        <button 
          @click="logout" 
          class="w-full flex items-center gap-3 px-4 py-3 rounded-xl text-red-600 hover:bg-red-50 transition"
          :class="sidebarCollapsed ? 'justify-center px-2' : ''"
          :title="sidebarCollapsed ? 'Logout' : ''"
        >
          <ArrowRightOnRectangleIcon class="w-5 h-5 flex-shrink-0" />
          <span v-if="!sidebarCollapsed">Logout</span>
        </button>
      </div>
    </aside>

    <!-- Overlay untuk mobile -->
    <div 
      v-if="sidebarCollapsed && windowWidth < 1024" 
      @click="toggleSidebar" 
      class="fixed inset-0 bg-black/50 z-30 lg:hidden"
    ></div>

    <!-- Main Content -->
    <div 
      class="transition-all duration-300"
      :class="[
        !sidebarCollapsed ? 'lg:ml-72' : 'lg:ml-20'
      ]"
    >
      <!-- Top Navbar -->
      <header class="sticky top-0 z-30 bg-white/80 backdrop-blur-lg border-b border-gray-100">
        <div class="flex items-center justify-between px-6 py-4">
          <div class="flex items-center gap-4">
            <!-- Burger Menu Button -->
            <button 
              @click="toggleSidebar" 
              class="p-2 rounded-lg hover:bg-gray-100 transition-all duration-200 focus:outline-none"
            >
              <svg 
                v-if="sidebarCollapsed" 
                class="w-6 h-6 text-gray-600" 
                fill="none" 
                stroke="currentColor" 
                viewBox="0 0 24 24"
              >
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
              </svg>
              <svg 
                v-else 
                class="w-6 h-6 text-gray-600" 
                fill="none" 
                stroke="currentColor" 
                viewBox="0 0 24 24"
              >
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
            <div>
              <h2 class="text-xl font-bold text-gray-800">{{ pageTitle }}</h2>
              <p class="text-sm text-gray-500">{{ pageDescription }}</p>
            </div>
          </div>
          <div class="flex items-center gap-3">
            <div class="w-8 h-8 bg-gradient-to-br from-blue-600 to-cyan-600 rounded-lg flex items-center justify-center text-white font-bold shadow-md">
              {{ authStore.user?.name?.charAt(0) }}
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
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth'
import { 
  HomeIcon, 
  UserGroupIcon, 
  BookOpenIcon, 
  DocumentTextIcon, 
  DocumentChartBarIcon, 
  ClipboardDocumentListIcon, 
  ArrowRightOnRectangleIcon,
  XMarkIcon
} from '@heroicons/vue/24/outline'

const route = useRoute()
const router = useRouter()
const authStore = useAuthStore()

// State untuk sidebar
const sidebarCollapsed = ref(false)
const windowWidth = ref(window.innerWidth)

// Fungsi toggle sidebar
const toggleSidebar = () => {
  sidebarCollapsed.value = !sidebarCollapsed.value
  // Simpan state ke localStorage
  localStorage.setItem('sidebarCollapsed', sidebarCollapsed.value)
}

// Fungsi untuk handle resize window
const handleResize = () => {
  windowWidth.value = window.innerWidth
  // Di desktop, sidebar tidak collapse secara default
  if (windowWidth.value >= 1024) {
    const savedState = localStorage.getItem('sidebarCollapsed')
    if (savedState !== null) {
      sidebarCollapsed.value = savedState === 'true'
    } else {
      sidebarCollapsed.value = false
    }
  } else {
    // Di mobile, sidebar collapsed default
    sidebarCollapsed.value = true
  }
}

// Page title dan description
const pageTitle = computed(() => {
  const titles = {
    '/guru/dashboard': 'Dashboard',
    '/guru/monitoring': 'Monitoring Siswa',
    '/guru/attendance-monitoring': 'Monitoring Absensi',
    '/guru/logbook-review': 'Review Logbook',
    '/guru/permissions': 'Approval Izin',
    '/guru/report-review': 'Review Laporan PKL',
    '/guru/assessment': 'Penilaian PKL'
  }
  return titles[route.path] || 'Dashboard'
})

const pageDescription = computed(() => {
  const desc = {
    '/guru/dashboard': 'Ringkasan aktivitas bimbingan PKL',
    '/guru/monitoring': 'Pantau aktivitas dan progres siswa',
    '/guru/attendance-monitoring': 'Pantau kehadiran siswa PKL',
    '/guru/report-review': 'Review dan download laporan PKL siswa'
  }
  return desc[route.path] || ''
})

// Logout function
const logout = async () => {
  await authStore.logout()
  router.push('/login')
}

// Lifecycle
onMounted(() => {
  handleResize()
  window.addEventListener('resize', handleResize)
})

onUnmounted(() => {
  window.removeEventListener('resize', handleResize)
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
  transition: all 0.3s ease-in-out;
}

.main-content {
  transition: margin-left 0.3s ease-in-out;
}
</style>