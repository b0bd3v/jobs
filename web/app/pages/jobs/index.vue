<template>
  <v-container>
    <v-row class="mt-6">
      <v-col cols="12">
        <h1 class="text-h4 font-weight-bold mb-4">Vagas Disponíveis</h1>
        <p class="text-body-1 text-medium-emphasis font-weight-regular">
          Explore as oportunidades de carreira e encontre o seu próximo desafio
          profissional.
        </p>
        <v-divider
          class="mt-6"
          color="primary"
          length="64"
          thickness="4"
        ></v-divider>
      </v-col>
    </v-row>
    <v-row>
      <v-col v-for="job in jobs" :key="job.id" cols="12" md="6" lg="4">
        <v-card class="pa-4" :to="`/jobs/${job.id}`">
          <v-card-title>{{ job.title }}</v-card-title>
          <v-card-text>{{ job.description }}</v-card-text>
          <v-card-actions>
            <v-btn color="primary">Ver Vaga</v-btn>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup lang="ts">
const { apiFetch } = useAPI();
const jobs = await apiFetch("/jobs");
</script>
