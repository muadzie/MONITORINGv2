<template>
  <LoadingScreen :visible="loading" />
  <router-view />
  <ConfirmDialog
    :visible="showConfirm"
    :title="confirmTitle"
    :message="confirmMessage"
    :confirm-text="confirmConfirmText"
    :cancel-text="confirmCancelText"
    :type="confirmType"
    @confirm="onConfirm"
    @cancel="onCancel"
  />
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useAuthStore } from './stores/auth'
import { useConfirm } from './composables/useConfirm'
import LoadingScreen from './components/LoadingScreen.vue'
import ConfirmDialog from './components/ConfirmDialog.vue'

const { showConfirm, onConfirm, onCancel, title: confirmTitle, message: confirmMessage, confirmText: confirmConfirmText, cancelText: confirmCancelText, type: confirmType } = useConfirm()

const authStore = useAuthStore()
const loading = ref(true)

onMounted(async () => {
  await authStore.checkAuth()
  loading.value = false
})
</script>
