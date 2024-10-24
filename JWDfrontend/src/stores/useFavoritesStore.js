import { defineStore } from 'pinia';

export const useFavoritesStore = defineStore('favorites', {
  state: () => ({
    favoriteBooks: [], // Array to hold favorite book IDs
  }),
  actions: {
    async fetchFavorites() {
      try {
        const response = await fetch('http://localhost:3000/favorites-list', {
          credentials: 'include',
        });
        const data = await response.json();
        this.favoriteBooks = data.map(book => book.id); // Store the favorite book IDs
      } catch (error) {
        console.error('Error fetching favorites:', error);
      }
    },

    async toggleFavorite(bookId) {
      if (this.isFavorite(bookId)) {
        await this.removeBookFromFavorites(bookId); // Remove if it’s already a favorite
      } else {
        await this.addBookToFavorites(bookId); // Add if it’s not a favorite
      }
    },

    async addBookToFavorites(bookId) {
      try {
        const response = await fetch('http://localhost:3000/add-to-favorites', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          credentials: 'include',
          body: JSON.stringify({ bookId }),
        });
        const data = await response.json();
        if (response.ok) {
          if (!this.favoriteBooks.includes(bookId)) {
            this.favoriteBooks.push(bookId); // Add the book to the favorites list
          }
        } else {
          console.error(data.message);
        }
      } catch (error) {
        console.error('Error adding book to favorites:', error);
      }
    },

    async removeBookFromFavorites(bookId) {
      try {
        const response = await fetch(`http://localhost:3000/remove-from-favorites/${bookId}`, {
          method: 'DELETE',
          credentials: 'include',
        });
        const data = await response.json();
        if (response.ok) {
          this.favoriteBooks = this.favoriteBooks.filter(id => id !== bookId); // Remove the book from favorites
        } else {
          console.error(data.message);
        }
      } catch (error) {
        console.error('Error removing book from favorites:', error);
      }
    },

    isFavorite(bookId) {
      return this.favoriteBooks.includes(bookId);
    },
  },
});
