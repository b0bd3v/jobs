<template>
  <v-container fluid class="bg-grey-lighten-4 fill-height">
    <v-row class="fill-height" align="center" justify="center">
      <v-col cols="12" sm="8" md="5" lg="4">
        <v-card class="pa-6" elevation="8">
          <v-card-title class="text-h5 font-weight-medium px-0">
            Entrar
          </v-card-title>

          <v-alert
            v-if="errorMessage"
            type="error"
            density="comfortable"
            variant="tonal"
            class="mb-4"
          >
            {{ errorMessage }}
          </v-alert>

          <v-form
            ref="formRef"
            @submit.prevent="handleSubmit"
            :disabled="isSubmitting"
          >
            <v-text-field
              v-model="email"
              label="E-mail"
              type="email"
              autocomplete="email"
              :rules="[rules.required, rules.email]"
              density="comfortable"
              variant="outlined"
              class="mb-3"
              autofocus
            />

            <v-text-field
              v-model="password"
              label="Senha"
              type="password"
              autocomplete="current-password"
              :rules="[rules.required, rules.minPassword]"
              density="comfortable"
              variant="outlined"
              class="mb-6"
            />

            <v-btn
              type="submit"
              color="primary"
              size="large"
              block
              :loading="isSubmitting"
            >
              Entrar
            </v-btn>
          </v-form>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup lang="ts">
import type { VForm } from "vuetify/components";

const router = useRouter();
const auth = useAuth();

const email = ref("");
const password = ref("");
const isSubmitting = ref(false);
const errorMessage = ref("");
const formRef = ref<VForm | null>(null);

const EMAIL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

const rules = {
  required: (value: string) => !!value || "Campo obrigatório",
  email: (value: string) => EMAIL_REGEX.test(value) || "E-mail inválido",
  minPassword: (value: string) => value.length >= 6 || "Mínimo de 6 caracteres",
};

const handleSubmit = async () => {
  if (isSubmitting.value) return;

  const result = await formRef.value?.validate();
  if (result && !result.valid) return;

  isSubmitting.value = true;
  errorMessage.value = "";

  try {
    await auth.login(email.value.trim(), password.value);
    await router.push("/admin/jobs");
  } catch {
    errorMessage.value =
      "Não foi possível fazer login. Verifique os dados e tente novamente.";
  } finally {
    isSubmitting.value = false;
  }
};

onMounted(() => {
  auth.loadFromStorage();

  if (auth.isLoggedIn.value) {
    router.replace("/admin/jobs");
  }
});
</script>
