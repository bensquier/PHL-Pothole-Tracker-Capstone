<template>
  <v-app id="inspire">
       <!----------------------- Parallax ------------------->
 <v-container fluid ma-0 pa-0>
    <v-parallax class="parallax"
          dark
          src="@/assets/contactus.png"
  >
          <v-row
          align="center"
          justify="center"
          
    >
      <v-col
        class="text-center"
        cols="12"
        
      >
        <h1 class="display-3 mb-3">
          Having trouble finding what you need?
        </h1>
        <h3 class="subheading">
          Contact us today
        </h3>
      </v-col>
    </v-row>
  </v-parallax>
  </v-container>
 <!----------------------- Contact Us Form ------------------->
      <v-main class="grey lighten-3">
      <v-container>
        <v-row>
        <v-col
            cols="12"
            sm="12"
            
          >
            <v-sheet
              min-height="45vh"
              rounded="lg"

              
            >
          <v-card-title>
            Contact Us
          </v-card-title>
          <v-container>
             <v-form
            ref="form"
            v-model="valid"
           lazy-validation
          
    
  >
   <!----------------------- Name ------------------->
    <v-text-field
      v-model="name"
      label="Name"
      required
    ></v-text-field>
 <!----------------------- Email ------------------->
    <v-text-field
      v-model="email"
      :rules="emailRules"
      label="E-mail"
      required
    ></v-text-field>
 <!----------------------- Reason ------------------->
    <v-select
      v-model="select"
      :items="items"
      :rules="[v => !!v || 'Reason is required']"
      label="Reason for email"
      required
    ></v-select>
    <!----------------------- Message ------------------->   
    <v-textarea
      v-model="message"
      :counter="180"
      :rules="messageRules"
      label="Please enter your message"
      single-line
    ></v-textarea>
    
 <!----------------------- Submit ------------------->
    <v-btn
      :disabled="!valid"
      color="success"
      class="mr-4"
      @click="validate"
    >
      Send Email
    </v-btn>

 <!----------------------- Reset ------------------->
    <v-btn
      color="error"
      class="mr-4"
      @click="reset"
    >
      Reset Form
    </v-btn>
  </v-form>  

<!----------------------- Snackbar------------------->

      <v-snackbar
      v-model="snackbar"
      :multi-line="multiLine"
      centered
    >
      {{ text }}

      <template v-slot:action="{ attrs }">
        <v-btn
          color="green"
          text
          v-bind="attrs"
          @click="snackbar = false"
          
        >
          Close
        </v-btn>
      </template>
    </v-snackbar>

</v-container> 
  </v-sheet>
  </v-col>
  </v-row>
</v-container>
<Footer/>
</v-main>
</v-app>
</template>

<script>
import Footer from '../components/Footer.vue'
  export default {
    components:{
    Footer
    },
    data: () => ({
      multiLine: true,
      snackbar: false,
      text: `Message Received.`,
      valid: true,
      name: '',
      email: '',
      emailRules: [
        v => !!v || 'E-mail is required',
        v => /.+@.+\..+/.test(v) || 'E-mail must be valid',
      ],
      select: null,
      items: [
        'I am having problems reporting a pothole',
        'I require information about a particular pothole',
        'I want information regarding my claim',
        'Other',
      ],
      message: '',
      messageRules: [
        v => !!v || 'Message is required',
        v => (v && v.length <= 180) || 'Message must be more than 10 characters',
      ],
    }),

    methods: {
      validate () {
        this.$refs.form.validate()
        this.snackbar = true;
        window.setTimeout(this.goBack, 1500); 
        
      },
      reset () {
        this.$refs.form.reset()
      },
      goBack(){
        this.$router.go(-1);

      }

    }
  }
</script>


<style scoped>
</style>
