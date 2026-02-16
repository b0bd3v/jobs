<template>
  <v-row class="mt-4">
    <v-col cols="12" md="6">
      <v-text-field
        v-model="search"
        label="Buscar vagas"
        prepend-inner-icon="mdi-magnify"
        variant="outlined"
        hide-details
        density="comfortable"
        rounded="lg"
        @update:model-value="debouncedSearch"
      ></v-text-field>
    </v-col>
  </v-row>
</template>

<script setup lang="ts">
import { ref } from 'vue';

const emit = defineEmits(['search']);

const search = ref('');
let timeout: ReturnType<typeof setTimeout>;

const debouncedSearch = (value: string) => {
  clearTimeout(timeout);
  timeout = setTimeout(() => {
    emit('search', value);
  }, 500);
};
</script>
