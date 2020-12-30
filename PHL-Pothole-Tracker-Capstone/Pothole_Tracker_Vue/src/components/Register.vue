<template>
  <div>
    <v-dialog
        v-model="dialog"
        width="400"
      >
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            color="secondary"
            dark
            v-bind="attrs"
            v-on="on"
            style="margin-right: 1rem;"
            rounded
          >
            Sign Up
          </v-btn>
        </template>

        <v-card>
          <v-card-title class="justify-center">
            <span class="headline">Register an Account</span>
          </v-card-title>
          <v-card-text>
            <v-form v-model="validForm"
              id="reg-form"
              @submit.prevent="register">
              <v-container>
                <v-row>
                  <v-col cols="12" >
                    <v-text-field
                      v-model="newUser.username"
                      :rules="nameRules"
                      hint="Must be less than 25 characters."
                      persistent-hint
                      label="Username*"
                      required
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <v-text-field
                      v-model="newUser.password"
                      :rules="passwordRules"
                      hint="Must be at least 8 characters."
                      persistent-hint
                      label="Password*"
                      type="password"
                      required
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <v-text-field
                      v-model="newUser.confirmPassword"
                      :rules="confirmPasswordRules"
                      label="Confirm Password*"
                      type="password"
                      required
                    ></v-text-field>
                  </v-col>
                </v-row>
              </v-container>
            </v-form>
            <small>*indicates required field</small>
          </v-card-text>
          <v-card-actions class="justify-center">
            <!-- <v-spacer></v-spacer> -->
            <v-btn
              color="success lighten-1"
              :disabled="!validForm"
              rounded
              type="submit"
              form="reg-form"
            >
              Create
            </v-btn>
            <v-btn
              color="primary lighten-1"
              text
              rounded
              @click="closeDialog"
            >
              Cancel
            </v-btn>
          </v-card-actions>
        </v-card>
    </v-dialog>
    <v-snackbar
      v-model="snackbar"
      :timeout="timeout"
      color="success"
      centered
    >
      {{ this.registrationMsg }}

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
  </div>
</template>

<script>
import authService from '../services/AuthService.js'
export default {
    data() {
      return {
        dialog: false,
        validForm: false,
        snackbar: false,
        registrationMsg: "",
        timeout: 3000,
        newUser: {
          username: "",
          password: "",
          confirmPassword: "",
          role: "user",
        },
        nameRules: [
          v => !!v || 'Name is required',
          v => v.length <= 25 || 'Name must be less than 25 characters',
        ],
        passwordRules: [
          v => !!v || 'Password is required',
          v => v.length >= 8 || 'Password must be at least 8 characters',
        ],
        confirmPasswordRules: [
          v => !!v || 'Password check is required',
          v => v === this.newUser.password || 'Passwords do not match.'
        ],
      }
    },
    methods: {
      register() {
        authService
          .register(this.newUser)
          .then((response) => {
            if (response.status == 201) {
              this.registrationMsg = 'Account successfully created!';
              console.log(this.registrationMsg);
              this.closeDialog();
              //this.$router.go();
            }
          })
          .catch((error) => {
            const response = error.response;
            this.registrationErrors = true;
            if (response.status === 400) {
              this.registrationMsg = 'Error: Account may already be in use.';
            }
          });
        this.runSnackbar();
      },
      closeDialog() {
        this.dialog = !this.dialog;
        this.newUser = {
          username: "",
          password: "",
          confirmPassword: "",
          role: "user",
        };
      },
      runSnackbar() {
        this.snackbar = true;
      }
    },
}
</script>