<template>
  <v-app id="inspire">
    <v-app-bar
      app
      color="info"
      flat
    >
      <v-container class="py-0 fill-height" fluid>
      <v-navigation-drawer v-model="sidebar" app>
        <v-list>
          <v-list-item
            @click="routeChange">
            <v-list-item-action>
              <v-icon>mdi-monitor-dashboard</v-icon>
            </v-list-item-action>
            <v-list-item-content>
              Dashboard
            </v-list-item-content>
          </v-list-item>
        </v-list>
      </v-navigation-drawer>
        <span class="hidden-sm-and-up">
          <v-app-bar-nav-icon @click="sidebar = !sidebar"></v-app-bar-nav-icon>
        </span>

        <v-avatar
          class="mr-10"
          color="grey darken-1"
          tile
          size="48"
          style="border-radius: 3px;"
          @click="$router.push('/').catch(()=>{})"
        >
        <img src="@/assets/phl-logo-cropped.png"
          alt="favicon">
        </v-avatar>

        <v-btn
          v-if="$vuetify.breakpoint.smAndUp"
          text
          color="white"
          @click="routeChange"
        >
          Dashboard
        </v-btn>

        <v-spacer v-if="$vuetify.breakpoint.smAndUp"></v-spacer>
        <v-btn
          v-if="isLoggedIn"
          color="info lighten-2"
          style="margin-right: 1rem;"
          rounded
          @click="logout"
          >Logout</v-btn>
        <v-btn class="login"
          v-else
          :to="{name: 'login'}"
        >
          Login
        </v-btn>
        <register
          v-if="!isLoggedIn"/>

      </v-container>
    </v-app-bar>
    <v-main class="grey lighten-3">
      <transition
        mode="out-in"
        enter-active-class="animate__animated animate__fadeIn"
        leave-active-class="animate__animated animate__fadeOut"
      >
        <router-view/>
      </transition>
    </v-main>
  </v-app>
</template>

<script>
import Register from './components/Register.vue'

export default {
  name: 'App',
  components: {
    Register,
  },
  data: () => ({
    dialog: false,
    headerLinks: [
      {
        name: 'dashboard',
        route: { name: 'anon'},
      }, 
      //{name: 'profile' },
    ],
    sidebar: false,
  }),
  
  computed: {
    isLoggedIn() {
      return this.$store.getters.isLoggedIn;
    }
  },

  methods: {
    logout() {
      this.$store.dispatch('logout');
      this.$router.push('/').catch(()=>{});
    },
    routeChange(){
      if(!this.$store.getters.isLoggedIn){
        this.$router.push({name: 'anon'});
      }
      else if(this.$store.getters.isLoggedIn){
        if(this.$store.getters.username ==='admin'){
          this.$router.push({name: 'admin'})
          .catch(()=> { });
        }
        else{
          this.$router.push({name: 'user'})
          .catch(() => { });
        }
      }
    },
  },
  created() {
    this.$store.dispatch('fetchPotholes');
  },
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  /* margin-top: 60px; */
}
.login {
  margin-right: 1rem;
}
.animate__animated.animate__fadeOut {
  --animate-duration: 250ms;
}
.margin-fix {

}
</style>