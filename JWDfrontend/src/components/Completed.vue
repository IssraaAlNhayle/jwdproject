<template>
  <div class="container mt-3">
    <h1>Your Completed List</h1>
    <div v-if="loading">Loading...</div>
    <div v-if="error" class="alert alert-danger">{{ error }}</div>
    <div v-if="!loading && !error" class="row gx-3 gy-3">
      <div v-for="book in books" :key="book.id" class="col-6 col-md-4 col-lg-3 col-xl-3">
        <div class="card h-100">
          <img :src="book.image" class="card-img-top" :alt="book.title" />
          <div class="card-body">
            <h5 class="card-title">{{ book.title }}</h5>
            <p class="card-text">By {{ book.author }}</p>
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
      const response = await fetch('http://localhost:3000/completed-list', {
        credentials: 'include', // Make sure session cookies are included
      });
      if (!response.ok) {
        throw new Error('Failed to fetch completed list');
      }
      const data = await response.json();
      this.books = data;
    } catch (err) {
      this.error = err.message;
    } finally {
      this.loading = false;
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


