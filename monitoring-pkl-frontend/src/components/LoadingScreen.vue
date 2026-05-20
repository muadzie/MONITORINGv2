<template>
  <div v-if="visible" class="loading-screen">
    <div class="loading-content">
      <img src="/logo.webp" alt="Logo" class="loading-logo" />
      <div class="loading-spinner">
        <div class="spinner"></div>
      </div>
      <p class="loading-text">{{ text }}</p>
    </div>
  </div>
</template>

<script setup>
defineProps({
  visible: Boolean,
  text: { type: String, default: 'Memuat...' }
})
</script>

<style scoped>
.loading-screen {
  position: fixed;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  background: transparent;
  backdrop-filter: blur(8px);
  -webkit-backdrop-filter: blur(8px);
  z-index: 9999;
}

.loading-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 24px;
}

.loading-logo {
  width: 120px;
  height: auto;
  animation: pulse 2s ease-in-out infinite;
}

.loading-text {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  font-size: 14px;
  color: #64748b;
  font-weight: 500;
}

.loading-spinner {
  display: flex;
  justify-content: center;
}

.spinner {
  width: 36px;
  height: 36px;
  border: 4px solid #e2e8f0;
  border-top: 4px solid #6366f1;
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

@keyframes pulse {
  0%, 100% { transform: scale(1); opacity: 1; }
  50% { transform: scale(1.05); opacity: 0.8; }
}
</style>
