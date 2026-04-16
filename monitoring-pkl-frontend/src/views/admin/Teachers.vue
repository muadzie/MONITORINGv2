<template>
  <div class="space-y-6">
    <div class="flex justify-between"><h1 class="text-2xl font-bold">Manajemen Guru</h1><button @click="openModal" class="bg-indigo-600 text-white px-4 py-2 rounded-lg">+ Tambah</button></div>
    <div class="bg-white rounded-xl shadow-sm overflow-hidden"><table class="w-full"><thead class="bg-gray-50"><tr><th class="px-6 py-3">Nama</th><th class="px-6 py-3">Email</th><th class="px-6 py-3">Aksi</th></tr></thead><tbody><tr v-for="t in teachers" :key="t.id" class="border-t"><td class="px-6 py-4">{{ t.name }}</td><td class="px-6 py-4">{{ t.email }}</td><td class="px-6 py-4"><button @click="editTeacher(t)" class="text-indigo-600 mr-2">Edit</button><button @click="deleteTeacher(t)" class="text-red-600">Hapus</button></td></tr></tbody></table></div>
    <div v-if="showModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center"><div class="bg-white p-6 rounded-xl w-96"><h3 class="text-xl font-bold mb-4">{{ isEdit ? 'Edit' : 'Tambah' }} Guru</h3><form @submit.prevent="submitTeacher"><input v-model="form.name" placeholder="Nama" class="w-full p-2 border rounded mb-2"><input v-model="form.email" type="email" placeholder="Email" class="w-full p-2 border rounded mb-2"><input v-model="form.password" type="password" placeholder="Password" class="w-full p-2 border rounded mb-4"><div class="flex justify-end"><button type="button" @click="closeModal" class="px-4 py-2 border rounded mr-2">Batal</button><button type="submit" class="px-4 py-2 bg-indigo-600 text-white rounded">Simpan</button></div></form></div></div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import axios from '../../plugins/axios'
import { useToast } from 'vue-toastification'

const toast = useToast()
const teachers = ref([])
const showModal = ref(false)
const isEdit = ref(false)
const form = ref({ id: null, name: '', email: '', password: '' })

const load = async () => { try { const res = await axios.get('/admin/teachers'); teachers.value = res.data } catch(e) {} }
const openModal = () => { isEdit.value = false; form.value = { id: null, name: '', email: '', password: '' }; showModal.value = true }
const editTeacher = (t) => { isEdit.value = true; form.value = { ...t, password: '' }; showModal.value = true }
const closeModal = () => { showModal.value = false }
const submitTeacher = async () => { try { if (isEdit.value) await axios.put(`/admin/teachers/${form.value.id}`, form.value); else await axios.post('/admin/teachers', form.value); toast.success('Berhasil'); closeModal(); load() } catch(e) { toast.error('Gagal') } }
const deleteTeacher = async (t) => { if (confirm('Hapus?')) { try { await axios.delete(`/admin/teachers/${t.id}`); toast.success('Berhasil'); load() } catch(e) { toast.error('Gagal') } } }
onMounted(() => load())
</script>