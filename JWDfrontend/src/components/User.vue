<template>
  <div class="login-modal">
    <div class="login-form">
      <button class="close-btn" @click="$emit('close')">×</button>
      <h3>Login</h3>
      <form @submit.prevent="loginUser">
        <div class="form-group">
          <label for="username">Username</label>
          <input type="text" id="username" v-model="username" class="form-control" required />
        </div>
        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" v-model="password" class="form-control" required />
        </div>
        <div v-if="error" class="text-danger">{{ error }}</div>
        <button type="submit" class="btn btn-primary">Login</button>
      </form>
      <p>Don't have an account? <a href="#" @click.prevent="$emit('switchToRegister')">Register here</a></p>
    </div>
  </div>
</template>

<script>
export default {
  name: 'User',
  data() {
    return {
      username: '',
      password: '',
      error: null,
    };
  },
  methods: {
    async loginUser() {
      try {
        console.log('Attempting to log in with username:', this.username); // Log the attempt

        const response = await fetch('http://localhost:3000/login', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          credentials: 'include',  // Ensure cookies are sent with the request
          body: JSON.stringify({
            username: this.username,
            password: this.password,
          }),
        });

        const result = await response.json();
        console.log('Server response:', result);  // Log the server response

        if (response.ok) {
          console.log('Login successful');  // Log success message
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
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 2000;
}
.login-form {
  background: white;
  padding: 20px;
  border-radius: 5px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  position: relative; /* Make the close button positionable */
}
.close-btn {
  position: absolute;
  top: -20px; /* Move the "X" higher above the form */
  left: -10px; /* Move the "X" further to the left */
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
  padding: 10px; /* Adds some padding around the "X" for click area */
}

.login-form h3 {
  margin-top: 0px; /* Add space between the "X" and the heading */
}
</style>
