
<template>
  
          <v-card-text class="px-1 py-0">
            <v-chip-group
              mandatory
              active-class="info--text"
              center-active
            >
              <v-chip
                v-for="(filter, i) in filters"
                :key="i"
                @click="setCurrentList(filter)"
              >
                {{ filter }}
              </v-chip>
              <v-chip
              >Reported
              </v-chip>
            </v-chip-group>
          </v-card-text>

</template>

<script>
export default {
  
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

}
</script>