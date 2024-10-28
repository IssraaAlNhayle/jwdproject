<template>
  <div class="registration-modal"> <!-- Main container for the registration modal -->
    <div class="registration-form"> <!-- Container for the registration form -->
      <!-- Close 'X' icon at the top left -->
      <button class="close-btn" @click="$emit('close')">×</button> <!-- Button to close the modal, emits 'close' event -->
      <h3>Register</h3>
      <form @submit.prevent="registerUser"> <!-- Form that prevents default submission and calls registerUser method -->
        <div class="form-group"> <!-- Group container for username input -->
          <label for="username">Username</label>
          <input type="text" id="username" v-model="username" class="form-control" required /> <!-- Input for username, bound to data property -->
        </div>
        <div class="form-group"> <!-- Group container for password input -->
          <label for="password">Password</label>
          <input type="password" id="password" v-model="password" class="form-control" required /> <!-- Input for password, bound to data property -->
        </div>
        <div v-if="error" class="text-danger">{{ error }}</div>
        <div v-if="successMessage" class="text-success">{{ successMessage }}</div>
        <button type="submit" class="btn btn-primary">Register</button>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      username: '',
      password: '',
      error: null,
      successMessage: null,
    };
  },
  methods: {
    async registerUser() { // Method to handle user registration
      try {
        console.log('Attempting to register with username:', this.username); // Log the registration attempt

        const response = await fetch('http://localhost:3000/register', { // Make an API call to register
          method: 'POST',
          headers: { 'Content-Type': 'application/json' }, // Set content type to JSON
          body: JSON.stringify({ // Convert username and password to JSON format
            username: this.username,
            password: this.password,
          }),
        });

        const result = await response.json();
        console.log('Registration response:', result);

        if (response.ok) {
          // Successful registration
          this.successMessage = 'Registration successful!';
          this.error = null;
          // Optionally, clear input fields after successful registration
          this.username = '';
          this.password = '';
          this.$emit('close'); // Emit 'close' event to the parent component to close the modal
        } else {
          this.error = result.message || 'Registration failed';
          this.successMessage = null;
        }
      } catch (err) {
        console.log('Error during registration:', err);
        this.error = 'Registration failed. Please try again.';
        this.successMessage = null;
      }
    },
  },
};
</script>

<style scoped>
.registration-modal {
  position: fixed; /* Fixes modal to the viewport */
  top: 0; /* Aligns to the top */
  left: 0; /* Aligns to the left */
  width: 100%; /* Full width of the screen */
  height: 100%; /* Full height of the screen */
  background: rgba(0, 0, 0, 0.5); /* Semi-transparent black background */
  display: flex; /* Flexbox for centering content */
  justify-content: center; /* Centers items horizontally */
  align-items: center; /* Centers items vertically */
  z-index: 2000; /* Stacking context to appear above other elements */
}

.registration-form {
  background: white; /* White background for the form */
  padding: 30px; /* Increased padding for a spacious feel */
  border-radius: 10px; /* More rounded corners */
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); /* Shadow for depth */
  width: 400px; /* Fixed width for consistency */
  text-align: center; /* Center-align text within the form */
}

.close-btn {
  position: absolute; /* Absolute positioning to place close button */
  top: 10px; /* Positioning from the top */
  right: 15px; /* Positioning from the right */
  background: none; /* No background for the button */
  border: none; /* No border */
  font-size: 28px; /* Larger close button */
  color: #aaa; /* Light color for the close button */
  cursor: pointer; /* Pointer cursor on hover */
}

.close-btn:hover {
  color: #ff0000; /* Change color on hover for better visibility */
}

.registration-form h3 {
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

.success-message {
  margin-top: 10px; /* Space above the success message */
  font-weight: bold; /* Bold success message for emphasis */
  color: green; /* Green color for success messages */
}
</style>
