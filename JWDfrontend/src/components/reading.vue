<template>
  <div class="container-fluid mt-3"> <!-- Updated to container-fluid for full width -->
    <h1>Your Reading List</h1>

    <!-- Loading and Error/Success Messages -->
    <div v-if="loading">Loading...</div>
    <div v-if="messages.errorMessage" class="alert alert-danger">{{ messages.errorMessage }}</div>
    <div v-if="messages.successMessage" class="alert alert-success">{{ messages.successMessage }}</div>

    <!-- Book Cards Grid -->
    <div v-if="!loading && !messages.errorMessage" class="row gx-3 gy-3">
      <div v-for="book in books" :key="book.id" class="col-12 col-sm-6 col-md-4 col-lg-3"> <!-- Adjusted for better responsiveness -->
        <div class="card h-100">
          <img :src="book.image" class="card-img-top" :alt="book.title" />
          <div class="card-body">
            <h5 class="card-title">{{ book.title }}</h5>
            <p class="card-text">By {{ book.author }}</p>
            <a :href="book.bookpdf" class="btn btn-primary" target="_blank">Read PDF</a>
            <button class="btn btn-danger" @click="RemoveBookFromReading(book.id)">Remove from Reading</button>
            <button class="btn btn-success" @click="AddBookToCompleted(book.id)">Mark as Finished</button>
            <!-- Heart icon for adding to favorites -->
            <button @click="AddBookToFavorites(book.id)" class="btn btn-favorite">
              <font-awesome-icon :icon="isFavorite(book.id) ? ['fas', 'heart'] : ['far', 'heart']" />
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<script>
import { useFavoritesStore } from '@/stores/useFavoritesStore';
import { useMessagesStore } from '@/stores/useMessagesStore'; // Adjust the path as necessary

export default {
  data() {
    return {
      books: [],
      loading: true,
      favorites: [],
    };
  },
  setup() {
    const messages = useMessagesStore();
    const favoritesStore = useFavoritesStore(); // Use the favorites store

    // Fetch the favorites when the component mounts
    favoritesStore.fetchFavorites();

    return { messages, favoritesStore };
  },
  async created() {
    try {
      const response = await fetch('http://localhost:3000/reading-list', {
        credentials: 'include', // Ensure session cookies are included
      });
      if (!response.ok) {
        throw new Error('Failed to fetch reading list');
      }
      const data = await response.json();
      this.books = data;
    } catch (err) {
      this.messages.setErrorMessage(err.message);
    } finally {
      this.loading = false;
    }
  },
  methods: {
    isFavorite(bookId) {
      return this.favoritesStore.isFavorite(bookId); // Use the store method
    },
    async AddBookToCompleted(bookId) {
      try {
        const response = await fetch(`http://localhost:3000/add-to-completed`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          credentials: 'include',
          body: JSON.stringify({ bookId }),
        });
        if (!response.ok) {
          throw new Error('Failed to add book to completed list');
        }

        this.books = this.books.filter((book) => book.id !== bookId);
        setTimeout(() => {
          this.messages.clearMessages();
        }, 5000);
      } catch (err) {
        this.messages.setErrorMessage(err.message);
      }
    },
    async AddBookToFavorites(bookId) {
      try {
        const response = await fetch(`http://localhost:3000/add-to-favorites`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          credentials: 'include',
          body: JSON.stringify({ bookId }),
        });

        const responseData = await response.json(); // Parse the response once

        if (!response.ok) {
          throw new Error(responseData.message || 'Failed to add book to favorites list');
        }

        // Update the favorites array reactively, and avoid duplicates
        if (!this.favorites.includes(bookId)) {
          this.favorites = [...this.favorites, bookId]; // Ensure reactivity
        }

        console.log("Current favorites:", [...this.favorites]);
        console.log("Is Favorite for book", bookId, this.isFavorite(bookId));
        await this.favoritesStore.addBookToFavorites(bookId); // Use the store action
        // Success message
        this.messages.setSuccessMessage(responseData.message || 'Book added to favorites successfully!');

        setTimeout(() => {
          this.messages.clearMessages();
        }, 5000);

      } catch (err) {
        this.messages.setErrorMessage(err.message);
      }
    },
    async RemoveBookFromReading(bookId) {
      try {
        const response = await fetch(`http://localhost:3000/reading-list/${bookId}`, {
          method: 'DELETE',
          credentials: 'include',
        });
        if (!response.ok) {
          throw new Error('Failed to remove book from reading list');
        }

        this.books = this.books.filter((book) => book.id !== bookId);
        setTimeout(() => {
          this.messages.clearMessages();
        }, 5000);
      } catch (err) {
        this.messages.setErrorMessage(err.message);
      }
    },
  },
};
</script>

<style scoped>
/* Style the favorite heart button */
.btn-favorite {
  background-color: transparent;
  border: none;
  color: red;
  font-size: 1.5rem;
  cursor: pointer;
}

.btn-favorite i {
  transition: transform 0.2s ease-in-out;
}

.btn-favorite:hover i {
  transform: scale(1.2);
}

.card-img-top {
  width: 100%;  /* Ensure the image takes up the full width of the card */
  height: 250px;  /* Fixed height */
  object-fit: cover;  /* Ensures the image fits within the dimensions */
}


/* Add spacing between grid items */
.gx-3 {
  gap: 1.5rem; /* Adjust gap between columns if needed */
}

.gy-3 {
  gap: 1.5rem; /* Adjust gap between rows if needed */
}
</style>
