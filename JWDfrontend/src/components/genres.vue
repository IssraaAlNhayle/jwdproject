<template>
  <div class="container-fluid mt-3 content-wrapper">
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
.content-wrapper {
  padding-top: 5rem; /* Add padding as desired, e.g., 2rem or more */
}
.card {
  transition: transform 0.3s ease, box-shadow 0.3s ease; /* Smooth transition */
}

.card:hover {
  transform: scale(1.05); /* Slightly enlarge the card on hover */
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); /* Add a shadow effect */
}

.card-img-top {
  height: 200px;
  object-fit: cover;
  transition: transform 0.3s ease; /* Add transition for smooth image effect */
}

.card-body {
  transition: background-color 0.3s ease, color 0.3s ease; /* Transition for text and background */
}
</style>
