<template>
  <v-container fluid class="px-6 py-6" style="max-width: 800px; margin: 0 auto">
    <div class="mb-6">
      <v-btn
        icon="mdi-arrow-left"
        variant="text"
        @click="navigateTo('/admin/jobs')"
        class="mb-2"
      ></v-btn>
      <h1 class="text-h4 font-weight-bold">Nova Vaga</h1>
    </div>

    <JobForm
      :loading="loading"
      submit-button-text="Criar Vaga"
      @submit="handleSubmit"
      @cancel="navigateTo('/admin/jobs')"
    />
  </v-container>
</template>

<script setup lang="ts">
import { ref } from "vue";
import JobForm from "~/components/admin/JobForm.vue";

const { apiFetch } = useAPI();
const loading = ref(false);

async function handleSubmit(formData: any) {
  loading.value = true;
  try {
    await apiFetch("/admin/jobs", {
      method: "POST",
      body: { job: formData },
    });
    navigateTo("/admin/jobs");
  } catch (e) {
    console.error(e);
    alert("Erro ao criar vaga");
  } finally {
    loading.value = false;
  }
}
</script>
