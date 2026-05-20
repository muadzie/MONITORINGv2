<template>
  <Teleport to="body">
    <Transition name="fade">
      <div v-if="visible" class="fixed inset-0 z-[9999] flex items-center justify-center p-4">
        <div class="fixed inset-0 bg-black/50" @click="cancel"></div>
        <div class="relative bg-white rounded-2xl shadow-2xl w-full max-w-md p-6 animate-scale">
          <div class="flex items-center gap-4 mb-4">
            <div class="w-12 h-12 rounded-full flex items-center justify-center" :class="type === 'danger' ? 'bg-red-100' : 'bg-indigo-100'">
              <svg v-if="type === 'danger'" class="w-6 h-6 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L4.082 16.5c-.77.833.192 2.5 1.732 2.5z"/>
              </svg>
              <svg v-else class="w-6 h-6 text-indigo-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
              </svg>
            </div>
            <div>
              <h3 class="text-lg font-bold text-gray-800">{{ title }}</h3>
              <p class="text-sm text-gray-500 mt-1">{{ message }}</p>
            </div>
          </div>
          <div class="flex justify-end gap-3 mt-6">
            <button @click="cancel" class="px-5 py-2.5 border border-gray-300 rounded-xl text-gray-700 hover:bg-gray-50 transition font-medium text-sm">
              {{ cancelText }}
            </button>
            <button @click="confirm" class="px-5 py-2.5 rounded-xl text-white transition font-medium text-sm shadow-lg" :class="type === 'danger' ? 'bg-red-600 hover:bg-red-700' : 'bg-indigo-600 hover:bg-indigo-700'">
              {{ confirmText }}
            </button>
          </div>
        </div>
      </div>
    </Transition>
  </Teleport>
</template>

<script setup>
const props = defineProps({
  visible: Boolean,
  title: { type: String, default: 'Konfirmasi' },
  message: { type: String, default: 'Apakah Anda yakin?' },
  confirmText: { type: String, default: 'Ya, Hapus' },
  cancelText: { type: String, default: 'Batal' },
  type: { type: String, default: 'danger' }
})

const emit = defineEmits(['confirm', 'cancel', 'update:visible'])

const confirm = () => { emit('confirm'); emit('update:visible', false) }
const cancel = () => { emit('cancel'); emit('update:visible', false) }
</script>

<style scoped>
.fade-enter-active, .fade-leave-active { transition: opacity 0.2s ease; }
.fade-enter-from, .fade-leave-to { opacity: 0; }

@keyframes scaleIn {
  from { transform: scale(0.95); opacity: 0; }
  to { transform: scale(1); opacity: 1; }
}
.animate-scale { animation: scaleIn 0.15s ease-out; }
</style>
