<template>
  <div class="container-fluid mt-3">
    <div class="row gx-3 gy-3">
      <div
        v-for="genre in genres"
        :key="genre.id"
        class="col-6 col-md-4 col-lg-3 col-xl-3"
      >
        <div class="card h-100" @click="selectGenre(genre.id)">
          <img :src="genre.image" class="card-img-top" :alt="genre.title" />
          <div class="card-body text-center">
            <h5 class="card-title">{{ genre.title }}</h5>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Genres',
  data() {
    return {
      genres: [] // Initially an empty array for genres
    };
  },
  mounted() {
    this.fetchGenres();
  },
  methods: {
    async fetchGenres() {
      try {
        const response = await fetch('http://localhost:3000/genres');
        const data = await response.json();
        this.genres = data;
      } catch (error) {
        console.error('Error fetching genres:', error);
      }
    },
    selectGenre(genreId) {
      this.$emit('genreSelected', genreId);
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
