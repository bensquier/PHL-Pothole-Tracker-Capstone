import axios from 'axios';

export default{

    createClaim(newClaim){
        return axios.post('/claims', newClaim);
    }
}
