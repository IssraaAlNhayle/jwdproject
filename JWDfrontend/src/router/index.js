import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import BooksView from '../views/BooksView.vue';
import ReadingView from '../views/ReadingView.vue';
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
    },
    {
      path: '/books/:genreId', // New route for books based on genreId
      name: 'BooksView',
      component: BooksView,
      props: true
    },
    {
      path: '/reading-list', // New route for books based on genreId
      name: 'ReadingView',
      component: ReadingView,
      props: true
    }
  ],
})

export default router
