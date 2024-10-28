// Main entry point for my frontend application
import './assets/main.css'; // Import the main stylesheet for custom CSS styles
import { createApp } from 'vue'; // Import Vue's createApp function to initialize the application
import { createPinia } from 'pinia'; // // Importing Pinia, the state management library
import 'bootstrap/dist/css/bootstrap.min.css'; // Importing the CSS framework Bootstrap
import App from './App.vue'; // Import the main root component of the application
import router from './router'; // Import the router configuration for handling routes within the app

// FontAwesome imports
import { library } from '@fortawesome/fontawesome-svg-core';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import { faHeart as fasHeart } from '@fortawesome/free-solid-svg-icons';
import { faHeart as farHeart } from '@fortawesome/free-regular-svg-icons';

// Add FontAwesome icons to the library
library.add(fasHeart, farHeart);

// Create the main Vue application instance using the App component as the root
const app = createApp(App);

// Register the font-awesome-icon component globally
app.component('font-awesome-icon', FontAwesomeIcon);

// Use Pinia and Router
app.use(createPinia());
app.use(router);

// Mount the app
app.mount('#app');
