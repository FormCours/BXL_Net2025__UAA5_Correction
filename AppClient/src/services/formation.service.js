import axios from 'axios';

export async function getListingFormation() {
    const { data } = await axios.get('/training', {
        baseURL: 'https://localhost:7159/api'
    });

    return data;
}

export async function sendIncriptionToFormation(id, registerData) {
    const response = await axios.post(`/training/${id}/participant`, registerData, {
        baseURL: 'https://localhost:7159/api'
    });

    return response.data;
}