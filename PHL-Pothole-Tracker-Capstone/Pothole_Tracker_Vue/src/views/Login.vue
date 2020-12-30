<template>
<v-parallax
  src="@/assets/login.jpg"
  height="900"
>
<v-container bg fill-height grid-list-md>
  <v-layout row wrap align-center justify-center>
    <v-flex align-self-center
      class="d-flex justify-center">
      <v-card
        max-width="425"
        hover
      >
        <v-card-title class="justify-center">
          <span class="headline">Login to Your Account</span>
        </v-card-title>
        <v-card-text>
          <v-form v-model="validForm" id="login-form"
            @submit.prevent="login">
            <v-container>
              <v-row>
                <v-col cols="12" >
                  <v-text-field
                    v-model="user.username"
                    label="Username*"
                    :rules="nameRules"
                    required
                  ></v-text-field>
                </v-col>
                <v-col cols="12">
                  <v-text-field
                    v-model="user.password"
                    label="Password*"
                    type="password"
                    :rules="passwordRules"
                    required
                  ></v-text-field>
                </v-col>
              </v-row>
            </v-container>
          </v-form>
          <small>*indicates required field</small>
        </v-card-text>
        <v-card-actions class="justify-center">
          <v-btn
            color="success lighten-1"
            type="submit"
            :disabled="!validForm"
            rounded
            form="login-form"
          >
            Login
          </v-btn>
          <v-btn
            color="primary lighten-1"
            text
            rounded
            @click="$router.push('/')"
          >
            Cancel
          </v-btn>
        </v-card-actions>
              <v-snackbar
      v-model="snackbar"
      :timeout="timeout"
      color="accent"
      centered
      >
      {{ text }}

      <template v-slot:action="{ attrs }">
        <v-btn
          color="white"
          text
          v-bind="attrs"
          @click="snackbar = false"
        >
          Close
        </v-btn>
      </template>
    </v-snackbar>
      </v-card>

    </v-flex>
  </v-layout>
</v-container>
</v-parallax>


</template>

<script>
export default {
    data: () => ({
      dialog: false,
      validForm: false,
      snackbar: false,
      text: 'Invalid Username / Password.',
      timeout: 2300,
      user: {
        username: "",
        password: ""
      },
      nameRules: [
        v => !!v || 'Name is required',
        v => v.length <= 25 || 'Name must be less than 25 characters',
      ],
      passwordRules: [
        v => !!v || 'Password is required',
        v => v.length >= 8 || 'Password must be at least 8 characters',
      ],
    }),

    methods: {
      login() {
        this.$store.dispatch('authenticate', {
          username: this.user.username,
          password: this.user.password
        })
          .then(() => {
            if(this.user.username === 'admin'){
              this.$router.push({name: 'admin'});
            }else{
            this.$router.push({ name: 'user' });
            }
            
          })
          .catch(() => {
            this.runSnackbar();
          });
      },
      runSnackbar() {
        this.snackbar = true;
      }
    },
    computed: {
      isLoggedIn() {
        return this.$store.getters.isLoggedIn;

      },
    },
}
</script>
