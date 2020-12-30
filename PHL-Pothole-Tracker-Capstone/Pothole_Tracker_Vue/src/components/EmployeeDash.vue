<template>
<div>
  
  <employee-pothole-list :setHeight="$vuetify.breakpoint.smAndUp ? 'max-height: 79vh': 'max-height: 60vh'"/>
</div>
  
</template>

<script>
import EmployeePotholeList from './EmployeePotholeList.vue'

export default {
  name: 'employee-dash',
  components: {
    EmployeePotholeList,
  
  },
  data: () => ({

  }),
  computed: {
    potholes() {
      return this.$store.getters.allPotholes;
    },
  
  },


}
</script>