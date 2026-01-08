import useSWR from 'swr'
import { getFormationById } from '../../services/formation.service'

const fetcher = (id) => {
    return getFormationById(id).then(res => {
        if (!res.success)
            throw new Error(res.error);

        return res.data;
    })
}

export default function FormationDetail({ id }) {

    // Charger les données avec une requete
    const { isLoading, data, error } = useSWR(`training-${id}`, () => fetcher(id));

    return (
        <div>
            {isLoading ? (
                <p>Chargement en cours...</p>
            ) : data ? (
                <>
                    <p>{data.formation} - {data.location}</p>
                    <img src={import.meta.env.VITE_IMG_URL + data.imageUrl} alt={'Image de ' + data.formation} />
                </>
            ) : error && (
                <p>Une erreur est survenu lors du chargement des données !</p>
            )}
        </div>
    )
}