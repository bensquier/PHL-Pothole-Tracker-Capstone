import axios from 'axios';

export default{
    getComments(potholeId){
        return axios.get(`/comments/pothole/${potholeId}`)
    }
}