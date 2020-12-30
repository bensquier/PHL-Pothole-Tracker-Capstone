import Vue from 'vue';
import Vuetify from 'vuetify/lib/framework';

Vue.use(Vuetify);

export default new Vuetify({
  theme: {
    themes: {
      light: {
        primary: '#3f51b5',
        secondary: '#03a9f4',
        accent: '#ff5722',
        error: '#f44336',
        warning: '#ff9800',
        info: '#607d8b',
        success: '#4caf50'
      },
      dark: {
        primary: '#3f51b5',
        secondary: '#03a9f4',
        accent: '#ff5722',
        error: '#f44336',
        warning: '#ff9800',
        info: '#607d8b',
        success: '#4caf50'
      }
    }
  },
});
