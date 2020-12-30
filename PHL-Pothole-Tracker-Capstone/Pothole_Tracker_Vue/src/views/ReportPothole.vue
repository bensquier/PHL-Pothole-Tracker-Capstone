<template>
  <v-card>
    <v-toolbar
      dark
      color="secondary darken-2"
    >
      <v-btn
        icon
        dark
        @click="goBack"
      >
        <v-icon>mdi-close</v-icon>
      </v-btn>
      <v-toolbar-title>Report a Pothole</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-items>
        <v-btn
          dark
          text
          @click="sendReport"
        >
          Save
        </v-btn>
      </v-toolbar-items>
    </v-toolbar>
    <v-list
      three-line
      subheader
    >
      
      <v-list-item>
        <v-list-item-content>
          <v-list-item-title class="mb-6 mt-5">Click on the map to drop a pin</v-list-item-title>
          <v-list-item>
            <v-text-field 
              class="mt-2 mr-6"
              label="Latitude"
              :value="mapClick.latitude" 
              readonly
              outlined
            >
            </v-text-field>
            <v-text-field 
              class="mt-2"
              label="Longitude"
              :value="mapClick.longitude" 
              readonly
              outlined
            >
            </v-text-field>
          </v-list-item>
        </v-list-item-content>
      </v-list-item>
      <v-list-item>
        <v-list-item-content>
        <v-list-item-title>Please provide additional details (Optional)</v-list-item-title>
        <v-form id="login-form">
          <v-container>
            <v-row> 
              <v-col cols=12>
                <v-text-field label="Street Name"
                  v-model="newPothole.roadName"
                >
                </v-text-field>
              </v-col>
               <v-col cols=12>
                  <v-text-field label="Direction"
                    v-model="newPothole.direction"
                  >
                </v-text-field>
              </v-col>
            </v-row>
          </v-container>
        </v-form>
        </v-list-item-content>
      </v-list-item>
    </v-list>
     <v-dialog
      v-model="dialog"
      max-width="350"
    >
      <v-card>
        <v-card-title class="headline">
         Pothole already submitted!
        </v-card-title>

        <v-card-text>
          Thank you for your submission, but it looks like this pothole has already been reported. Please refer to the existing pothole pin for updates. 
        </v-card-text>

        <v-card-actions>
          <v-spacer></v-spacer>

          <v-btn
            color="green darken-1"
            text
            @click="endDialog()"
          >
            Ok
          </v-btn>
        </v-card-actions>
      </v-card>
     
    </v-dialog>
    <v-dialog
        v-model="success"
        max-width="350"
      >
        <v-card>
          <v-card-title class="headline">
            Pothole Added!
          </v-card-title>

          <v-card-text>
            Refresh the map now to see your report.
          </v-card-text>

          <v-card-actions>
            <v-spacer></v-spacer>

            <v-btn
              color="green darken-1"
              text
              @click="endDialog()"
            >
              Ok
            </v-btn>
          </v-card-actions>
        </v-card>
    </v-dialog>
  </v-card>
</template>

<script>
import potholeService from '../services/PotholeService'
export default {
  data () {
    return {
      dialog: false,
      success: false,
      newPothole: {
        direction: '',
        lane: '',
        latitude: 0,
        longitude: 0,
        roadName: '',
        severity: 'Not Inspected',
        status: 'Reported',
        username: '',
      }
    }
  },  
  computed:{
      currentUser(){
        return this.$store.getters.username;
      },
      mapClick(){
        return this.$store.getters.mapClick;
      }
  },
  methods:{
      goBack(){
        this.$store.dispatch('setReportModeOff');
        // this.$router.go();
        // location.reload();
        this.$router.go(-1);
      },
      clearForm(){
           this.newPothole.latitude=0,
                this.newPothole.longitude=0
                this.roadName= ''
                this.direction=''

      },
      sendReport(){
        this.newPothole.latitude = this.mapClick.latitude;
        this.newPothole.longitude = this.mapClick.longitude;
        this.newPothole.username = this.$store.getters.username;
        // this.$store.dispatch('sendReport',this.newPothole)
        potholeService.sendReport(this.newPothole)
            .then(() =>{
              this.success = true;
            })
            .catch(() =>{
              this.dialog = true;
            });
      },
      endDialog(){
        this.dialog=false
        this.success=false;
        this.clearForm()
        this.goBack()
      },

  },
  // beforeRouteLeave: (to,from,next) => {
  //   console.log(to.name);
  //   console.log(from.name);
  //   // const answer = window.confirm('Do you really want to leave? you have unsaved changes!')
  //   // if (answer) {
  //   //   next()
  //   // } else {
  //   //   next(false)
  //   // }
  // },
  // beforeDestroy:() => {
  //   const answer = window.confirm('Do you really want to leave? you have unsaved changes!');
  //   if (answer) {
  //     this.setReportModeOff();
  //     this.goBack();
  //   } else {
  //     this.goBack();
  //   }
  // },
}
</script>