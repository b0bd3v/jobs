<template>
  <v-app-bar flat border elevated>
    <v-container class="d-flex align-center py-0">
      <v-avatar class="me-4" color="primary" size="32" variant="tonal">
        <v-icon icon="mdi-briefcase-variant" />
      </v-avatar>

      <v-toolbar-title
        class="font-weight-bold"
        style="cursor: pointer"
        @click="navigateTo('/')"
      >
        Talenses Group <span class="text-primary">Vagas</span>
      </v-toolbar-title>

      <v-spacer />
      <v-btn to="/" variant="text" class="text-none me-2"> Home </v-btn>

      <v-btn
        v-if="isLoggedIn"
        to="/admin/jobs"
        variant="text"
        class="text-none me-2"
      >
        Admin
      </v-btn>

      <template v-if="isLoggedIn">
        <v-menu min-width="200px" rounded>
          <template v-slot:activator="{ props }">
            <v-btn icon v-bind="props" variant="tonal" color="primary">
              <v-avatar color="primary" size="32">
                <span class="text-caption">{{ userInitials }}</span>
              </v-avatar>
            </v-btn>
          </template>
          <v-card>
            <v-card-text class="mt-2 mx-3">
              <div class="mx-auto text-center">
                <v-avatar color="primary" class="mb-2">
                  <span class="text-h6">{{ userInitials }}</span>
                </v-avatar>
                <h3 class="text-h6">{{ user?.email }}</h3>
                <v-btn
                  rounded
                  variant="text"
                  color="error"
                  block
                  prepend-icon="mdi-logout"
                  @click="handleLogout"
                >
                  Sair
                </v-btn>
              </div>
            </v-card-text>
          </v-card>
        </v-menu>
      </template>
      <template v-else>
        <v-btn
          to="/login"
          color="primary"
          variant="elevated"
          class="text-none px-6"
          rounded="lg"
        >
          Entrar
        </v-btn>
      </template>
    </v-container>
  </v-app-bar>
</template>

<script setup lang="ts">
const { user, isLoggedIn, logout } = useAuth();
const router = useRouter();

const userInitials = computed(() => {
  if (!user.value?.email) return "";
  return user.value.email.charAt(0).toUpperCase();
});

const handleLogout = () => {
  logout();
  router.push("/login");
};
</script>
