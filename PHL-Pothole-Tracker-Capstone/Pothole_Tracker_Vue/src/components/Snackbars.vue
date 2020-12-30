<template>
 <div> 
    <v-snackbar
      :timeout="timeout"
      :value="reportSuccess"
      absolute
      bottom
      right
      color="success accent-4"
      elevation="24"
    >
      Success! Pothole Added
    </v-snackbar>

    <v-snackbar
      :timeout="timeout"
      :value="reportSuccess"
      absolute
      bottom
      right
      color="acccent accent-4"
      elevation="24"
    >
      Error: Could not be created
    </v-snackbar>

    <v-snackbar
      :timeout="timeout"
      :value="loginSuccess"
      absolute
      bottom
      right
      color="success accent-4"
      elevation="24"
    >
      Success! Welcome!
    </v-snackbar>
    
    <v-snackbar
      :timeout="timeout"
      :value="loginSuccess"
      absolute
      bottom
      right
      color="acccent accent-4"
      elevation="24"
    >
      Error: Invalid username or password.
    </v-snackbar>
 </div>    
</template>

<script>
export default {
  
  computed: {
    reportSuccess() {
      return this.$store.getters.reportSuccess;
    },
    loginSuccess() {
      return this.$store.getters.loginSuccess;
    },
    timeout() {
      return this.$store.getters.timeout;
    }
  }
}
</script>