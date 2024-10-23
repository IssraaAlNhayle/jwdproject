<template>
  <div class="container-fluid mt-3">
    <div class="row gx-3 gy-3">
      <div
        v-for="book in books"
        :key="book.id"
        class="col-6 col-md-4 col-lg-3 col-xl-3"
      >
        <div class="card h-100">
          <img :src="book.image" class="card-img-top" :alt="book.title" />
          <div class="card-body">
            <h5 class="card-title">{{ book.title }}</h5>
            <p class="card-text">By {{ book.author }}</p>
            <a :href="book.bookpdf" class="btn btn-primary" target="_blank">Read PDF</a>
            <button @click="handleButtonClick(book.id)" class="btn btn-primary">Add to Reading</button>

            <!-- Heart icon for adding to favorites -->
            <button @click="AddBookToFavorites(book.id)" class="btn btn-favorite">
              <font-awesome-icon :icon="isFavorite(book.id) ? ['fas', 'heart'] : ['far', 'heart']" />
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Display Messages -->
    <div v-if="messages.errorMessage" class="alert alert-danger">{{ messages.errorMessage }}</div>
    <div v-if="messages.successMessage" class="alert alert-success">{{ messages.successMessage }}</div>

    <User v-if="showLoginForm" @close="closeLoginForm" @switchToRegister="showRegistrationForm = true; showLoginForm = false"/>
    <Registration v-if="showRegistrationForm" @close="showRegistrationForm= false"/>
  </div>
</template>


<script>
import { useMessagesStore } from '@/stores/useMessagesStore'; // Import the Pinia store
import Registration from "@/components/Registration.vue";
import User from "@/components/User.vue";
import { useFavoritesStore } from '@/stores/useFavoritesStore';

export default {
  name: 'Books',
  data() {
    return {
      showLoginForm: false,
      showRegistrationForm: false,
      userLoggedIn: false, // Track the login state
      favorites: [], // Track favorite books
    };
  },
  components: { User, Registration },
  props: {
    books: {
      type: Array,
      required: true
    }
  },
  setup() {
    const messages = useMessagesStore();
    const favoritesStore = useFavoritesStore(); // Use the favorites store

    // Fetch the favorites when the component mounts
    favoritesStore.fetchFavorites();

    return { messages, favoritesStore };
  },
  methods: {
    // Method to check if a book is in favorites
    isFavorite(bookId) {
      return this.favoritesStore.isFavorite(bookId); // Use the store method
    },

    // API-based session check to verify if the session is still valid
    async validateSession() {
      try {
        const response = await fetch('http://localhost:3000/session-check', {
          credentials: 'include', // Ensure cookies are sent with the request
        });
        const result = await response.json();
        return result.loggedIn; // Expecting a { loggedIn: true/false } response from the server
      } catch (err) {
        console.error('Session validation failed:', err);
        return false;
      }
    },

    // Method to add a book to favorites
    async AddBookToFavorites(bookId) {
      const loggedIn = await this.validateSession(); // Validate session with the backend
      if (!loggedIn) {
        this.openLoginForm(); // Show login form if not logged in
      } else {
        try {
          const response = await fetch(`http://localhost:3000/add-to-favorites`, {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            credentials: 'include',
            body: JSON.stringify({ bookId }) // Properly passing bookId
          });

          const data = await response.json(); // Parse response data

          if (response.ok) {
            // Update the favorites array reactively, and avoid duplicates
            if (!this.favorites.includes(bookId)) {
              this.favorites = [...this.favorites, bookId]; // Ensure reactivity
            }

            console.log("Current favorites:", [...this.favorites]);
            console.log("Is Favorite for book", bookId, this.isFavorite(bookId));
            this.messages.setSuccessMessage(data.message || 'Book added to favorites successfully!');
          } else {
            await this.favoritesStore.addBookToFavorites(bookId); // Use the store action
            // Handle the case where the book is already in favorites
            this.messages.setErrorMessage(data.message || 'Failed to add book to favorites list');
          }

          // Clear messages after 5 seconds
          setTimeout(() => {
            this.messages.clearMessages();
          }, 5000);
        } catch (err) {
          this.messages.setErrorMessage(err.message);
        }
      }
    },

    async handleButtonClick(bookId) {
      const loggedIn = await this.validateSession(); // Validate session with the backend
      if (!loggedIn) {
        this.openLoginForm(); // Show login form if not logged in
      } else {
        // Proceed with adding the book to the user's reading list
        try {
          const response = await fetch('http://localhost:3000/add-to-reading', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            credentials: 'include', // Ensure cookies are sent with the request
            body: JSON.stringify({ bookId }) // Send the book ID to the backend
          });

          const result = await response.json();
          if (response.ok) {
            console.log('Book added to reading list:', result.message);
          } else {
            console.error('Error adding book to reading list:', result.message);
          }
        } catch (err) {
          console.error('Request failed:', err);
        }
      }
    },

    openLoginForm() {
      this.showLoginForm = true;
    },
    closeLoginForm() {
      this.showLoginForm = false;
    },
  },

  async mounted() {
    // Optionally check the session when the component mounts
    this.userLoggedIn = await this.validateSession();

    // Fetch the favorites list when the component mounts
    try {
      const response = await fetch('http://localhost:3000/favorites-list', {
        credentials: 'include',
      });
      const favoriteBooks = await response.json();
      this.favorites = favoriteBooks.map(book => book.id); // Extract favorite book IDs
      console.log("Fetched favorites: ", this.favorites);
    } catch (err) {
      console.error('Error fetching favorite books:', err);
    }
  }
}
</script>

<style scoped>
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
  height: 200px;
  object-fit: cover;
}
</style>
