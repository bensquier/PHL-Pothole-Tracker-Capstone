<template>
  
  <v-card flat width="100%" height="29vh"
    class="mx-auto">
    <v-navigation-drawer permanent width='100%'>
      <v-list-item>
        <v-list-item-title>
          Actions
        </v-list-item-title>
      </v-list-item>
      <v-divider></v-divider>
      <v-list-item>
        <v-btn
          class="ma-2"
          outlined
          color="secondary darken-2"
        >
          Submit a Damage Claim
        </v-btn>
        <v-btn
          class="ma-2"
          outlined
          color="secondary darken-1"
          @click="$router.go(-1)"
        >
          Report A Pothole
        </v-btn>
      </v-list-item>
      <v-list-item>
      </v-list-item>
    </v-navigation-drawer>
  </v-card>

</template>

<script>
export default {
  data: () => ({

  }),
  computed: {

  },
  methods: {

  },
}
</script>