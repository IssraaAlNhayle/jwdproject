<template>
  <header class="bg-light py-3 fixed-top">
    <div class="d-none d-md-flex justify-content-between align-items-center px-3">
      <div class="d-flex align-items-center">
        <h1 class="m-0">Bibliophilie</h1>
        <div class="ml-3">
          <button @click="handleButtonClick('Completed')" class="btn btn-outline-primary mx-2">Completed</button>
          <button @click="handleButtonClick('Reading')" class="btn btn-outline-primary mx-2">Reading</button>
          <button @click="handleButtonClick('Favorites')" class="btn btn-outline-primary mx-2">Favorites</button>
        </div>
      </div>
      <button class="btn btn-outline-primary mx-2" @click="openLoginForm">Login</button>
    </div>
    <div class="d-flex d-md-none justify-content-between align-items-center px-3">
      <h1 class="m-0">Bibliophilie</h1>
      <button class="btn btn-outline-primary mx-2">Menu</button>
    </div>
    <!-- Include the login modal -->
    <User v-if="showLoginForm" @close="closeLoginForm" @switchToRegister="showRegistrationForm = true; showLoginForm = false"/>
    <Registration v-if="showRegistrationForm" @close="showRegistrationForm= false"/>
  </header>
</template>

<script>
import User from "@/components/User.vue";
import Registration from "@/components/Registration.vue";
export default {
  name: 'Header',
  data() {
    return {
      showLoginForm: false,
      showRegistrationForm: false,
    };
  },
  components: {
    User,
    Registration,
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
    async handleButtonClick(buttonName) {
      const loggedIn = await this.validateSession(); // Validate session with the backend
      if (!loggedIn) {
        this.openLoginForm(); // Show login form if not logged in
      }else {
        if (buttonName === 'Reading') {

          this.$router.push('/reading-list'); // Redirect to the reading list

          console.log(`${buttonName} button clicked, and user is logged in`);
        }
else {

          if (buttonName === 'Completed') {
            this.$router.push('/completed-list');

            console.log(`${buttonName} button clicked, and user is logged in`);
          }
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
  },
};
</script>
