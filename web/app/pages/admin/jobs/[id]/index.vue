<template>
  <v-container fluid class="px-6 py-6" style="max-width: 1200px; margin: 0 auto">
    <div class="d-flex align-center justify-space-between mb-6">
      <div class="d-flex align-center gap-4">
        <v-btn
          icon="mdi-arrow-left"
          variant="text"
          @click="navigateTo('/admin/jobs')"
        ></v-btn>
        <div>
          <h1 class="text-h4 font-weight-bold">{{ job.title }}</h1>
          <div class="text-subtitle-1 text-medium-emphasis">
            {{ job.location }} • {{ job.employment_type }}
          </div>
        </div>
      </div>

      <div class="d-flex gap-2">
        <v-btn
          prepend-icon="mdi-pencil"
          variant="outlined"
          color="primary"
          @click="editJob"
        >
          Editar
        </v-btn>
        <v-btn
          prepend-icon="mdi-delete"
          color="error"
          variant="tonal"
          @click="deleteDialog = true"
        >
          Excluir
        </v-btn>
      </div>
    </div>

    <v-row>
      <v-col cols="12" md="8">
        <v-card variant="flat" border class="bg-white rounded-lg h-100">
          <v-card-title class="font-weight-bold">Descrição</v-card-title>
          <v-divider></v-divider>
          <v-card-text class="text-body-1" style="white-space: pre-wrap">
            {{ job.description }}
          </v-card-text>
        </v-card>
      </v-col>
      <v-col cols="12" md="4">
        <v-card variant="flat" border class="bg-white rounded-lg mb-4">
          <v-card-item>
            <div class="d-flex flex-column gap-4">
              <div>
                <div class="text-caption text-medium-emphasis mb-1">Status</div>
                <v-chip
                  :color="job.status === 'published' ? 'success' : 'warning'"
                  variant="flat"
                  size="small"
                  class="text-uppercase font-weight-bold"
                >
                  {{ job.status === "published" ? "Publicada" : "Rascunho" }}
                </v-chip>
              </div>

              <div>
                <div class="text-caption text-medium-emphasis mb-1">
                  Localização
                </div>
                <div class="d-flex align-center gap-2">
                  <v-icon icon="mdi-map-marker" size="small" color="primary" />
                  <span>{{ job.location }}</span>
                </div>
              </div>

              <div>
                <div class="text-caption text-medium-emphasis mb-1">Tipo</div>
                <div class="d-flex align-center gap-2">
                  <v-icon icon="mdi-briefcase" size="small" color="primary" />
                  <span class="text-capitalize">{{ job.employment_type }}</span>
                </div>
              </div>
            </div>
          </v-card-item>
        </v-card>
      </v-col>
    </v-row>

    <v-dialog v-model="deleteDialog" max-width="400">
      <v-card>
        <v-card-title class="text-h5">Confirmar Exclusão</v-card-title>
        <v-card-text>
          Tem certeza que deseja excluir a vaga <strong>{{ job.title }}</strong
          >? Esta ação não pode ser desfeita.
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            color="grey-darken-1"
            variant="text"
            @click="deleteDialog = false"
            >Cancelar</v-btn
          >
          <v-btn
            color="error"
            variant="flat"
            :loading="deleting"
            @click="deleteJob"
            >Excluir</v-btn
          >
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script setup lang="ts">
const route = useRoute();
const { apiFetch } = useAPI();

const job = await apiFetch(`/admin/jobs/${route.params.id}`);

const deleteDialog = ref(false);
const deleting = ref(false);

function editJob() {
  console.log('Editando vaga: ', job.id);
  
  navigateTo(`/admin/jobs/${job.id}/edit`);
}

async function deleteJob() {
  deleting.value = true;
  try {
    await apiFetch(`/admin/jobs/${job.id}`, {
      method: "DELETE",
    });
    navigateTo("/admin/jobs");
  } catch (e) {
    console.error(e);
  } finally {
    deleting.value = false;
    deleteDialog.value = false;
  }
}
</script>

<style scoped>
.gap-2 {
  gap: 8px;
}
.gap-4 {
  gap: 16px;
}
</style>
