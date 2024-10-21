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
            <button @click="handleButtonClick(book.id)" class="btn btn-primary">add to Reading</button>
            <!-- Heart icon for adding to favorites -->
            <button @click="addToFavorites(book.id)" class="btn btn-favorite">
              <i class="fas fa-heart"></i>
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
  <User v-if="showLoginForm" @close="closeLoginForm" @switchToRegister="showRegistrationForm = true; showLoginForm = false"/>
  <Registration v-if="showRegistrationForm" @close="showRegistrationForm= false"/>
</template>

<script>
import Registration from "@/components/Registration.vue";
import User from "@/components/User.vue";

export default {
  name: 'Books',
  data() {
    return {
      showLoginForm: false,
      showRegistrationForm: false,
    };
  },
  components: {User, Registration},
  props: {
    books: {
      type: Array,
      required: true
    }
  },
  methods: {
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
