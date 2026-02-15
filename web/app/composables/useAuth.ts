type User = { id: number; email: string; }

interface AuthResponse {
  data: {
    user: User;
  };
  token?: string;
}

export const useAuth = () => {
  const token = useState<string | null>('token', () => null);
  const user = useState<User | null>('user', () => null);

  const loadFromStorage = () => {
    if (import.meta.client) token.value = localStorage.getItem('token');
  }

  const saveToStorage = () => {
    if (!import.meta.client) return;

    if (token.value) {
      localStorage.setItem('token', token.value);
    } else {
      localStorage.removeItem('token');
    }
  }

  const { apiFetch } = useAPI();

  const login = async (email: string, password: string) => {
    try {
      const response = await apiFetch.raw<AuthResponse>('/auth/login', {
        method: 'POST',
        body: { user: { email, password } }
      });

      const authToken = response.headers.get('Authorization');
      
      if (authToken) {
        token.value = authToken.replace(/^Bearer\s+/i, '');
      }

      if (response._data) {
        user.value = response._data.data.user;
      }
      saveToStorage();
    } catch (error: any) {
      if (error.statusCode === 401) {
        throw new Error('E-mail ou senha inválidos');
      }
      throw error;
    }
  }

  // TODO: Fazer o logout invalidar token na API
  const logout = () => {
    token.value = null;
    user.value = null;
    saveToStorage();
  }

  const fetchMe = async () => {
    if (!token.value) return;

    const response = await apiFetch<AuthResponse>('/auth/me');
    user.value = response.data.user;
  }

  const isLoggedIn = computed(() => !!token.value);

  return {
    token,
    user,
    isLoggedIn,
    login,
    logout,
    fetchMe,
    loadFromStorage,
  }
}