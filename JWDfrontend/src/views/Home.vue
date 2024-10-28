<template>
  <div>
    <Header /> <!-- Render the Header component at the top of the page -->
    <genres @genreSelected="goToBooksView" /> <!-- Listen for the genreSelected event emitted from the genres component and call the goToBooksView method -->
  </div>
</template>

<script>
import Header from '../components/Header.vue'; // Import the Header component
import genres from '../components/genres.vue'; // Import the Genres component
export default {
  name: 'Home', //define the name of this component
  components: {
    Header, // Register the Header component for use in this template
    genres, // Register the genres component for use in this template
  },
  methods: {
  goToBooksView(genreId) {
    this.$router.push({ name: 'BooksView', params: { genreId } }); // Use the Vue Router to navigate to the BooksView route with the selected genreId as a parameter
  }
}
}
</script>
