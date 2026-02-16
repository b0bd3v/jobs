<template>
  <v-app>
    <NuxtLayout>
      <NuxtPage />
    </NuxtLayout>
  </v-app>
</template>

<script setup lang="ts">
const { loadFromStorage, fetchMe } = useAuth();

onMounted(async () => {
  loadFromStorage();
  if (import.meta.client) {
    await fetchMe();
  }
});
</script>
