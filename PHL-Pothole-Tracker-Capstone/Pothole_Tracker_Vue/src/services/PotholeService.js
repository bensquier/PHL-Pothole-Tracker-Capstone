import axios from 'axios';

export default {

    getPotholes() {
        return axios.get('/potholes')
    },
    sendReport(report){
        return axios.post('/potholes',report)
    },
    updatePothole(pothole) {
        return axios.put(`/potholes/${pothole.potholeId}`, pothole);
    },
    deletePothole(potholeId) {
        return axios.delete(`/potholes/${potholeId}`);
    }
}