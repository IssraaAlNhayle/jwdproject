<template>
  <div class="registration-modal">
    <div class="registration-form">
      <h3>Register</h3>
      <form @submit.prevent="registerUser">
        <div class="form-group">
          <label for="username">Username</label>
          <input type="text" id="username" v-model="username" class="form-control" required />
        </div>
        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" v-model="password" class="form-control" required />
        </div>
        <div v-if="error" class="text-danger">{{ error }}</div>
        <div v-if="successMessage" class="text-success">{{ successMessage }}</div>
        <button type="submit" class="btn btn-primary">Register</button>
      </form>
      <button @click="$emit('close')" class="btn btn-secondary mt-3">Close</button>
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
    async registerUser() {
      try {
        console.log('Attempting to register with username:', this.username);

        const response = await fetch('http://localhost:3000/register', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
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
.registration-form {
  background: white;
  padding: 20px;
  border-radius: 5px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}
</style>

