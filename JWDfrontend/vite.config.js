import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueDevTools from 'vite-plugin-vue-devtools'

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    vue(),
    vueDevTools(),
  ],
  server: {
    fs: {
      allow: [
        // Allow access to Font Awesome webfonts in node_modules
        '/Users/israanhayle/Desktop/jwdproject',
        '/Users/israanhayle/Desktop/jwdproject/node_modules/@fortawesome/fontawesome-free/webfonts',
        '/Users/israanhayle/Desktop/jwdproject/JWDfrontend'
      ]
    },
    proxy: {
      // Proxy API requests to the backend (assuming backend is on localhost:5000)
      '/api': {
        target: 'http://localhost:3000',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, ''),
      },
    },
  },
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  }
})
