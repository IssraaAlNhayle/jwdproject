<template>
  <header class="bg-darker py-3 fixed-top">
    <div v-if="logoutMessage" :style="{ color: '#881a24', backgroundColor: '#f8d7da', padding: '10px', borderRadius: '5px', textAlign: 'center' }">
      {{ logoutMessage }}
    </div>
    <!-- Desktop view -->
    <div class="d-none d-md-flex justify-content-between align-items-center px-3">
      <div class="d-flex align-items-center">
        <h1 class="header-title">Bibliophilie</h1>
        <div class="ml-3">
          <button @click="handleButtonClick('Completed')" class="btn mx-2 text-button nav-item">Completed</button>
          <button @click="handleButtonClick('Reading')" class="btn mx-2 text-button nav-item">Reading</button>
          <button @click="handleButtonClick('Favorites')" class="btn mx-2 text-button nav-item">Favorites</button>
        </div>
      </div>
      <div class="user-controls">
        <span v-if="userLoggedIn" class="greeting-message mr-3">Welcome, {{ username }}!</span>
        <button v-if="userLoggedIn" class="btn btn-logout mx-2" @click="logout">Logout</button>
        <button v-else class="btn btn-outline-primary mx-2" @click="openLoginForm">
          <i class="fas fa-user-circle"></i>
        </button>
      </div>
    </div>

    <!-- Mobile view -->
    <div class="d-flex d-md-none justify-content-between align-items-center px-3">
      <h1 class="header-title">Bibliophilie</h1>
      <div class="menu-wrapper">
        <button class="btn btn-outline-primary mx-2 text-button">Menu</button>
        <div class="menu-items">
          <button v-if="!userLoggedIn" @click="openLoginForm" class="btn btn-outline-primary d-block my-2">Login</button>
          <button @click="handleButtonClick('Reading')" class="btn btn-outline-primary d-block my-2">Reading</button>
          <button @click="handleButtonClick('Favorites')" class="btn btn-outline-primary d-block my-2">Favorites</button>
          <button @click="handleButtonClick('Completed')" class="btn btn-outline-primary d-block my-2">Completed</button>
          <button v-if="userLoggedIn" class="btn btn-outline-danger d-block my-2" @click="logout">Logout</button>
        </div>
      </div>
    </div>

    <User v-if="showLoginForm" @close="closeLoginForm" @loggedIn="validateSession" @switchToRegister="showRegistrationForm = true; showLoginForm = false"/>
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
      userLoggedIn: false,
      username: '',
      logoutMessage: '',
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
        this.userLoggedIn = result.loggedIn;
        this.username = result.username || '';
        return this.userLoggedIn;
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
        const routes = {
          'Reading': '/reading-list',
          'Completed': '/completed-list',
          'Favorites': '/favorites-list'
        };
        this.$router.push(routes[buttonName]);
      }
    },
    openLoginForm() {
      this.showLoginForm = true;
    },
    closeLoginForm() {
      this.showLoginForm = false;
    },
    async logout() {
      try {
        const response = await fetch('http://localhost:3000/logout', {
          method: 'POST',
          credentials: 'include',
        });
        if (response.ok) {
          this.userLoggedIn = false;
          this.username = '';
          this.logoutMessage = 'You have successfully logged out.'; // Set the message
          this.$router.push('/'); // Redirect to homepage

          // Clear the message after 3 seconds
          setTimeout(() => {
            this.logoutMessage = '';
          }, 3000);
        } else {
          console.error('Logout failed');
        }
      } catch (err) {
        console.error('Logout failed:', err);
      }
    }
  },
  async mounted() {
    await this.validateSession();
  },
};
</script>

<style scoped>
/* Header title styling */
.header-title {
  font-size: 1.8rem;
  font-weight: bold;
  color: #333;
}

/* Menu wrapper for positioning the dropdown */
.menu-wrapper {
  position: relative;
}

/* Dropdown menu styling */
.menu-items {
  display: none;
  position: absolute;
  top: 100%;
  left: 0;
  background-color: #ffffff;
  border-radius: 8px;
  min-width: 180px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  padding: 10px 0;
  z-index: 1000; /* Ensure the menu appears above other elements */
}

/* Show menu on hover */
.menu-wrapper:hover .menu-items {
  display: block;
}

/* Dropdown menu button styling */
.menu-items button {
  width: 100%;
  padding: 10px 20px;
  font-size: 1rem;
  text-align: left;
  background-color: transparent;
  border: none;
  color: #333;
  transition: background-color 0.2s;
}

/* Hover effect for dropdown buttons */
.menu-items button:hover {
  background-color: #f4f4f4;
  border-radius: 4px;
}

/* Spacing utility */
.ml-3 {
  margin-left: 30px;
}

/* Text button styling */
.text-button {
  color: #131212;
  font-size: 1.2rem;
  font-weight: 550;
  padding: 0;
  cursor: pointer;
  transition: color 0.3s, background-color 0.3s;
}

.text-button:hover {
  color: #0707c8;
  background-color: rgba(15, 55, 188, 0.1);
  border-radius: 5px;
  padding: 5px 10px;
}

/* Outline button styling */
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

/* Greeting message styling */
.greeting-message {
  font-size: 1rem;
  font-weight: bold;
  color: #333;
  margin-right: 10px;
  text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
}

/* Logout button styling */
.btn-logout {
  padding: 6px 10px;
  background-color: #ff4757;
  color: white;
  border: none;
  border-radius: 5px;
  transition: background-color 0.3s, transform 0.2s;
}

.btn-logout:hover {
  background-color: #e84118;
  transform: scale(1.05);
}

/* Larger screen styles for 992px and above */
@media (min-width: 996px) {
  .header-title {
    font-size: 2.5rem;
  }
  .text-button {
    font-size: 1.6rem;
    padding: 6px 12px;
  }
  .greeting-message {
    font-size: 1.4rem;
  }
  .btn-logout {
    padding: 10px 16px;
    font-size: 1.2rem;
  }
}
</style>
