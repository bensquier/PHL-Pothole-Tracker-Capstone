<template>

    <v-container fluid ma-0 pa-0>
     <!----------------------- Parallax ------------------->
    <v-parallax class="parallax"
          dark
          src="@/assets/parallaximage.png"
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
          PotHole Locator
        </h1>
        <h3 class="subheading">
          Report a Pothole Today
        </h3>
      </v-col>
    </v-row>
  </v-parallax>
  <v-main>
      <v-container justify-center>
          <v-row>
             <!----------------------- Card 1 ------------------->
          <v-col
            cols="12"
            sm="4"
          >
            <v-sheet height="100%">
               <v-card height="100%">
                 <v-img
                    src="@/assets/pothole1.png" class="pothole-images">
                </v-img>
                  <v-card-title>
                  Pothole Severity
                  </v-card-title>
                <v-card-text>
                We use a system that allows us to respond to high priority potholes by ranking them in severity from 1 to 3.
                In order to be classified as a severity 3
                pothole the minimum width is 12" and minimum length of 24" with a depth of 8" or more.
                The classification for a severity level 2 pothole is minimum width
                of 12", length 24" and depth of 4".
                Anything smaller is classed as a level 1 severity, although we also take
                into account the speed limit on the road and the location in regards to a vehicle passing over it.
              </v-card-text>
              </v-card>
            </v-sheet>
             </v-col>
              <!----------------------- Card 2 ------------------->
          <v-col
            cols="12"
            sm="4"
          >
            <v-sheet height="100%">
            <v-card height="100%">
              <v-img
              src="@/assets/pothole2.png" class="pothole-images">
              </v-img>
                  <v-card-title>
                  What are the causes of Potholes?
                  </v-card-title>
              <v-card-text>
              There are several different causes of potholes from water damage to being worn out due to use.
              Poor drainage upon the road can lead to washing out of the base or cause ice to form which can expand creating voids
              and allowing water movement.
              Some potholes are caused via the asphalt becoming warn out over time or from direct impact damage. This can cause damage to your car and lead to you
              having to repair a flat tire. If your car has been damaged due to a pothole be sure to file a claim.
              </v-card-text>
              </v-card>
            </v-sheet>
          </v-col>
          <!----------------------- Card 3 ------------------->
          <v-col
            cols="12"
            sm="4"
          >
            <v-sheet height="100%">
               <v-card height="100%">
                <v-img
                 src="@/assets/potholerepair.png" class="pothole-images">
                 </v-img>
                  <v-card-title>
                  How are repairs conducted?
                  </v-card-title>
              <v-card-text>
              Repairs are scheduled based on the level of severity in which priority is given to high severity rated cases.
              The repairs are made by a number of different methods, these include:
              - 25 pound bags of pre-made cold patch asphalt mix, manually placed and compressed into the pothole.
              - Dump trucks containing a large quantity of cold mix is driven to the site and manually compressed into the pothole by our staff.
              Once the pothole has been repaired a staff member will mark the repair as being completed.
              </v-card-text>
              </v-card>
            </v-sheet>
          </v-col>
          <!----------------------- FAQ SECTION ------------------->
          <v-container pb-7>
            <v-card-title>
            Frequently Asked Questions
            </v-card-title>
              <v-expansion-panels focusable>
              <v-expansion-panel>
                <v-expansion-panel-header>Can I report a Pothole?</v-expansion-panel-header>
                <v-expansion-panel-content>Yes, sign up to our website and visit your dashboard in order to report a pothole.</v-expansion-panel-content>
              </v-expansion-panel>
                <v-expansion-panel>
                <v-expansion-panel-header>What is the average wait time on repairing a pothole?</v-expansion-panel-header>
                <v-expansion-panel-content>We currently have a 45 day wait time on potholes but this fluctuates on severity and amount of potholes we have active.</v-expansion-panel-content>
              </v-expansion-panel>
                <v-expansion-panel>
                <v-expansion-panel-header>Can I make a claim for damage to my car?</v-expansion-panel-header>
                <v-expansion-panel-content>Yes, we have a claim feature when you are signed in as a user.</v-expansion-panel-content>
              </v-expansion-panel>
            </v-expansion-panels>
          </v-container>
         </v-row>
        </v-container>
      <Footer/>
    </v-main>
</v-container>
       

</template>





<script>
import Footer from '../components/Footer.vue'
  export default {
    components:{
      Footer
    }
  }
</script>


<style scoped>


.pothole-images {
   border-radius: 3px 3px;
   height: 175px;
   
}
</style>