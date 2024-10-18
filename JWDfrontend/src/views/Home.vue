<template>
  <div>
    <Header />
    <genres @genreSelected="goToBooksView" />
  </div>
</template>

<script>
import Header from '../components/Header.vue';
import genres from '../components/genres.vue';
export default {
  name: 'Home',
  components: {
    Header,
    genres,
  },
  methods: {
  goToBooksView(genreId) {
    this.$router.push({ name: 'BooksView', params: { genreId } });
  }
}
}
</script>

<style scoped>

</style>
