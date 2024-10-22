<template>
  <div class="container mt-3">
    <h1>Your Reading List</h1>
    <div v-if="loading">Loading...</div>
    <div v-if="messages.errorMessage" class="alert alert-danger">{{ messages.errorMessage }}</div>
    <div v-if="messages.successMessage" class="alert alert-success">{{ messages.successMessage }}</div>
    <div v-if="!loading && !messages.errorMessage" class="row gx-3 gy-3">
      <div v-for="book in books" :key="book.id" class="col-6 col-md-4 col-lg-3 col-xl-3">
        <div class="card h-100">
          <img :src="book.image" class="card-img-top" :alt="book.title" />
          <div class="card-body">
            <h5 class="card-title">{{ book.title }}</h5>
            <p class="card-text">By {{ book.author }}</p>
            <a :href="book.bookpdf" class="btn btn-primary" target="_blank">Read PDF</a>
            <button class="btn btn-danger" @click="RemoveBookFromReading(book.id)">Remove from Reading</button>
            <button class="btn btn-success" @click="AddBookToCompleted(book.id)">Mark as Finished</button>
            <button @click="AddBookToFavorites(book.id)" class="btn btn-favorite"><i class="fas fa-heart"></i></button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { useMessagesStore } from '@/stores/useMessagesStore'; // Adjust the path as necessary

export default {
  data() {
    return {
      books: [],
      loading: true,
    };
  },
  setup() {
    const messages = useMessagesStore();
    return { messages };
  },
  async created() {
    try {
      const response = await fetch('http://localhost:3000/reading-list', {
        credentials: 'include', // Make sure session cookies are included
      });
      if (!response.ok) {
        throw new Error('Failed to fetch reading list');
      }
      const data = await response.json();
      this.books = data;
    } catch (err) {
      this.messages.setErrorMessage(err.message);
    } finally {
      this.loading = false;
    }
  },
  methods: {
    async AddBookToCompleted(bookId) {
      try {
        const response = await fetch(`http://localhost:3000/add-to-completed`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          credentials: 'include',
          body: JSON.stringify({ bookId }),
        });
        if (!response.ok) {
          throw new Error('Failed to add book to completed list');
        }

        // Explicitly update the `books` array to trigger Vue's reactivity system
        this.books = this.books.filter((book) => book.id !== bookId);
        this.messages.setSuccessMessage('Book marked as finished successfully!');

        // Clear success message after 5 seconds
        setTimeout(() => {
          this.messages.clearMessages();
        }, 5000);
      } catch (err) {
        this.messages.setErrorMessage(err.message);
      }
    },
    async AddBookToFavorites(bookId) {
      try {
        const response = await fetch(`http://localhost:3000/add-to-favorites`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          credentials: 'include',
          body: JSON.stringify({ bookId }),
        });

        if (!response.ok) {
          const errorData = await response.json(); // Get error details from the response
          throw new Error(errorData.message || 'Failed to add book to favorites list');
        }

        // Book successfully added to favorites
        const successData = await response.json(); // Get success data if needed
        this.messages.setSuccessMessage(successData.message || 'Book added to favorites successfully!');
        // Clear success message after 5 seconds
        setTimeout(() => {
          this.messages.clearMessages();
        }, 5000);
      } catch (err) {
        this.messages.setErrorMessage(err.message);
      }
    },
    async RemoveBookFromReading(bookId) {
      try {
        const response = await fetch(`http://localhost:3000/reading-list/${bookId}`, {
          method: 'DELETE',
          credentials: 'include',
        });
        if (!response.ok) {
          throw new Error('Failed to remove book from reading list');
        }

        // Explicitly update the `books` array to trigger Vue's reactivity system
        this.books = this.books.filter((book) => book.id !== bookId);
        this.messages.setSuccessMessage('Book removed from reading list successfully!');

        // Clear success message after 5 seconds
        setTimeout(() => {
          this.messages.clearMessages();
        }, 5000);
      } catch (err) {
        this.messages.setErrorMessage(err.message);
      }
    },
  },
};
</script>

<style scoped>
.btn-favorite {
  background-color: transparent;
  border: none;
  color: red;
  font-size: 1.5rem;
  cursor: pointer;
}

.btn-favorite i {
  transition: transform 0.2s ease-in-out;
}

.btn-favorite:hover i {
  transform: scale(1.2);
}

.card-img-top {
  height: 200px;
  object-fit: cover;
}
</style>
