<template>
  <div class="login-modal"> <!-- Container for the login modal -->
    <div class="login-form"> <!-- Main form container for login -->
      <button class="close-btn" @click="$emit('close')">×</button> <!--emitting an event to the header.vue component -->
      <h3 class="form-title">Login</h3>
      <form @submit.prevent="loginUser"> <!-- -->
        <div class="form-group"> <!-- Group container for username input -->
          <label for="username">Username</label>
          <input type="text" id="username" v-model="username" class="form-control" required /> <!-- Input for username, bound to data property -->
        </div>
        <div class="form-group"> <!-- Group container for password input -->
          <label for="password">Password</label>
          <input type="password" id="password" v-model="password" class="form-control" required /> <!-- Input for password, bound to data property -->
        </div>
        <div v-if="error" class="text-danger error-message">{{ error }}</div> <!-- Error message displayed if there's an error -->
        <button type="submit" class="btn btn-primary submit-btn">Login</button> <!-- Submit button for the form -->
      </form>
      <p class="register-link">Don't have an account? <a href="#" @click.prevent="$emit('switchToRegister')">Register here</a></p> <!-- Link to switch to the registration form -->
    </div>
  </div>
</template>

<script>
export default {
  name: 'User',
  data() {
    return {
      username: '', // Data property for username input
      password: '', // Data property for password input
      error: null, // Data property for storing error messages
    };
  },
  methods: {
    async loginUser() { //Method to handle user login
      try {
        console.log('Attempting to log in with username:', this.username); // Log the login attempt

        const response = await fetch('http://localhost:3000/login', { // Make an API call to login
          method: 'POST',
          headers: { 'Content-Type': 'application/json' }, // Set content type to JSON
          credentials: 'include',  // Ensure cookies are sent with the request
          body: JSON.stringify({ // Convert username and password to JSON format
            username: this.username,
            password: this.password,
          }),
        });

        const result = await response.json(); // Parse the response JSON
        console.log('Server response:', result);  // Log the server response

        if (response.ok) {
          console.log('Login successful');  // Log success message
          this.$emit('loggedIn');  // Emit a custom event on successful login
          this.$emit('close');  // Close the login form on success
        } else {
          console.log('Login failed:', result.message);  // Log failure message
          this.error = result.message || 'Username or password wrong';
        }
      } catch (err) {
        console.log('Error during login:', err);  // Log the error
        this.error = 'Login failed. Please try again.';
      }
    },
  },
};
</script>

<style scoped>
.login-modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.6);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 2000;
}
.login-form {
  background: white;
  padding: 30px;
  border-radius: 10px;
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
  width: 400px;
  text-align: center;
}
.close-btn {
  position: absolute;
  top: 10px;
  right: 15px;
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
  padding: 10px; /* Adds some padding around the "X" for click area */
}
.close-btn:hover {
  color: #335db6; /* Change color on hover for better visibility */
}
.form-title {
  margin: 0; /* Remove default margin for title */
  font-size: 24px; /* Larger font size for the title */
  color: #333; /* Darker color for the title */
}

.form-group {
  margin-bottom: 20px; /* Space between form fields */
}

.form-control {
  padding: 10px; /* Comfortable padding for input fields */
  border: 1px solid #ccc; /* Light border for input fields */
  border-radius: 5px; /* Rounded corners for input fields */
  width: 100%; /* Full width for input fields */
  transition: border-color 0.3s; /* Smooth transition for border color on focus */
}

.form-control:focus {
  border-color: #007bff; /* Change border color on focus */
  outline: none; /* Remove default outline */
}

.error-message {
  margin-top: 10px; /* Space above the error message */
  font-weight: bold; /* Bold error message for emphasis */
}

.submit-btn {
  width: 100%; /* Full width for the submit button */
  padding: 10px; /* Comfortable padding for the button */
  border-radius: 5px; /* Rounded corners for the button */
}

.register-link {
  margin-top: 15px; /* Space above the registration link */
}

.register-link a {
  color: #007bff; /* Link color */
  text-decoration: none; /* Remove underline from link */
}

.register-link a:hover {
  text-decoration: underline; /* Underline on hover for clarity */
}
</style>
