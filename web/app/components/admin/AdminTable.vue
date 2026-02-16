<template>
  <v-card variant="flat" border class="bg-white rounded-lg">
    <v-card-item class="pb-2">
      <div class="d-flex align-center justify-space-between flex-wrap ga-4">
        <div>
          <v-card-title class="px-0 pt-0 text-h5 font-weight-bold">
            {{ title }}
          </v-card-title>
          <v-card-subtitle class="px-0" v-if="subtitle">
            {{ subtitle }}
          </v-card-subtitle>
        </div>

        <div class="d-flex ga-3 align-center flex-grow-1 flex-md-grow-0">
          <v-text-field
            v-model="search"
            density="compact"
            variant="solo-filled"
            flat
            hide-details
            label="Buscar..."
            prepend-inner-icon="mdi-magnify"
            clearable
            persistent-clear
            rounded="lg"
            style="min-width: 300px"
          />
          <slot name="toolbar-actions" />
        </div>
      </div>
    </v-card-item>

    <div v-if="$slots.filters" class="px-4 pb-4">
      <slot name="filters" />
    </div>

    <v-divider />

    <!-- eslint-disable vue/no-v-model-argument -->
    <v-data-table-server
      :headers="headers"
      :items="items"
      :items-length="total"
      v-model:page="page"
      v-model:items-per-page="itemsPerPage"
      v-model:sort-by="sortBy"
      :loading="loading"
      hover
      :header-props="{
        class:
          'font-weight-bold text-uppercase text-caption text-medium-emphasis',
        style: 'letter-spacing: 0.05em',
      }"
    >
      <template v-for="(_, slotName) in $slots" #[slotName]="slotProps">
        <slot :name="slotName" v-bind="slotProps" />
      </template>

      <template #no-data> Nada pra mostrar </template>
    </v-data-table-server>
    <!-- eslint-enable vue/no-v-model-argument -->
  </v-card>
</template>

<script setup lang="ts">
import { ref, watch, computed } from "vue";

type SortItem = { key: string; order?: "asc" | "desc" };

export type AdminTableFetchParams = {
  page: number;
  itemsPerPage: number;
  search: string;
  sortBy: SortItem[];
  filters: Record<string, any>;
};

export type AdminTableFetchResult<T> = {
  items: T[];
  total: number;
};

const props = defineProps<{
  title?: string;
  subtitle?: string;
  headers: any[];
  fetcher: (
    params: AdminTableFetchParams,
  ) => Promise<AdminTableFetchResult<any>>;
  filters?: Record<string, any>;
  initialItemsPerPage?: number;
}>();

const loading = ref(false);
const items = ref<any[]>([]);
const total = ref(0);

const search = ref("");
const page = ref(1);
const itemsPerPage = ref(props.initialItemsPerPage ?? 10);
const sortBy = ref<SortItem[]>([]);

const effectiveFilters = computed(() => props.filters ?? {});

async function load() {
  loading.value = true;

  try {
    const res = await props.fetcher({
      page: page.value,
      itemsPerPage: itemsPerPage.value,
      search: search.value,
      sortBy: sortBy.value,
      filters: effectiveFilters.value,
    });
    items.value = res.items;
    total.value = res.total;
  } finally {
    loading.value = false;
  }
}

watch([page, itemsPerPage, sortBy, effectiveFilters], load, { deep: true });

let t: any;

watch(search, () => {
  clearTimeout(t);
  t = setTimeout(() => {
    page.value = 1;
    load();
  }, 350);
});

load();

defineExpose({ refresh: load });
</script>
