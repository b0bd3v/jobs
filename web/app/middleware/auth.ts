export default defineNuxtRouteMiddleware(async (to, from) => {
  const auth = useAuth();
  await auth.loadFromStorage();

  if (!auth.isLoggedIn) {
    return navigateTo('/auth/login');
  }

  if (!auth.user.value) {
    try {
      await auth.fetchMe();
    } catch {
      auth.logout();
      return navigateTo('/auth/login');
    }
  }
});
