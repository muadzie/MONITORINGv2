<template>
  <div class="space-y-6">
    <div class="flex justify-between"><h1 class="text-2xl font-bold">Manajemen Siswa</h1><button @click="openModal" class="bg-indigo-600 text-white px-4 py-2 rounded-lg">+ Tambah</button></div>
    <div class="bg-white rounded-xl shadow-sm overflow-hidden"><table class="w-full"><thead class="bg-gray-50"><tr><th class="px-6 py-3">NISN</th><th class="px-6 py-3">Nama</th><th class="px-6 py-3">Email</th><th class="px-6 py-3">Perusahaan</th><th class="px-6 py-3">Aksi</th></tr></thead><tbody><tr v-for="s in students" :key="s.id" class="border-t"><td class="px-6 py-4">{{ s.nisn }}</td><td class="px-6 py-4">{{ s.name }}</td><td class="px-6 py-4">{{ s.email }}</td><td class="px-6 py-4">{{ s.company?.name || '-' }}</td><td class="px-6 py-4"><button @click="editStudent(s)" class="text-indigo-600 mr-2">Edit</button><button @click="deleteStudent(s)" class="text-red-600">Hapus</button></td></tr></tbody></table></div>
    <div v-if="showModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center"><div class="bg-white p-6 rounded-xl w-96"><h3 class="text-xl font-bold mb-4">{{ isEdit ? 'Edit' : 'Tambah' }} Siswa</h3><form @submit.prevent="submitStudent"><input v-model="form.nisn" placeholder="NISN" class="w-full p-2 border rounded mb-2"><input v-model="form.name" placeholder="Nama" class="w-full p-2 border rounded mb-2"><input v-model="form.email" type="email" placeholder="Email" class="w-full p-2 border rounded mb-2"><select v-model="form.company_id" class="w-full p-2 border rounded mb-2"><option value="">Pilih Perusahaan</option><option v-for="c in companies" :key="c.id" :value="c.id">{{ c.name }}</option></select><input v-model="form.password" type="password" placeholder="Password" class="w-full p-2 border rounded mb-4"><div class="flex justify-end"><button type="button" @click="closeModal" class="px-4 py-2 border rounded mr-2">Batal</button><button type="submit" class="px-4 py-2 bg-indigo-600 text-white rounded">Simpan</button></div></form></div></div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import axios from '../../plugins/axios'
import { useToast } from 'vue-toastification'

const toast = useToast()
const students = ref([])
const companies = ref([])
const showModal = ref(false)
const isEdit = ref(false)
const form = ref({ id: null, nisn: '', name: '', email: '', company_id: '', password: '' })

const load = async () => { try { const res = await axios.get('/admin/students'); students.value = res.data; const res2 = await axios.get('/companies'); companies.value = res2.data } catch(e) {} }
const openModal = () => { isEdit.value = false; form.value = { id: null, nisn: '', name: '', email: '', company_id: '', password: '' }; showModal.value = true }
const editStudent = (s) => { isEdit.value = true; form.value = { ...s, password: '' }; showModal.value = true }
const closeModal = () => { showModal.value = false }
const submitStudent = async () => { try { if (isEdit.value) await axios.put(`/admin/students/${form.value.id}`, form.value); else await axios.post('/admin/students', form.value); toast.success('Berhasil'); closeModal(); load() } catch(e) { toast.error('Gagal') } }
const deleteStudent = async (s) => { if (confirm('Hapus?')) { try { await axios.delete(`/admin/students/${s.id}`); toast.success('Berhasil'); load() } catch(e) { toast.error('Gagal') } } }
onMounted(() => load())
</script>