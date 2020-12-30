<template>
<div>
  <!-- <list-filters/> -->
  <pothole-list :setHeight="$vuetify.breakpoint.smAndUp ? 'max-height: 73vh': 'max-height: 60vh'"/>
  <v-divider class="my-0"></v-divider>
  <div class="text-center">
    <v-btn :to="{name: 'report'}"
      color="info lighten-2"
      rounded
      class="mr-6"
    >Report Pothole</v-btn>
    <v-btn :to="{name: 'claim'}"
      color="info lighten-2"
      rounded
      class="my-2"
    >File a Claim</v-btn>
  </div>
</div>
  
</template>

<script>
//import ListFilters from './ListFilters.vue'
import PotholeList from './PotholeList.vue'

export default {
  name: 'user-dash',
  components: {
    PotholeList,
    // ListFilters
  },
  data: () => ({

  }),

  methods: {
    makeReport(){
        this.$store.dispatch('setReportModeOn');
    }
  },
}
</script>