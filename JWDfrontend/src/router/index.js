import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import BooksView from '../views/BooksView.vue';
import ReadingView from '../views/ReadingView.vue';
import CompletedView from '../views/CompletedView.vue';
import FavoritesView from '../views/FavoritesView.vue';
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
    },
    {
      path: '/completed-list', // New route for books based on genreId
      name: 'CompletedView',
      component: CompletedView,
      props: true
    },
    {
      path: '/favorites-list', // New route for books based on genreId
      name: 'FavoritesView',
      component: FavoritesView,
      props: true
    }
  ],
})

export default router
