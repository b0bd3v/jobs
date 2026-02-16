<template>
  <AdminTable
    ref="table"
    title="Gerenciar Vagas"
    subtitle="Visualize e edite todas as oportunidades publicadas"
    :headers="headers"
    :fetcher="fetchJobs"
  >
    <template #toolbar-actions>
      <v-btn color="primary" prepend-icon="mdi-plus" class="text-none">
        Nova Vaga
      </v-btn>
    </template>

    <template v-slot:[`item.description`]="{ item }">
      <div class="text-truncate" style="max-width: 400px">
        {{ item.description }}
      </div>
    </template>

    <template v-slot:[`item.actions`]="{ item }">
      <v-btn
        size="small"
        variant="text"
        color="primary"
        icon="mdi-eye"
        @click="showJob(item)"
      />
      <v-btn
        size="small"
        variant="text"
        color="primary"
        icon="mdi-pencil"
        @click="editJob(item)"
      />
      <v-btn
        size="small"
        variant="text"
        color="error"
        icon="mdi-delete"
        @click="deleteJob(item)"
      />
    </template>
  </AdminTable>
</template>

<script setup lang="ts">
import { ref } from "vue";
const table = ref();
const { apiFetch } = useAPI();
const { user } = useAuth();

if (!user.value) {
  navigateTo('/login')
}

const headers = [
  { title: "ID", key: "id" },
  { title: "Titulo", key: "title" },
  { title: "Localização", key: "location" },
  { title: "Tipo", key: "employment_type" },
  { title: "Descrição", key: "description" },
  { title: "Status", key: "status" },
  { title: "Ações", key: "actions", sortable: false },
];

async function fetchJobs({ page, itemsPerPage, search, sortBy }: any) {
  const sort = sortBy?.[0]
    ? `${sortBy[0].key}:${sortBy[0].order ?? "asc"}`
    : "";

  const params = new URLSearchParams({
    page: String(page),
    per_page: String(itemsPerPage),
    q: search ?? "",
    sort,
  });

  const res = await apiFetch(`/admin/jobs?${params.toString()}`);

  return { items: res.data, total: res.total };
}

function editJob(item: any) {
  // TODO: Implementar edição de vaga
}

async function deleteJob(item: any) {
  await apiFetch(`/admin/jobs/${item.id}`, {
    method: "DELETE",
    onResponse({ response }) {
      if (response.status === 204) {
        table.value.refresh();
      }
    },
  });
}

function showJob(item: any) {
  navigateTo(`/admin/jobs/${item.id}`);
}
</script>
