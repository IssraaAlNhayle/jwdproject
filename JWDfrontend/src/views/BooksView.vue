<template>
  <div>
    <div class="header">
      <Header />
    </div>
      <Books v-if="books.length > 0" :books="books" />
  </div>
</template>

<script>
import Header from '../components/Header.vue';
import Books from '../components/Books.vue';

export default {
  name: 'BooksView',
  components: {
    Header,
    Books,
  },
  data() {
    return {
      books: []
    };
  },
  props: ['genreId'], // Receive the genreId as a prop from the router
  mounted() {
    this.fetchBooks();
  },
  methods: {
    async fetchBooks() {
      try {
        const response = await fetch(`http://localhost:3000/books/${this.genreId}`);
        const data = await response.json();
        this.books = data; // Store the books for the selected genre
      } catch (error) {
        console.error('Error fetching books:', error);
      }
    },
    goBack() {
      this.$router.push('/');
    }
  }
}
</script>

<style scoped>
.header {
  margin-bottom: 81px; /* Push content below the header */
}
</style>

