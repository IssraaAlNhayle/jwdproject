<template>
  <div>
    <div class="header">
      <Header />
    </div>
      <Books v-if="books.length > 0" :books="books"/>
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
      books: [] // Initialize an empty array to hold the list of books for the selected genre
    };
  },
  props: ['genreId'], // Receive the genreId as a prop from the parent component
  mounted() {
    this.fetchBooks(); // Fetch the books when the component is mounted
  },
  methods: {
    async fetchBooks() {
      try {
        const response = await fetch(`http://localhost:3000/books/${this.genreId}`); // Send a GET request to the backend to fetch books
        const data = await response.json();
        this.books = data; // Store the fetched books in the 'books' data property
      } catch (error) {
        console.error('Error fetching books:', error);
      }
    },

  }
}
</script>

<style scoped>
.header {
  margin-bottom: 81px;/* Add margin below the header to prevent content overlap */
}
</style>

