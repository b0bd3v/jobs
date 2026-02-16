<template>
  <v-container>
    <h1>Vagas</h1>
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
