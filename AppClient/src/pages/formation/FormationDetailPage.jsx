import { useParams } from 'react-router'
import FormationDetail from '../../features/Formation/FormationDetail';
import FormationInscriptionForm from '../../features/Formation/FormationInscriptionForm';

export default function FormationDetailPage() {

    const { id } = useParams();

    return (
        <>
            <h2>Detail de la formation avec l'id {id}</h2>
            <FormationDetail id={id} />
            <FormationInscriptionForm id={id} />
        </>
    )
}