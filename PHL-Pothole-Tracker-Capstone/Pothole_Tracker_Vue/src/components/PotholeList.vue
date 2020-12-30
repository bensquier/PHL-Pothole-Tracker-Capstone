<template>
<div>
    
  <v-card-text class="px-1 py-0">
    <v-chip-group
      active-class="info lighten-2 white--text"
      center-active
      mandatory
    >
      <v-chip
        v-for="(filter, i) in filters"
        :key="i"
        @click="setCurrentFilter(filter)"
      >
        {{ filter }}
      </v-chip>
      
    </v-chip-group>
  </v-card-text>

  <v-list color="transparent"
    :style="setHeight"
    class="overflow-y-auto"
    subheader
    two-line
    >
    <!-- <v-subheader>Potholes Uninspected: {{ this.notInspectedPotholeCount }}</v-subheader> -->
    <v-list-item-group
      v-model="menuSelectionIndex"
      active-class="border"
      color="blue-grey"
    >
      <v-list-item
        v-for="pothole in listItems"
        :key="pothole.id"
        @click="setActivePothole(pothole.id)"
      >
        <v-list-item-icon>
          <v-icon v-text="pothole.icon"
            :color="pothole.color"></v-icon>
        </v-list-item-icon>

        <v-list-item-content>
          <v-list-item-title v-text="pothole.text"></v-list-item-title>
          <v-list-item-subtitle>
            Severity: {{pothole.severity}} 
          </v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
      
    </v-list-item-group>
    <v-subheader>End of list</v-subheader>
  </v-list>
</div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  components: {
    
  },
  data() {
    return {
       filters: [
        'All',
        'Reported',
        'Inspected',
        'Completed',
      ],
    }
  },

  props: {
    setHeight: {
      type: String,
      default: '',
    } 
  },
  
  computed: {
    ...mapGetters({
      potholes: 'allPotholes',
      currentUserId: 'userId',
      activePothole: 'activePothole',
      currentFilter: 'currentFilter'
    }),
    menuSelectionIndex: {
      get() {
        return this.$store.getters.menuSelectionIndex;
      },
      set(potholeId) {
        this.$store.dispatch('setMenuSelection', potholeId);
      }
    },
    filteredPotholes() {
      if (this.currentFilter == 'All') {
        return this.potholes;
      }
      return this.potholes
        .filter( pothole => pothole.status === this.currentFilter);
    },
    listItems() {
      let list = [];
      this.filteredPotholes.forEach(pothole => {
        switch(pothole.severity) {
          case 'Not Inspected':
            list = list.concat([{
              id: `${pothole.potholeId}`,
              icon: 'mdi-new-box',
              text: `New Pothole on ${pothole.roadName}`,
              color: 'info',
              roadName: `${pothole.roadName}`,
              severity: `${pothole.severity}`,
            }]);
            break;
          case 'Low':
            list = list.concat([{
              id: `${pothole.potholeId}`,
              icon: 'mdi-timeline-alert-outline',
              text: `Pothole on ${pothole.roadName}`,
              color: 'yellow darken-1',
              roadName: `${pothole.roadName}`,
              severity: `${pothole.severity}`,
            }]);
            break;
          case 'Medium':
            list = list.concat([{
              id: `${pothole.potholeId}`,
              icon: 'mdi-timeline-alert-outline',
              text: `Pothole on ${pothole.roadName}`,
              color: 'warning',
              roadName: `${pothole.roadName}`,
              severity: `${pothole.severity}`,
            }]);
            break;
          case 'High':
            list = list.concat([{
              id: `${pothole.potholeId}`,
              icon: 'mdi-alert-octagram',
              text: `Large Pothole on ${pothole.roadName}`,
              color: 'accent',
              roadName: `${pothole.roadName}`,
              severity: `${pothole.severity}`,
            }]);
            break;
        }
        return list;
      });
      list.sort((a,b) => {
          if(b.severity == 'High'){
              return -1;
            }
          if(b.severity == 'Medium'){
              return -1;
            }
          if(b.severity == 'Low'){
              return -1;
            }
          return 0;
        })
      return list;
    },
  },

  methods: {
    setActivePothole(id) {
      this.$store.dispatch('setActivePothole', id);
    },
    setCurrentFilter(filter) {
      this.$store.dispatch('setCurrentFilter', filter)
    },
  },
}
</script>