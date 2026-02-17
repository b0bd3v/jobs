export const useFormat = () => {
  const formatDate = (dateString: string | null | undefined) => {
    if (!dateString) return '';
    const date = new Date(dateString);
    return new Intl.DateTimeFormat('pt-BR', { day: 'numeric', month: 'long', year: 'numeric' }).format(date);
  };

  const formatDateShort = (dateString: string | null | undefined) => {
    if (!dateString) return '';
    const date = new Date(dateString);
    return new Intl.DateTimeFormat('pt-BR', { day: '2-digit', month: '2-digit', year: 'numeric' }).format(date);
  };

  const getLocalISOString = (dateString: string) => {
    const date = new Date(dateString);
    const offset = date.getTimezoneOffset() * 60000;
    return new Date(date.getTime() - offset).toISOString().slice(0, 16);
  };

  return {
    formatDate,
    formatDateShort,
    getLocalISOString,
  };
};
