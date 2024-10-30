<template>
  <div class="container-fluid mt-3">
    <!-- Display Messages at the Top -->
    <div v-if="messages.errorMessage" class="alert alert-danger">{{ messages.errorMessage }}</div>
    <div v-if="messages.successMessage" class="alert alert-success">{{ messages.successMessage }}</div>

    <!-- Book List -->
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
            <button
              @click="handleButtonClick(book.id)"
              class="btn btn-primary"
              :class="{ 'btn-success': state.readingStatus[book.id], 'btn-loading': state.loadingBookId === book.id }"
              :disabled="state.loadingBookId === book.id"
            >
              <span v-if="state.loadingBookId === book.id">Adding...</span>
              <span v-else>Add to Reading</span>
            </button>

            <!-- Heart icon for adding to favorites -->
            <button @click="AddBookToFavorites(book.id)" class="btn btn-favorite">
              <font-awesome-icon :icon="isFavorite(book.id) ? ['fas', 'heart'] : ['far', 'heart']" />
            </button>
          </div>
        </div>
      </div>
    </div>

    <User v-if="state.showLoginForm" @close="closeLoginForm" @switchToRegister="state.showRegistrationForm = true; state.showLoginForm = false"/>
    <Registration v-if="state.showRegistrationForm" @close="state.showRegistrationForm = false"/>
  </div>
</template>


<script>
import { reactive } from 'vue';
import { useMessagesStore } from '@/stores/useMessagesStore';
import Registration from "@/components/Registration.vue";
import User from "@/components/User.vue";
import { useFavoritesStore } from '@/stores/useFavoritesStore';

export default {
  name: 'Books',
  props: {
    books: {
      type: Array,
      required: true
    }
  },
  setup() {
    const messages = useMessagesStore();
    const favoritesStore = useFavoritesStore();

    // Initialize reactive state
    const state = reactive({
      showLoginForm: false,
      showRegistrationForm: false,
      userLoggedIn: false,
      loadingBookId: null, // Track which book is being added to the reading list
      readingStatus: {} // Track reading status for each book
    });

    // Function to validate session
    async function validateSession() {
      try {
        const response = await fetch('http://localhost:3000/session-check', {
          credentials: 'include',
        });
        const result = await response.json();
        return result.loggedIn;
      } catch (err) {
        console.error('Session validation failed:', err);
        return false;
      }
    }
    async function handleButtonClick(bookId) {
      const loggedIn = await validateSession();
      if (!loggedIn) {
        state.showLoginForm = true;
        return;
      }

      if (state.readingStatus[bookId]) {
        messages.setErrorMessage("This book is already in your reading list.");
        clearMessageAfterDelay(bookId);
        return;
      }

      state.loadingBookId = bookId;
      try {
        const response = await fetch('http://localhost:3000/add-to-reading', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          credentials: 'include',
          body: JSON.stringify({ bookId })
        });
        const result = await response.json();

        if (response.ok) {
          state.readingStatus[bookId] = true;
          clearMessageAfterDelay(bookId);
        } else if (response.status === 400 && result.message === "Book is already in the reading list") {
          messages.setErrorMessage(result.message);
          clearMessageAfterDelay(bookId);
        } else {
          messages.setErrorMessage("Error adding book to reading list.");
          clearMessageAfterDelay(bookId);
        }
      } catch (err) {
        console.error("Request failed:", err);
        messages.setErrorMessage("Error adding book to reading list.");
        clearMessageAfterDelay(bookId);
      } finally {
        state.loadingBookId = null;
      }
    }

    // Method to check if a book is in favorites
    function isFavorite(bookId) {
      return favoritesStore.isFavorite(bookId);
    }
   // Helper function to clear messages and reset reading status after a delay
    function clearMessageAfterDelay(bookId) {
      setTimeout(() => {
        messages.clearMessages();
        if (bookId) {
          state.readingStatus[bookId] = false; // Reset the reading status after delay
        }
      }, 2000); // Adjust the delay as needed
    }

    // Method to add or remove a book from favorites (toggle)
    async function AddBookToFavorites(bookId) {
      const loggedIn = await validateSession();
      if (!loggedIn) {
        state.showLoginForm = true;
      } else {
        try {
          await favoritesStore.toggleFavorite(bookId);

          setTimeout(() => {
            messages.clearMessages();
          }, 5000);
        } catch (err) {
          messages.setErrorMessage('Error handling favorite operation');
          console.error(err);
        }
      }
    }
    // Function to close login form
    function closeLoginForm() {
      state.showLoginForm = false;
    }

    return {
      state,
      messages,
      handleButtonClick,
      AddBookToFavorites,
      isFavorite,
      closeLoginForm
    };
  },
  components: { User, Registration }
};
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

.btn-success {
  background-color: green;
  color: white;
}

.btn-loading {
  background-color: orange;
  color: white;
}
</style>
