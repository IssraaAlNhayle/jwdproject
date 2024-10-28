<template>
  <!-- Based on the URL, this is where the main content of each page will be displayed -->
  <RouterView />
</template>

<script setup>
// Importing RouterView, a component that acts as a placeholder for rendering the matched route's component based on the URL
import { RouterLink, RouterView } from 'vue-router'
</script>


