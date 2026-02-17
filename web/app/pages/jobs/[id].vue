<template>
  <v-container class="py-10">
    <v-row justify="center">
      <v-col cols="12" md="10" lg="8">
        <v-btn
          variant="text"
          prepend-icon="mdi-arrow-left"
          to="/"
          class="mb-6"
          color="grey-darken-1"
        >
          Voltar para Vagas
        </v-btn>

        <v-card border flat class="pa-8 rounded-lg">
          <v-card-item class="px-0">
            <v-card-title class="text-h3 font-weight-bold mb-6 text-wrap">
              {{ job.title }}
            </v-card-title>
          </v-card-item>

          <v-card-text class="px-0">
            <h3 class="text-h5 font-weight-medium mb-4">Descrição da Vaga</h3>
            <div
              class="text-body-1 text-grey-darken-3"
              style="white-space: pre-wrap; line-height: 1.8"
            >
              {{ job.description }}
            </div>
          </v-card-text>

          <v-card-actions class="px-0 mt-8">
            <v-btn
              color="primary"
              size="large"
              variant="elevated"
              block
              class="text-none"
            >
              Candidatar-se agora
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup lang="ts">
const { apiFetch } = useAPI();
const route = useRoute();
const job = await apiFetch(`/jobs/${route.params.id}`);
</script>
