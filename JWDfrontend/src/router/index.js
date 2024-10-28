// This index.js file is responsible for setting up Vue Router, which manages the different pages in my Vue application.
import { createRouter, createWebHistory } from 'vue-router' // Importing Vue Router functions needed to create a router instance and manage history.
// Lazy load for route components to improve performance by loading the component only when the respective route is accessed.
const Home = () => import('../views/Home.vue');
const BooksView = () => import('../views/BooksView.vue');
const ReadingView = () => import('../views/ReadingView.vue');
const CompletedView = () => import('../views/CompletedView.vue');
const FavoritesView = () => import('../views/FavoritesView.vue');
const NotFound = () => import('../views/NotFound.vue');

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL), // Set up history mode
  routes: [ // Array containing route definitions for each page of the application.
    {
      path: '/', //define the homepage route associated with different genres
      name: 'home', //name of the route
      component: Home, //specifies the vue component that will be rendered when the user navigates to the above URL
    },
    {
      path: '/books/:genreId', // New route for displaying books based on genreId
      name: 'BooksView',
      component: BooksView,
      props: true //enables passing route parameters as props to the component, simplifying access to genreId values.
    },
    {
      path: '/reading-list', // New route for retrieving the reading books list for a specific user
      name: 'ReadingView',
      component: ReadingView,
    },
    {
      path: '/completed-list', // New route for retrieving the completed books list for a specific user
      name: 'CompletedView',
      component: CompletedView,
    },
    {
      path: '/favorites-list', // New route for retrieving the favorite books list for a specific user
      name: 'FavoritesView',
      component: FavoritesView,
    },
    {
      path: '/:catchAll(.*)', // Catch-all route for handling pages that are undefined
      name: 'NotFound',
      component: NotFound, //renders the NotFound component when the user navigates to an undefined route
    },
  ],
})
export default router // Export the router instance so it can be imported and used in main.js
