import './assets/main.css';
import { createApp } from 'vue';
import { createPinia } from 'pinia';
import 'bootstrap/dist/css/bootstrap.min.css';
import App from './App.vue';
import router from './router';
import axios from 'axios';

// FontAwesome imports
import { library } from '@fortawesome/fontawesome-svg-core';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import { faHeart as fasHeart } from '@fortawesome/free-solid-svg-icons';
import { faHeart as farHeart } from '@fortawesome/free-regular-svg-icons';

// Add FontAwesome icons to the library
library.add(fasHeart, farHeart);

// Create the Vue app
const app = createApp(App);

// Register the font-awesome-icon component globally
app.component('font-awesome-icon', FontAwesomeIcon);

// Configure global properties
app.config.globalProperties.$axios = axios;

// Use Pinia and Router
app.use(createPinia());
app.use(router);

// Mount the app
app.mount('#app');
