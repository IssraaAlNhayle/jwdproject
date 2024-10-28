<template>
  <div class="container-fluid mt-3 content-wrapper"> <!-- Main container for the component, using Bootstrap classes for layout -->
    <div class="row gx-3 gy-3"> <!-- Organizes genre cards into rows with gutters -->
      <div
        v-for="genre in genres"
      :key="genre.id"
      class="col-6 col-md-4 col-lg-3 col-xl-3"
      > <!-- Loop through each genre in the genres array -->
      <div class="card h-100" @click="selectGenre(genre.id)"> <!-- Card that triggers selectGenre on click -->
        <img :src="genre.image" class="card-img-top" :alt="genre.title" /> <!-- Display the genre image with dynamic src and alt attributes -->
        <div class="card-body text-center"> <!-- Card body for content -->
          <h5 class="card-title">{{ genre.title }}</h5> <!-- Display the genre title -->
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
      genres: [] // Initially an empty array for storing genres fetched from the API
    };
  },
  mounted() {
    this.fetchGenres(); // Fetch genres from the API when the component is mounted
  },
  methods: {
    async fetchGenres() { // Asynchronous method to fetch genre data
      try {
        const response = await fetch('http://localhost:3000/genres'); // Send a GET request to the API
        const data = await response.json(); // Parse the response data as JSON
        this.genres = data; // Assign the fetched data to the genres array
      } catch (error) {
        console.error('Error fetching genres:', error); // Log any errors encountered during the fetch
      }
    },
    selectGenre(genreId) {
      this.$emit('genreSelected', genreId); // Emit an event to notify the parent component of the selected genre
    }
  }
};
</script>

<style scoped>
.content-wrapper {
  padding-top: 5rem; /* Add padding at the top of the content wrapper */
}
.card {
  transition: transform 0.3s ease, box-shadow 0.3s ease; /* Smooth transition effects for card elements */
}
.card:hover {
  transform: scale(1.05); /* Slightly enlarge the card on hover */
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); /* Add a shadow effect */
}

.card-img-top {
  height: 220px; /* Set a fixed height for the card image */
  object-fit: cover; /* Ensure the image covers the area without distortion */
  transition: transform 0.3s ease; /* Add transition for smooth image effect */
}
.card-body {
  transition: background-color 0.3s ease, color 0.3s ease; /* Smooth transition for text and background color changes */
}
</style>
