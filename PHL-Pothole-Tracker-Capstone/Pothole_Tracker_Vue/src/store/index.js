import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import potholeService from '../services/PotholeService'
import authService from '../services/AuthService'
import commentService from '../services/CommentService'
import claimService from '../services/ClaimService'

//import authService from "../services/AuthService";
Vue.use(Vuex)

/*
 * The authorization header is set for axios when you login but what happens when you come back or
 * the page is refreshed. When that happens you need to check for the token in local storage and if it
 * exists you should set the header so that it will be attached to each request
 */
const currentToken = localStorage.getItem('token')
const currentUser = JSON.parse(localStorage.getItem('user'));

if(currentToken != null) {
  axios.defaults.headers.common['Authorization'] = `Bearer ${currentToken}`;
}

export default new Vuex.Store({
  state: {
    isLoading: false,
    potholes: [],
    token: currentToken || null,
    user: currentUser || {},
    activePothole: {},
    hasMenuSelection: false,
    menuSelectionIndex: null,
    currentFilter: 'All',
    reportMode: false,
    mapClick: {
      latitude: 0,
      longitude: 0
    },
    isInfoWindowOpen: false,
    potholeComments:  [],
    
  },

  mutations: {
    START_LOADING(state) {
      state.isLoading = true;
    },
    STOP_LOADING(state) {
      state.isLoading = false;
    },
    SET_AUTH_TOKEN(state, token) {
      state.token = token;
      localStorage.setItem('token', token);
      axios.defaults.headers.common['Authorization'] = `Bearer ${token}`
    },
    SET_USER(state, user) {
      state.user = user;
      localStorage.setItem('user',JSON.stringify(user));
    },
    LOGOUT(state) {
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      state.token = '';
      state.user = {};
      axios.defaults.headers.common = {};
    },
    SET_POTHOLES(state, data) {
      state.potholes = data;
    },
    SET_ACTIVE_POTHOLE(state, potholeId) {
      for(let i = 0; i<state.potholes.length; i++) {
        if(state.potholes[i].potholeId == potholeId) {
          state.activePothole = state.potholes[i]
        }
      }
    },
    UNSET_ACTIVE_POTHOLE(state) {
      state.activePothole = {};
    },
    SET_MENU_SELECTION(state, potholeId){
      const filteredList = state.potholes
        .filter( pothole => pothole.status == state.currentFilter);
      for(let i = 0; i<filteredList.length; i++) {
        if(state.filteredList[i].potholeId == potholeId) {
          state.menuSelectionIndex = i;
        }
      }
    },
    SET_CURRENT_FILTER(state, filter) {
      state.currentFilter = filter;
    },
    UNSET_MENU_SELECTION(state){
      state.menuSelectionIndex = null;
    },
    MENU_SELECTION_MADE(state) {
      state.hasMenuSelection = true;
    },
    MENU_SELECTION_REMOVED(state) {
      state.hasMenuSelection = false;
    },
    REPORT_MODE_ON(state) {
      state.reportMode = true;
    },
    REPORT_MODE_OFF(state) {
      state.reportMode = false;
    },
    SET_MAP_CLICK(state,mapClick) {
      state.mapClick = mapClick;
    },
    SET_POTHOLE_COMMENTS(state, comments){
      state.potholeComments = comments;
    },
    CLOSE_INFO_WINDOW(state) {
      state.isInfoWindowOpen = false;
    },
    OPEN_INFO_WINDOW(state) {
      state.isInfoWindowOpen = true;
    },
  },
  
  actions:  {
    // ////////////////// POTHOLE MANAGEMENT /////////////////
    fetchPotholes({commit}) {
      commit('START_LOADING');
      potholeService.getPotholes()
        .then(response => {
          commit('SET_POTHOLES', response.data);
        })
        .catch(error => alert(error));
        commit('STOP_LOADING');
    },
    updatePothole(context, pothole) {
      return new Promise((resolve, reject) => {
        potholeService.updatePothole(pothole)
          .then((response) => {
            resolve(response)
            console.log(response)
          })
          .catch(err => {
            console.log(err)
            reject(err)
          })
      });
    },
    deletePothole(context, potholeId) {
      return new Promise((resolve, reject) => {
        potholeService.deletePothole(potholeId)
          .then((response) => {
            resolve(response)
          })
          .catch(err => {
            console.log(err)
            reject(err)
          })
      });
    },
    // ///////////////// MAP MANAGEMENT /////////////////////
    setActivePothole({commit}, potholeId) {
      commit('SET_ACTIVE_POTHOLE', potholeId);
      commit("OPEN_INFO_WINDOW");
    },
    unsetActivePothole(context) {
      context.commit('UNSET_ACTIVE_POTHOLE');
      context.commit('CLOSE_INFO_WINDOW');
    },
    closeInfoWindow(context) {
      context.commit('CLOSE_INFO_WINDOW');
    },
    openInfoWindow(context) {
      context.commit('OPEN_INFO_WINDOW');
    },
    setMenuSelection({commit}, potholeId) {
      commit('SET_MENU_SELECTION', potholeId)
    },
    unsetMenuSelection(context) {
      context.commit('UNSET_MENU_SELECTION')
    },
    setCurrentFilter(context, filter) {
      context.commit('SET_CURRENT_FILTER', filter);
    },
    mapMarkerSelection({commit}, selection) {
      commit('SET_ACTIVE_POTHOLE', selection);
      commit('MENU_SELECTION_REMOVED');
    },
    setMapClick({commit},mapClick) {
      commit('SET_MAP_CLICK',mapClick);
    },
    // ////////////////////// REPORTING MANAGEMENT /////////////////
    setReportModeOn({commit}) {
      commit('REPORT_MODE_ON');
    },
    setReportModeOff({commit}) {
      commit('REPORT_MODE_OFF');
    },
    sendReport({commit},report){
      commit('START_LOADING');
      potholeService.sendReport(report);
      commit('STOP_LOADING');
    },

    // /////////////////// ACCOUNT MANAGEMENT /////////////////////
    authenticate(context, credentials) {

      return new Promise((resolve, reject) => {
        authService.login(credentials)
          .then(response => {
            const token = response.data.token;
            const user = response.data.user
            context.commit('SET_AUTH_TOKEN', token);
            context.commit('SET_USER', user);
            resolve(response)
          })
          .catch(error => {
            console.log(error);
            reject(error)
          })
      })
    },
    logout({commit}) {
      commit('LOGOUT');
    },
     // /////////////////// COMMENT MANAGEMENT /////////////////////
    fetchComments(context, potholeId){

      return new Promise((resolve, reject)=>{
        commentService.getComments(potholeId)
        .then(response=>{
          context.commit('SET_POTHOLE_COMMENTS', response.data);
          console.log(response)
          resolve(response)
        })
        .catch(error =>{
          console.log(error)
          reject(error)
        })
      })
    },
  
       // /////////////////// Claim MANAGEMENT /////////////////////
    sendClaim(context, newClaim){

      return new Promise((resolve, reject)=>{
        claimService.createClaim(newClaim)
          .then((response)=>{
            resolve(response)
          })
          .catch(err=>{
            console.log('error here?')
            console.log(newClaim)
            reject(err)
          })
      });
    },
  },
  getters: {
    // Potholes and filters
    allPotholes: (state) => {
      return state.potholes;
    },
    notInspectedPotholes: (state) => {
      return state.potholes
        .filter( pothole => pothole.severity === 'Not Inspected');
    },
    reportedPotholes: (state) => {
      return state.potholes
      .filter( pothole => pothole.status === 'Reported');
    },
    inspectedPotholes: (state) => {
      return state.potholes
      .filter( pothole => pothole.status === 'Inspected');
    },
    completedPotholes: (state) => {
      return state.potholes
      .filter( pothole => pothole.status === 'Completed');
    },
    notInspectedPotholeCount: (state, getters) => {
      return getters.notInspectedPotholes.length;
    },
    activePothole: (state) => {
      return state.activePothole;
    },
    activePotholeIndex: (state) => {
      return state.potholes.indexOf(state.activePothole);
    },
    menuSelectionIndex: (state) => {
      return state.menuSelectionIndex;
    },
    hasMenuSelection: (state) => {
      return state.hasMenuSelection;
    },
    currentFilter: (state) => {
      return state.currentFilter;
    },
    reportMode: (state) => {
      return state.reportMode;
    },
    mapClick: (state) => {
      return state.mapClick;
    },
    isInfoWindowOpen: (state) => {
      return state.isInfoWindowOpen;
    },
    potholeComments: (state) =>{
      return state.potholeComments;
    },
    // Login data
    isLoggedIn: state => !!state.token,
    authStatus: state => state.status,
    userId: state => state.user.id,
    username: state => state.user.username,
  },
})
