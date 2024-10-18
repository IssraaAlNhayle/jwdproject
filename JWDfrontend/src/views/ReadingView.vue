<template>
  <div>
    <div class="header">
      <Header />
    </div>
    <reading />
  </div>
</template>

<script>
import Header from '../components/Header.vue';
import reading from '../components/reading.vue';

export default {
  name: 'ReadingView',
  components: {
    Header,
    reading,
  }
};
</script>

<style scoped>
.header {
  margin-bottom: 81px; /* Push content below the header */
}
</style>

