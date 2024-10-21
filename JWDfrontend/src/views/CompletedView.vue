<template>
  <div>
    <div class="header">
      <Header />
    </div>
    <Completed />
  </div>
</template>

<script>
import Header from '../components/Header.vue';
import Completed from '../components/Completed.vue';

export default {
  name: 'CompletedView',
  components: {
    Header,
    Completed,
  }
};
</script>

<style scoped>
.header {
  margin-bottom: 81px; /* Push content below the header */
}
</style>

