<template>
  <div class="min-h-screen flex items-center justify-center relative overflow-hidden bg-gradient-to-br from-slate-900 via-indigo-900 to-purple-900">
    
    <!-- Animated Background Elements -->
    <div class="absolute inset-0 overflow-hidden">
      <div class="absolute -top-40 -right-40 w-80 h-80 bg-indigo-500 rounded-full mix-blend-multiply filter blur-3xl opacity-20 animate-blob"></div>
      <div class="absolute -bottom-40 -left-40 w-80 h-80 bg-purple-500 rounded-full mix-blend-multiply filter blur-3xl opacity-20 animate-blob animation-delay-2000"></div>
      <div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-80 h-80 bg-pink-500 rounded-full mix-blend-multiply filter blur-3xl opacity-20 animate-blob animation-delay-4000"></div>
    </div>

    <!-- Grid Pattern Overlay -->
    <div class="grid-pattern-overlay"></div>

    <!-- Particles Effect -->
    <div class="absolute inset-0">
      <div v-for="i in 50" :key="i" class="absolute w-1 h-1 bg-white rounded-full animate-particle" :style="{
        top: Math.random() * 100 + '%',
        left: Math.random() * 100 + '%',
        animationDelay: Math.random() * 5 + 's',
        animationDuration: 3 + Math.random() * 5 + 's'
      }"></div>
    </div>

    <!-- Main Card -->
    <div class="relative z-10 w-full max-w-md mx-4">
      <!-- Glass Morphism Card -->
      <div class="bg-white/10 backdrop-blur-xl rounded-2xl shadow-2xl p-8 border border-white/20 animate-fade-in-up">
        
        <!-- Logo Section -->
        <div class="text-center mb-8">
          <div class="relative inline-block">
            <div class="w-20 h-20 bg-gradient-to-br from-indigo-500 to-purple-600 rounded-2xl flex items-center justify-center mx-auto shadow-2xl animate-float">
              <svg class="w-10 h-10 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
              </svg>
            </div>
            <div class="absolute -top-1 -right-1 w-4 h-4 bg-green-500 rounded-full animate-pulse"></div>
          </div>
          <h1 class="text-3xl font-bold text-white mt-4">Selamat Datang</h1>
          <p class="text-indigo-200 mt-2">Silakan masuk ke akun Anda</p>
        </div>

        <!-- Login Form -->
        <form @submit.prevent="handleLogin" class="space-y-5">
          <!-- Email Field -->
          <div class="group">
            <label class="block text-sm font-medium text-indigo-200 mb-2">Email Address</label>
            <div class="relative">
              <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                <svg class="h-5 w-5 text-indigo-300 group-focus-within:text-indigo-400 transition" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207"/>
                </svg>
              </div>
              <input 
                v-model="form.email" 
                type="email" 
                required
                class="w-full pl-10 pr-4 py-3 bg-white/5 border border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all duration-300"
                placeholder="admin@smkn1subang.sch.id"
              >
            </div>
          </div>

          <!-- Password Field -->
          <div class="group">
            <label class="block text-sm font-medium text-indigo-200 mb-2">Password</label>
            <div class="relative">
              <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                <svg class="h-5 w-5 text-indigo-300 group-focus-within:text-indigo-400 transition" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                </svg>
              </div>
              <input 
                :type="showPassword ? 'text' : 'password'"
                v-model="form.password" 
                required
                class="w-full pl-10 pr-12 py-3 bg-white/5 border border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 transition-all duration-300"
                placeholder="••••••••"
              >
              <button 
                type="button"
                @click="showPassword = !showPassword"
                class="absolute inset-y-0 right-0 pr-3 flex items-center text-indigo-300 hover:text-white transition"
              >
                <svg v-if="!showPassword" class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                </svg>
                <svg v-else class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21"/>
                </svg>
              </button>
            </div>
          </div>

          <!-- Remember Me & Forgot Password -->
          <div class="flex items-center justify-between">
            <label class="flex items-center">
              <input type="checkbox" class="w-4 h-4 rounded border-white/20 bg-white/5 text-indigo-600 focus:ring-indigo-500 focus:ring-offset-0">
              <span class="ml-2 text-sm text-indigo-200">Ingat saya</span>
            </label>
            <a href="#" class="text-sm text-indigo-300 hover:text-white transition">Lupa password?</a>
          </div>

          <!-- Error Message -->
          <div v-if="error" class="bg-red-500/20 border border-red-500/50 text-red-200 p-3 rounded-xl text-sm backdrop-blur-sm animate-shake">
            {{ error }}
          </div>

          <!-- Submit Button -->
          <button 
            type="submit" 
            :disabled="loading"
            class="relative w-full py-3 bg-gradient-to-r from-indigo-500 to-purple-600 text-white rounded-xl font-semibold hover:shadow-xl transition-all duration-300 hover:scale-105 disabled:opacity-50 disabled:cursor-not-allowed overflow-hidden group"
          >
            <span class="relative z-10">{{ loading ? 'Memproses...' : 'Masuk' }}</span>
            <div class="absolute inset-0 bg-gradient-to-r from-indigo-600 to-purple-700 opacity-0 group-hover:opacity-100 transition duration-300"></div>
          </button>
        </form>

        <!-- Demo Credentials -->
        <div class="mt-8 p-4 bg-white/5 rounded-xl border border-white/10">
          <p class="text-xs text-indigo-200 text-center mb-3">Akun Demo</p>
          <div class="grid grid-cols-2 gap-2 text-xs">
            <div class="text-indigo-300">Admin:</div>
            <div class="text-white font-mono text-[11px]">admin@smkn1subang.sch.id</div>
            <div class="text-indigo-300">Guru:</div>
            <div class="text-white font-mono text-[11px]">guru@smkn1subang.sch.id</div>
            <div class="text-indigo-300">Siswa:</div>
            <div class="text-white font-mono text-[11px]">ahmadfauzi@student.com</div>
            <div class="text-indigo-300">Perusahaan:</div>
            <div class="text-white font-mono text-[11px]">perusahaan1@example.com</div>
          </div>
          <p class="text-center text-indigo-300 text-xs mt-3">Password: <span class="text-white font-mono">password</span></p>
        </div>

        <!-- Footer Text -->
        <p class="text-center text-indigo-300 text-xs mt-6">
          &copy; 2024 Monitoring PKL SMKN 1 Subang
        </p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '../../stores/auth'

const router = useRouter()
const authStore = useAuthStore()
const form = ref({ email: '', password: '' })
const loading = ref(false)
const error = ref('')
const showPassword = ref(false)

const handleLogin = async () => {
  loading.value = true
  error.value = ''
  
  try {
    await authStore.login(form.value)
    const role = authStore.role?.toLowerCase()
    router.push(`/${role}/dashboard`)
  } catch (err) {
    error.value = err.response?.data?.message || 'Email atau password salah'
    // Auto clear error after 3 seconds
    setTimeout(() => { error.value = '' }, 3000)
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
@keyframes blob {
  0% { transform: translate(0px, 0px) scale(1); }
  33% { transform: translate(30px, -50px) scale(1.1); }
  66% { transform: translate(-20px, 20px) scale(0.9); }
  100% { transform: translate(0px, 0px) scale(1); }
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes float {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-10px); }
}

@keyframes shake {
  0%, 100% { transform: translateX(0); }
  10%, 30%, 50%, 70%, 90% { transform: translateX(-2px); }
  20%, 40%, 60%, 80% { transform: translateX(2px); }
}

@keyframes particle {
  0% { transform: translateY(0) translateX(0); opacity: 0; }
  50% { opacity: 0.5; }
  100% { transform: translateY(-100px) translateX(20px); opacity: 0; }
}

.animate-blob {
  animation: blob 7s infinite;
}

.animation-delay-2000 {
  animation-delay: 2s;
}

.animation-delay-4000 {
  animation-delay: 4s;
}

.animate-fade-in-up {
  animation: fadeInUp 0.6s ease-out forwards;
}

.animate-float {
  animation: float 3s ease-in-out infinite;
}

.animate-shake {
  animation: shake 0.5s ease-in-out;
}

.animate-particle {
  animation: particle linear infinite;
}

.grid-pattern-overlay {
  position: absolute;
  inset: 0;
  background-image: url('data:image/svg+xml,%3Csvg width="60" height="60" viewBox="0 0 60 60" xmlns="http://www.w3.org/2000/svg"%3E%3Cg fill="none" fill-rule="evenodd"%3E%3Cg fill="%239C92AC" fill-opacity="0.05"%3E%3Cpath d="M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z"/%3E%3C/g%3E%3C/g%3E%3C/svg%3E');
  opacity: 0.2;
}
</style>