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
        <v-card
          class="pa-4 d-flex flex-column"
          :to="`/jobs/${job.id}`"
          height="300"
        >
          <v-card-title class="text-wrap text-h6 px-0 pt-0">
            {{ job.title }}
          </v-card-title>
          <v-card-text class="text-body-1 text-medium-emphasis px-0">
            <div
              style="
                display: -webkit-box;
                -webkit-line-clamp: 3;
                -webkit-box-orient: vertical;
                overflow: hidden;
              "
            >
              {{ job.description }}
            </div>
          </v-card-text>
          <v-card-text class="px-0">
            <v-chip class="mr-2" size="small" color="primary">
              {{ job.location }}
            </v-chip>
            <v-chip size="small" color="primary">
              {{ job.employment_type }}
            </v-chip>
          </v-card-text>
          <v-spacer></v-spacer>
          <v-card-actions class="px-0 pb-0">
            <v-btn color="primary" variant="text">Ver Vaga</v-btn>
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
