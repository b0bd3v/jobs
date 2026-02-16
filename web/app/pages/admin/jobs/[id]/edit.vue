<template>
  <v-container fluid class="px-6 py-6" style="max-width: 800px; margin: 0 auto">
    <div class="mb-6">
      <v-btn
        icon="mdi-arrow-left"
        variant="text"
        @click="navigateTo(`/admin/jobs/${route.params.id}`)"
        class="mb-2"
      ></v-btn>
      <h1 class="text-h4 font-weight-bold">Editar Vaga</h1>
    </div>

    <JobForm
      :initial-data="job"
      :loading="loading"
      submit-button-text="Salvar Alterações"
      @submit="handleSubmit"
      @cancel="navigateTo(`/admin/jobs/${route.params.id}`)"
    />
  </v-container>
</template>

<script setup lang="ts">
import { ref } from "vue";
import JobForm from "~/components/admin/JobForm.vue";

const route = useRoute();
const { apiFetch } = useAPI();
const loading = ref(false);

const job = await apiFetch(`/admin/jobs/${route.params.id}`);

async function handleSubmit(formData: any) {
  loading.value = true;
  try {
    await apiFetch(`/admin/jobs/${route.params.id}`, {
      method: "PUT",
      body: { job: formData },
    });
    navigateTo(`/admin/jobs/${route.params.id}`);
  } catch (e) {
    console.error(e);
    alert("Erro ao atualizar vaga");
  } finally {
    loading.value = false;
  }
}
</script>
