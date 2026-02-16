<template>
  <v-card variant="flat" border class="bg-white rounded-lg">
    <v-form @submit.prevent="handleSubmit" :disabled="loading">
      <v-card-text>
        <v-row>
          <v-col cols="12">
            <v-text-field
              v-model="localForm.title"
              label="Título da Vaga"
              variant="outlined"
              required
              :rules="[(v) => !!v || 'Campo obrigatório']"
            ></v-text-field>
          </v-col>

          <v-col cols="12" md="6">
            <v-text-field
              v-model="localForm.location"
              label="Localização"
              variant="outlined"
              required
              :rules="[(v) => !!v || 'Campo obrigatório']"
            ></v-text-field>
          </v-col>

          <v-col cols="12" md="6">
            <v-select
              v-model="localForm.employment_type"
              label="Tipo de Contratação"
              :items="[
                { title: 'CLT', value: 'clt' },
                { title: 'PJ', value: 'pj' },
                { title: 'Estágio', value: 'internship' },
              ]"
              variant="outlined"
              required
              :rules="[(v) => !!v || 'Campo obrigatório']"
            ></v-select>
          </v-col>

          <v-col cols="12">
            <v-textarea
              v-model="localForm.description"
              label="Descrição"
              variant="outlined"
              rows="10"
              required
              :rules="[(v) => !!v || 'Campo obrigatório']"
            ></v-textarea>
          </v-col>

          <v-col cols="12">
            <v-select
              v-model="localForm.status"
              label="Status"
              :items="[
                { title: 'Rascunho', value: 'draft' },
                { title: 'Publicada', value: 'published' },
              ]"
              variant="outlined"
              required
            ></v-select>
          </v-col>
        </v-row>
      </v-card-text>

      <v-divider></v-divider>

      <v-card-actions class="pa-4">
        <v-spacer></v-spacer>
        <v-btn
          variant="text"
          color="grey-darken-1"
          @click="$emit('cancel')"
        >
          Cancelar
        </v-btn>
        <v-btn
          color="primary"
          variant="flat"
          type="submit"
          :loading="loading"
        >
          {{ submitButtonText }}
        </v-btn>
      </v-card-actions>
    </v-form>
  </v-card>
</template>

<script setup lang="ts">
import { reactive, watch } from "vue";

interface JobFormData {
  title: string;
  description: string;
  location: string;
  employment_type: string;
  status: string;
}

interface Props {
  initialData?: Partial<JobFormData>;
  loading?: boolean;
  submitButtonText?: string;
}

const props = withDefaults(defineProps<Props>(), {
  initialData: () => ({
    title: "",
    description: "",
    location: "",
    employment_type: "clt",
    status: "draft",
  }),
  loading: false,
  submitButtonText: "Salvar",
});

const emit = defineEmits<{
  (e: "submit", data: JobFormData): void;
  (e: "cancel"): void;
}>();

const localForm = reactive<JobFormData>({
  title: props.initialData?.title || "",
  description: props.initialData?.description || "",
  location: props.initialData?.location || "",
  employment_type: props.initialData?.employment_type || "clt",
  status: props.initialData?.status || "draft",
});

watch(
  () => props.initialData,
  (newData) => {
    if (newData) {
      localForm.title = newData.title || "";
      localForm.description = newData.description || "";
      localForm.location = newData.location || "";
      localForm.employment_type = newData.employment_type || "clt";
      localForm.status = newData.status || "draft";
    }
  },
  { deep: true }
);

function handleSubmit() {
  if (
    !localForm.title ||
    !localForm.description ||
    !localForm.location ||
    !localForm.employment_type
  ) {
    return;
  }

  emit("submit", { ...localForm });
}
</script>
