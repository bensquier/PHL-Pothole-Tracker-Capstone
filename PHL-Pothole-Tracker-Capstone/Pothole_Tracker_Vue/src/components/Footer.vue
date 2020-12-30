<template>
  
  <v-footer
    color="info darken-1"
    padless
  >
    <v-row
      justify="center"
      no-gutters
    >
      <v-btn
        v-for="link in footerLinks"
        :key="link"
        color="white"
        text
        rounded
        class="my-2"
        @click="$router.push({name: link}).catch(()=>{})"
      >
        {{ link }}
      </v-btn>
      <v-col
        class="info darken-2 text-center white--text"
        cols="12"
      >
        {{ new Date().getFullYear() }} — <strong>PHL</strong>
      </v-col>
    </v-row>
  </v-footer>
</template>

<script>
export default {
  data: () => ({
    footerLinks: [
      'team',
      'blog',
      'contact',
    ],
  })
}
</script>