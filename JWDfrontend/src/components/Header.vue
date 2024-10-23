<template>
  <header class="bg-darker py-3 fixed-top">
    <!-- Desktop view -->
    <div class="d-none d-md-flex justify-content-between align-items-center px-3">
      <div class="d-flex align-items-center">
        <h1 class="m-0">Bibliophilie</h1>
        <div class="ml-3">
          <button @click="handleButtonClick('Completed')" class="btn mx-2 text-button nav-item">Completed</button>
          <button @click="handleButtonClick('Reading')" class="btn mx-2 text-button nav-item">Reading</button>
          <button @click="handleButtonClick('Favorites')" class="btn mx-2 text-button nav-item">Favorites</button>
        </div>
      </div>
      <!-- User Icon for Login -->
      <button class="btn btn-outline-primary mx-2" @click="openLoginForm">
        <i class="fas fa-user-circle"></i>
      </button>
    </div>

    <!-- Mobile view (with hover menu) -->
    <div class="d-flex d-md-none justify-content-between align-items-center px-3">
      <h1 class="m-0">Bibliophilie</h1>
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

    <!-- Include the login modal -->
    <User v-if="showLoginForm" @close="closeLoginForm" @switchToRegister="showRegistrationForm = true; showLoginForm = false"/>
    <Registration v-if="showRegistrationForm" @close="showRegistrationForm = false"/>
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
    async validateSession() {
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
    },
    async handleButtonClick(buttonName) {
      const loggedIn = await this.validateSession();
      if (!loggedIn) {
        this.openLoginForm();
      } else {
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
.bg-darker {
  background-color: #b0b0b0; /* Medium gray */
}

.menu-wrapper {
  position: relative;
}

.menu-items {
  display: none;
  position: absolute;
  top: 100%;
  left: -40px;
  background-color: white;
  z-index: 1;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  padding: 10px;
  border-radius: 4px;
  min-width: 150px;
}

.menu-wrapper:hover .menu-items {
  display: block;
}

.menu-items button {
  width: 100%;
}

.ml-3 {
  margin-left: 50px;
}

.text-button {
  background: none;
  border: none;
  color: black;
  font-size: 22px;
  font-weight: 500;
  cursor: pointer;
  padding: 0;
  margin: 0;
  transition: color 0.3s, background-color 0.3s;
}

.text-button:hover {
  color: blue;
}

.nav-item {
  margin-right: 30px;
}

.text-button:hover {
  background-color: rgba(0, 0, 255, 0.1);
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
  color: blue;  /* Darker blue on hover */
}
.bg-darker {
  background-color: #f4f6f4; /* Medium gray, between light and dark */
}
</style>
