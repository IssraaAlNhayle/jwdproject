<template>
  <div>
    <div class="header">
      <Header />
    </div>
    <Favorites />
  </div>
</template>

<script>
import Header from '../components/Header.vue';
import Favorites from '../components/Favorites.vue';

export default {
  name: 'CompletedView',
  components: {
    Header,
    Favorites,
  }
};
</script>

<style scoped>
.header {
  margin-bottom: 81px; /* Push content below the header */
}
</style>


