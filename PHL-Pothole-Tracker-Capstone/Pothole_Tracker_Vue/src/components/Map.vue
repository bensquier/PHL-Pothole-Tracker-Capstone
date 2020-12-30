<template>
    <div>
        <div style="max-width: 800px; margin: 0 auto; display: flex; align-items: center; justify-content: space-between">
            <div hidden>
                <h1>Your coordinates:</h1>
                <p>{{ myCoordinates.lat }} Latitude, {{ myCoordinates.lng }} Longitude</p>
            </div>
            <div hidden>
                <h1>Map coordinates:</h1>
                <p>{{ mapCoordinates.lat }} Latitude, {{ mapCoordinates.lng }} Longitude</p>
            </div>
        </div>
        <gmap-map
            class="gmap"
            :center="myCoordinates"
            :zoom="reportMode ? 14 : this.zoom"
            :options="mapOptions"
            ref="mapRef"
            @dragend="handleDrag"
            @click="handleMapClick"
        >
            <gmap-info-window
                :options="infoWindowOptions"
                :position="infoWindowPosition"
                :opened="isInfoWindowOpen"
                @closeclick="handleInfoWindowClose"
                >
                <div class="info-window"
                    >
                    <h2>
                        <v-icon
                            medium
                            >
                        mdi-road
                        </v-icon>
                        Pothole on {{activePothole.roadName}}
                    </h2>
                    <p>
                        <v-icon
                            medium
                            color="orange darken-2"
                            >
                            mdi-alert
                        </v-icon>
                        Severity: {{activePothole.severity}}
                    </p>
                    <p>
                        <v-icon
                            medium
                            color="blue"
                            >
                            mdi-clipboard-check
                        </v-icon>
                        Report Status: {{activePothole.status}}
                    </p>
                    <v-btn x-small class="mx-auto mt-2" :to="{name:'details'}">View Details</v-btn>
                    <v-btn x-small color="accent" class="mx-auto mt-2"
                        v-if="username === 'admin'" @click="dialog = true">Delete</v-btn>
                </div>
            </gmap-info-window>
            <gmap-marker
                v-for="pothole in potholes"
                :key="pothole.potholeId"
                :position="getPosition(pothole)"
                :clickable="true"
                :icon="icon"
                :draggable="false"
                :size="30"
                @click="handleMarkerClicked(pothole.potholeId)"
            ></gmap-marker>    
            <gmap-marker
                :position="getPosition(mapClick)"
                :clickable="true"
                :draggable="true"
                :icon="{url: require('@/assets/map-pin-legend-received.png')}"
                :visible="reportMode"
                @click="handleMapClick"
            ></gmap-marker>    
        </gmap-map>
    <v-dialog
      v-model="dialog"
      max-width="350"
    >
      <v-card>
        <v-card-title class="headline">
         Confirm Delete
        </v-card-title>

        <v-card-text>
        Are you sure you would like to delete this pothole?
        </v-card-text>

        <v-card-actions>
          <v-spacer></v-spacer>

          <v-btn
            color="green darken-1"
            text
            @click="deletePothole"
          >
            Ok
          </v-btn>
        <v-btn
            color="darken-1"
            text
            @click="dialog = false"
        >
            Cancel
        </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    </div>
</template>
<script>

//import potholeServices from '../services/PotholeService.js';
import { mapGetters } from 'vuex'
export default {
    data: () => ({
        dialog: false,
        map: null,
        myCoordinates: {
            lat: 0,
            lng: 0
        },
        zoom: 12,
        icon: {
            url: require('@/assets/pin.png'),
            scaledSize: {width: 38, height: 38},
            labelOrigin: {x: 16, y: -10}
        },
        mapOptions: {
            clickableIcons: false,
            disableDoubleClickZoom: true,
            gestureHandling: "greedy",
             styles: [
            {
                featureType: "poi",
                elementType: "labels.text",
                stylers: [
                {
                    visibility: "off"
                }
                ]
            },
            {
                featureType: "poi.business",
                elementType: "labels",
                stylers: [
                {
                    visibility: "off"
                }
                ]
            },
            {
                featureType: "road",
                elementType: "labels.icon",
                stylers: [
                {
                    visibility: "off"
                }
                ]
            },
            {
                featureType: "transit",
                stylers: [
                {
                    visibility: "off"
                }
                ]
            }
            ]

        },
        infoWindowOptions: {
            pixelOffset: {
                witdth: 0,
                height: -35
            }
        },
        mapClick: {
            latitude: 0,
            longitude: 0,
        },
        isInfoWindowOpened: false,
    }),
    computed: {
        ...mapGetters({
            potholes: 'allPotholes',
            reportMode: 'reportMode',
            activePothole: 'activePothole',
            isInfoWindowOpen: 'isInfoWindowOpen',
            username: 'username',
        }),
        mapCoordinates() {
            if(!this.map) {
                return {
                    lat: 0,
                    lng: 0
                };
            }
            return {
                lat: this.map.getCenter().lat().toFixed(5),
                lng: this.map.getCenter().lng().toFixed(5)
            }
        },
        infoWindowPosition() {
            if (this.activePothole.latitude === undefined) {
                return {
                    lat: 0,
                    lng: 0
                }
            }
            return {
                lat: parseFloat(this.activePothole.latitude),
                lng: parseFloat(this.activePothole.longitude),
            }
        },
        // activePotholeIndex() {
        //     return this.$store.getters.activePotholeIndex;
        // },
        // hasMenuSelection() {
        //     return this.$store.getters.hasMenuSelection;
        // }
    },
    methods: {
        handleDrag() {
            // get center and zoom level, store in localstorage
            let center = {
                lat: this.map.getCenter().lat(),
                lng: this.map.getCenter().lng()
            };
            let zoom = this.map.getZoom();
            localStorage.center = JSON.stringify(center);
            localStorage.zoom = zoom;
        },
        getPosition(pothole) {
            return {
                lat: parseFloat(pothole.latitude),
                lng: parseFloat(pothole.longitude)
            }
        },
        handleMarkerClicked(id) {
            this.$store.dispatch('setActivePothole', id);
            this.$store.dispatch('unsetMenuSelection')
            this.$store.dispatch('setMenuSelection', id)
            this.map.setZoom(14);
            this.map.setCenter(this.getPosition(this.activePothole));
        },
        handleInfoWindowClose() {
            this.$store.dispatch('unsetMenuSelection')
            this.$store.dispatch('unsetActivePothole');
        },
        handleMapClick(e) {
            //console.log(`lat: ${e.latLng.lat().toFixed(5)} lng: ${e.latLng.lng().toFixed(5)}`);
            this.mapClick.latitude = e.latLng.lat().toFixed(5);
            this.mapClick.longitude = e.latLng.lng().toFixed(5);
            this.$store.dispatch('setMapClick',this.mapClick);
        },
        deletePothole() {
            const potholeId = this.activePothole.potholeId;
            this.$store.dispatch('deletePothole', potholeId)
                .then(response => {
                    if(response.status === 200){
                        console.log('it worked');
                        this.endDialog();
                    }
                })
                .catch(err => {
                    console.log(err)
                });
        },
        endDialog(){
        this.dialog=false
        this.$router.go();
      },
        runTest(){
            // this.$store.dispatch('fetchComments', this.activePothole.potholeId);
        },
        // addMarker: function(lat, lng) {
        //     let marker = new google.maps.Marker({
        //         position: new google.maps.LatLng(lat, lng),
        //         draggable: true,
        //     });
        //     marker.setMap(this.map);
        // },
    },
    created() {
        // does the user have a saved center? use it instead of the default
        if(localStorage.center) {
            this.myCoordinates = JSON.parse(localStorage.center);
        } else {
            // get user's coordinates from browser request
            this.$getLocation({})
                .then(coordinates => {
                    this.myCoordinates = coordinates;
                })
                .catch(error => alert(error));
        }
        // does the user have a saved zoom? use it instead of the default
        if(localStorage.zoom) {
            this.zoom = parseInt(localStorage.zoom);
        }
    },
    mounted() {
        if(this.hasMenuSelection) {
            this.isInfoWindowOpened = true;
        }
        // add the map to a data object
        this.$refs.mapRef.$mapPromise.then(map => this.map = map);
    },
}
</script>
<style>
    .gmap {
        /* width: 500px; */
        height: 89vh;
        margin: 5px auto;
    }
    @media screen and (max-width: 375px){
        .gmap {
            height: 69vh;
            border-radius: 5px;
        }
    }
    .info-window {
        padding: 0.5em;
    }
    .info-window h2 {
        padding-bottom: 0.5em;
    }
    .info-window p {
        margin: 0;
    }
</style>