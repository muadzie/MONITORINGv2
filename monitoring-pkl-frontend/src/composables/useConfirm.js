import { ref } from 'vue'

const showConfirm = ref(false)
const title = ref('')
const message = ref('')
const confirmText = ref('Ya, Hapus')
const cancelText = ref('Batal')
const type = ref('danger')
let resolveCallback = null

export function useConfirm() {
  const confirm = (opts) => {
    title.value = opts.title || 'Konfirmasi'
    message.value = opts.message || ''
    confirmText.value = opts.confirmText || 'Ya, Hapus'
    cancelText.value = opts.cancelText || 'Batal'
    type.value = opts.type || 'danger'
    showConfirm.value = true

    return new Promise((resolve) => {
      resolveCallback = resolve
    })
  }

  const onConfirm = () => {
    showConfirm.value = false
    if (resolveCallback) resolveCallback(true)
  }

  const onCancel = () => {
    showConfirm.value = false
    if (resolveCallback) resolveCallback(false)
  }

  return { showConfirm, title, message, confirmText, cancelText, type, confirm, onConfirm, onCancel }
}
