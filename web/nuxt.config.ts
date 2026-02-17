import vuetify, { transformAssetUrls } from 'vite-plugin-vuetify'

export default defineNuxtConfig({
  css: ['vuetify/styles', '@mdi/font/css/materialdesignicons.min.css'],
  build: {
    transpile: ['vuetify'],
  },

  vite: {
    plugins: [
      // @ts-ignore
      vuetify({ autoImport: true })
    ],
    vue: {
      template: {
        transformAssetUrls,
      },
    },
  },

  runtimeConfig: {
    apiSecret: '',
    public: {
      apiBase: '',
    },
  },

  compatibilityDate: '2025-07-15',
  srcDir: 'app',
  devtools: { enabled: true },
  ssr: false,
})
