<template>
  <div>
    <v-subheader>Please sign in to report a pothole</v-subheader>
    <pothole-list :setHeight="$vuetify.breakpoint.smAndUp ? 'max-height: 73vh': 'max-height: 60vh'"/>
  </div>
</template>

<script>
import PotholeList from './PotholeList.vue'
export default {
  components: { PotholeList },
  name: 'anon-dash',
  data: () => ({
  }),
  props: {
  },
  computed: {
  },
  methods: {
  },
}
</script>