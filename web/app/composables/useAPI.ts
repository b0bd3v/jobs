export const useAPI = () => {
  const config = useRuntimeConfig();

  const apiFetch = $fetch.create({
    baseURL: config.public.apiBase as string,
    onRequest({ options }) {
      const auth = useAuth();
      const token = auth.token.value;

      if (token) {
        const headers = new Headers(options.headers);
        headers.set('Authorization', `Bearer ${token}`);
        options.headers = headers;
      }
    }
  });

  return { apiFetch };
}