import axios from 'axios';

export async function getListingFormation() {
    const { data } = await axios.get('/training', {
        baseURL: 'https://localhost:7159/api'
    });

    return {
        success: true,
        data
    };
}

export async function sendIncriptionToFormation(id, registerData) {
    let response;

    try {
        response = await axios.post(`/training/${id}/participant`, registerData, {
            baseURL: 'https://localhost:7159/api'
        });
    }
    catch (error) {
        const msg = error.response.data?.detail;
        
        return {
            success: false,
            error: msg ?? error.message
        }
    }

    return {
        success: true,
        data: response.data
    };
}
