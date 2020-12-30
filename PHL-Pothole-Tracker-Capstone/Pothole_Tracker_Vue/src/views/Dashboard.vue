<template>
  <v-container fluid>
    <v-row dense
        class="d-flex flex-column-reverse flex-md-row flex-lg-row"
    >
      <!-- LIST VIEW -->
      <v-col
        md="5"
        lg="4"
        sm="12"
        xs="12"
      >
        <v-sheet rounded
          elevation="2"
          :height="mobileListCheck"
        >

          <v-card flat>
            <v-card-title class="info lighten-2 white--text py-2">
              <span class="headline">{{ isLoggedIn? `Welcome, ${username}`: 'Report Map'}}</span>
              <v-spacer></v-spacer>
              <v-tooltip left>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                   @click="$router.go().catch(()=>{})"
                    color="white"
                    icon
                    v-bind="attrs"
                    v-on="on"
                  >
                    <v-icon>mdi-cached</v-icon>
                  </v-btn>
                </template>
                <span>Refresh Map</span>
            </v-tooltip>
                
            </v-card-title>
          </v-card>
          <!-- ////////////// POTHOLE LIST ////////////////////  -->
          <v-divider></v-divider>


          <!-- ///////////////// USER ACTIONS ///////////////// -->
          <v-divider class="ma-0"></v-divider>
          <!-- <v-btn :to="{name: 'report'}">
            User Actions Test
          </v-btn> -->
          <transition
            mode="out-in"
            enter-active-class="animate__animated animate__zoomIn"
            leave-active-class="animate__animated animate__zoomOut"
          >
            <router-view></router-view>
          </transition>
        </v-sheet>
      </v-col>

      <!-- MAP -->
      <v-col
        md="7"
        lg="8"
        sm="12"
        xs="12"
        class="flex-sm-column-reverse"
        >
        <v-sheet
          :height="mobileCheck"
          rounded
          elevation="2"
        >
          <Map/>
        </v-sheet>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import Map from '../components/Map.vue'
export default {
  name: "dashboard",
  components: {
    Map,
  },
  data: () => ({
    selectedItem: 0,
    model: 1,
    currentList: [],
  }),

  computed: {
    potholes: {
      get() {
        return this.$store.getters.allPotholes;
      }
    },
    isLoggedIn: {
      get() {
        return this.$store.getters.isLoggedIn;
      }
    },
    username: {
      get() {
        return this.$store.getters.username;
      }
    },
    mobileCheck() {
      if(this.$vuetify.breakpoint.smAndUp) {
        return '90vh';
      } else {
        return '60vh';
      }
    },
    mobileListCheck() {
      if(this.$vuetify.breakpoint.smAndUp) {
        return '100%';
      } else {
        return '50%';
      }
    }
  },

  methods: {
    sendToMap(selection) {
      this.selection = selection;
    }
  },
}
</script>

<style scoped>
.animate__animated.animate__zoomIn {
  --animate-duration: 250ms;
}
</style>
