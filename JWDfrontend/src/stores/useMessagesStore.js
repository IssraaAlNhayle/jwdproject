// src/stores/useMessagesStore.js
import { defineStore } from 'pinia';

export const useMessagesStore = defineStore('messages', {
  state: () => ({
    successMessage: '',
    errorMessage: '',
  }),
  actions: {
    setSuccessMessage(message) {
      this.successMessage = message;
    },
    setErrorMessage(message) {
      this.errorMessage = message;
    },
    clearMessages() {
      this.successMessage = '';
      this.errorMessage = '';
    }
  }
});
