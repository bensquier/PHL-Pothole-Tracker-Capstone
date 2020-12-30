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
      <v-toolbar-title>Pothole details</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-items>
      </v-toolbar-items>
    </v-toolbar>
    <v-list>
      <v-list-item>
        <v-text-field 
          class="mt-2 mr-6"
          label="Latitude"
          :value="currentPothole.latitude" 
          readonly
          outlined
        >
        </v-text-field>
        <v-text-field 
          class="mt-2"
          label="Longitude"
          :value="currentPothole.longitude" 
          readonly
          outlined
        >
        </v-text-field>
      </v-list-item>
      <v-list-item>
        <v-list-item-title>Pothole ID</v-list-item-title>
        <v-text-field 
          class="mt-5"
          label="ID"
          :value="currentPothole.potholeId" 
          readonly
          solo
        >
        </v-text-field>
      </v-list-item>
      <v-list-item>
        <v-list-item-title>Street</v-list-item-title>
        <v-text-field 
          label="Street"
          :value="currentPothole.roadName" 
          readonly
          solo
        >
        </v-text-field>
      </v-list-item>
      <v-list-item>
        <v-list-item-title>Direction</v-list-item-title>
        <v-text-field 
          label="Direction"
          :value="currentPothole.direction" 
          readonly
          solo
        >
        </v-text-field>
      </v-list-item>
      <v-list-item>
        <v-list-item-title>Current Severity</v-list-item-title>
        <v-text-field 
          label="Severity"
          :value="currentPothole.severity" 
          readonly
          solo
        >
        </v-text-field>
      </v-list-item>
      <v-list-item>
        <v-list-item-title>Current Status</v-list-item-title>
        <v-text-field 
          label="Status"
          :value="currentPothole.status" 
          readonly
          solo
        >
        </v-text-field>
      </v-list-item>

      <v-list-item v-if="currentUser === 'admin'">
        <v-list-item-content>
          <v-container>
            <v-row> 
            <v-btn color="warning" :to="{name: 'update'}">Edit</v-btn>
            </v-row>
          </v-container>

        </v-list-item-content>
      </v-list-item>
    </v-list>
  </v-card>
</template>

<script>
import { mapGetters } from 'vuex';
// import potholeService from '../services/PotholeService'
export default {
  data () {
    return {
      dialog: false,
      notifications: false,
      sound: true,
      widgets: false,
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
      status: ['Inspected', 'Completed', 'Deleted'],
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
      goBack(){
        // this.$store.dispatch('setReportModeOff');
         this.$router.go(-1);
      },
      updatePothole(){
        const updatedPothole = this.currentPothole;
        updatedPothole.username = this.currentUser;

         
        }


  },
}
</script>

<style scoped>
.h2 {
  font-size: xx-small;
}
</style>
