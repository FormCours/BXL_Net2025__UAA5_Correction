import axios from 'axios';

export async function getListingFormation() {
    const { data } = await axios.get('/training', {
        baseURL: import.meta.env.VITE_API_URL
    });

    return {
        success: true,
        data
    };
}

export async function getFormationById(id) {
    let response;

    try {
        response = await axios.get(`/training/${id}` , {
            baseURL: import.meta.env.VITE_API_URL
        });
    }
    catch (error) {
        return {
            success: false,
            error: error.response.data?.detail ?? error.message
        }
    }

    return {
        success: true,
        data : response.data
    };
}

export async function sendIncriptionToFormation(id, registerData) {
    let response;

    try {
        response = await axios.post(`/training/${id}/participant`, registerData, {
            baseURL: import.meta.env.VITE_API_URL
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
