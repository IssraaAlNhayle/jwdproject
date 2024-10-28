<template>
  <header class="bg-darker py-3 fixed-top"> <!-- Header container with background color and fixed positioning -->
    <!-- Desktop view -->
    <div class="d-none d-md-flex justify-content-between align-items-center px-3">
      <div class="d-flex align-items-center">
        <h1>Bibliophilie</h1>
        <div class="ml-3">
          <button @click="handleButtonClick('Completed')" class="btn mx-2 text-button nav-item">Completed</button> <!-- Button for finished books -->
          <button @click="handleButtonClick('Reading')" class="btn mx-2 text-button nav-item">Reading</button> <!-- Button for currently reading books -->
          <button @click="handleButtonClick('Favorites')" class="btn mx-2 text-button nav-item">Favorites</button> <!-- Button for favorites books -->
        </div>
      </div>
      <button class="btn btn-outline-primary mx-2" @click="openLoginForm"> <!-- Button for opening the login form -->
        <i class="fas fa-user-circle"></i> <!-- Font Awesome user icon -->
      </button>
    </div>

    <!-- Mobile view -->
    <div class="d-flex d-md-none justify-content-between align-items-center px-3">
      <h1>Bibliophilie</h1>
      <div class="menu-wrapper">
        <!-- Menu button -->
        <button class="btn btn-outline-primary mx-2 text-button">Menu</button>
        <!-- Menu items that appear on hover -->
        <div class="menu-items">
          <button @click="openLoginForm" class="btn btn-outline-primary d-block my-2">Login</button>
          <button @click="handleButtonClick('Reading')" class="btn btn-outline-primary d-block my-2">Reading</button>
          <button @click="handleButtonClick('Favorites')" class="btn btn-outline-primary d-block my-2">Favorites</button>
          <button @click="handleButtonClick('Completed')" class="btn btn-outline-primary d-block my-2">Completed</button>
        </div>
      </div>
    </div>

    <User v-if="showLoginForm" @close="closeLoginForm" @switchToRegister="showRegistrationForm = true; showLoginForm = false"/>   <!-- Including the login modal -->
    <Registration v-if="showRegistrationForm" @close="showRegistrationForm = false"/> <!-- Registration modal -->
  </header>
</template>

<script>
import User from "@/components/User.vue"; // Import the User component for login functionality
import Registration from "@/components/Registration.vue"; //Import the Registration component for user registration


export default {
  name: 'Header', // Name of the component
  data() {
    return {
      showLoginForm: false, // Control the visibility of the login form
      showRegistrationForm: false, // Control the visibility of the registration form
    };
  },
  components: {
    User,
    Registration,
  },
  methods: {
    async validateSession() { // Method to check if the user is logged in
      try {
        const response = await fetch('http://localhost:3000/session-check', { // Fetch the session status from the server
          credentials: 'include', //Include credentials in the request
        });
        const result = await response.json(); // Parse the response as JSON
        return result.loggedIn; // Return the logged-in status from the server response
      } catch (err) {
        console.error('Session validation failed:', err);
        return false;
      }
    },
    async handleButtonClick(buttonName) {
      const loggedIn = await this.validateSession();
      if (!loggedIn) { // If the user is not logged in
        this.openLoginForm(); //opens the login form
      } else { // If the user is logged in
        if (buttonName === 'Reading') {
          this.$router.push('/reading-list');
        } else if (buttonName === 'Completed') {
          this.$router.push('/completed-list');
        } else {
          this.$router.push('/favorites-list');
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
};
</script>

<style scoped>
.menu-wrapper {
  position: relative;
}

.menu-items {
  display: none; /* Initially hide the menu items */
  position: absolute; /* Position menu items absolutely */
  left: -40px; /* Align the menu items just below the menu button */
  background-color: #dddbdb;
  border-radius: 6px;  /* Rounded corners */
  min-width: 140px; /* Minimum width for the dropdown */
}

.menu-wrapper:hover .menu-items {
  display: block; /* Show menu items on hover */
}

.menu-items button {
  width: 100%; /* Make buttons in the menu full width */
}

.ml-3 {
  margin-left: 50px; /* Add left margin */
}

.text-button {
  color: #131212;
  font-size: 26px;
  font-weight: 550;
  cursor: pointer; /* Pointer cursor on hover */
  padding: 0;
  transition: color 0.3s, background-color 0.3s; /* Smooth transition for color and background */
}

.text-button:hover {
  color: #0707c8; /* Change text color on hover */
  background-color: rgba(15, 55, 188, 0.1);
  border-radius: 5px;
  padding: 5px 10px;
}

.btn-outline-primary {
  border: none; /* Change border color to white */
  background: none; /* Ensure the background remains transparent */
  padding: 5px; /* Optional: adjust padding to create space */
  border-radius: 10px; /* Rounded corners, adjust as needed */
}
.btn-outline-primary i {
  border: none;
  background: none; /* Remove any background color */
  font-size: 43px;  /* Make the icon larger */
  color: #020507;   /* Primary blue color */
}

.btn-outline-primary:hover i {
  color: #0c0cc1;  /* Darker blue on hover */
}
.bg-darker {
  background-color: #f4f6f4; /* Medium gray, between light and dark */
}
</style>
