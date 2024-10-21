<template>
  <div class="container mt-3">
    <h1>Your Reading List</h1>
    <div v-if="loading">Loading...</div>
    <div v-if="error" class="alert alert-danger">{{ error }}</div>
    <div v-if="!loading && !error" class="row gx-3 gy-3">
      <div v-for="book in books" :key="book.id" class="col-6 col-md-4 col-lg-3 col-xl-3">
        <div class="card h-100">
          <img :src="book.image" class="card-img-top" :alt="book.title" />
          <div class="card-body">
            <h5 class="card-title">{{ book.title }}</h5>
            <p class="card-text">By {{ book.author }}</p>
            <a :href="book.bookpdf" class="btn btn-primary" target="_blank">Read PDF</a>
            <button class="btn btn-danger" @click="RemoveBookFromReading(book.id)">Remove from Reading</button>
            <button class="btn btn-success" @click="AddBookToCompleted(book.id)">mark as finished</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      books: [],
      loading: true,
      error: null
    };
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
      this.error = err.message;
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
            'Content-Type': 'application/json'
          },
          credentials: 'include',
          body: JSON.stringify({bookId})
        });
        if (!response.ok) {
          throw new Error('Failed to add book to completed list');
        }

        // Explicitly update the `books` array to trigger Vue's reactivity system
        this.books = this.books.filter(book => book.id !== bookId);
      } catch (err) {
        this.error = err.message;
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
        this.books = this.books.filter(book => book.id !== bookId);
      } catch (err) {
        this.error = err.message;
      }
    }
  }
};
</script>

<style scoped>
.card-img-top {
  height: 200px;
  object-fit: cover;
}
</style>

