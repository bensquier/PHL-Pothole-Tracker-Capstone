<template>
  <v-card>
    <v-toolbar
      dark
      color="warning darken-1"
    >
      <v-btn
        icon
        dark
        @click="goBack"
      >
        <v-icon>mdi-close</v-icon>
      </v-btn>
      <v-toolbar-title>Update a Pothole</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-items>
      </v-toolbar-items>
    </v-toolbar>
    <v-list
      three-line
      subheader
    >
     
      <v-list-item>
        <v-list-item-content>
          <v-list-item-title>Current pothole:</v-list-item-title>
          <v-list-item-subtitle>Pothole ID: {{currentPothole.potholeId}} </v-list-item-subtitle>
          <v-list-item-subtitle>Latitude: {{currentPothole.latitude}} </v-list-item-subtitle>
          <v-list-item-subtitle>Longitude: {{currentPothole.longitude}} </v-list-item-subtitle>
          <v-list-item-subtitle>Street: {{currentPothole.roadName}} </v-list-item-subtitle>
          <v-list-item-subtitle>Direction: {{currentPothole.direction}} </v-list-item-subtitle>
          <v-list-item-subtitle>Current Severity: {{currentPothole.severity}} </v-list-item-subtitle>
          <v-list-item-subtitle>Current Status: {{currentPothole.status}} </v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
      <v-list-item>
        <v-list-item-content>
        <v-list-item-title>Please update this pothole </v-list-item-title>
  <validation-observer
    ref="observer"
    v-slot="{ invalid }"
  >
    <form @submit.prevent="submit">
      <validation-provider
        immediate
        v-slot="{ errors }"
        name="status"
        rules="required"
      >
        <v-select
          v-model="currentPothole.status"
          :items="status"
          :error-messages="errors"
          label="Status"
          data-vv-name="select"
          required
        ></v-select>
      </validation-provider>
      <validation-provider
        immediate
        v-slot="{ errors }"
        name="severity"
        rules="required"
      >
        <v-select
          v-model="currentPothole.severity"
          :items="severities"
          :error-messages="errors"
          label="Severity"
          data-vv-name="select"
          required
        ></v-select>
      </validation-provider>
      <validation-provider
        v-slot="{ errors }"
        name="Street"
        rules="required|max:25"
      >
        <v-text-field
          v-model="currentPothole.roadName"
          :counter="25"
          :error-messages="errors"
          label="Street Name(s)"
          required
        ></v-text-field>
      </validation-provider>
      <validation-provider
        v-slot="{ errors }"
        name="Direction"
        rules="required|max:25"
      >
        <v-text-field
          v-model="currentPothole.direction"
          :counter="25"
          :error-messages="errors"
          label="Direction"
          required
        ></v-text-field>
      </validation-provider>
      <v-btn
        class="mr-4"
        color="warning"
        type="submit"
        :disabled="invalid"
      >
        submit
      </v-btn>
    </form>
  </validation-observer>
        </v-list-item-content>
      </v-list-item>
    </v-list>
    <v-dialog
      v-model="dialog"
      max-width="350"
    >
      <v-card>
        <v-card-title class="headline">
         Update Successful
        </v-card-title>

        <v-card-text>
          Refresh map to see your changes
        </v-card-text>

        <v-card-actions>
          <v-spacer></v-spacer>

          <v-btn
            color="green darken-1"
            text
            @click="endDialog"
          >
            Ok
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-card>
</template>

<script>
import { mapGetters } from 'vuex';
import { required, max } from 'vee-validate/dist/rules'
import { extend, ValidationObserver, ValidationProvider, setInteractionMode } from 'vee-validate'

setInteractionMode('eager')

extend('required', {
  ...required,
  message: '{_field_} can not be empty',
})

extend('max', {
  ...max,
  message: '{_field_} may not be greater than {length} characters',
})
export default {
  components: {
    ValidationProvider,
    ValidationObserver,
  },
  data () {
    return {
      dialog: false,
      valid: true,
      newPothole: {
        direction: '',
        lane: '',
        latitude: 0,
        longitude: 0,
        roadName: '',
        severity: '',
        status: '',
        username: '',
      },
      severities: ['High', 'Medium', 'Low'],
      status: ['Inspected', 'Completed'],
      rules: [ (v) => !!v || 'Cannot be blank' ],
    }
  },  
  computed:{
    ...mapGetters({
      currentUser: 'username',
      currentPothole: 'activePothole'
    }),
  },
  methods:{
      async submit() {
        const isValid = await this.$refs.observer.validate();
        if (!isValid) {
          console.log('invalid form')
        } else {
          this.updatePothole();
        }
      },
      goBack(){
        // this.$store.dispatch('setReportModeOff');
         this.$router.go(-1);
      },
      updatePothole(){
        const updatedPothole = this.currentPothole;
        updatedPothole.username = this.currentUser;
        this.$store.dispatch('updatePothole', updatedPothole)
            .then(response =>{
              console.log(response.status)
                this.dialog = true
            })
            .catch(err =>{
                console.log(err)
            });
      },
      endDialog() {
        this.dialog = false;
        this.$router.push({name: 'admin'})
      }

  },
}
</script>