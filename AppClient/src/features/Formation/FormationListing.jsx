import { Suspense, use } from 'react';
import { getListingFormation } from '../../services/formation.service'
import FormationList from '../../components/FormationList/FormationList';

export default function FormationListing() {

    // ↓ Requete sous la forme de Promesse
    const promiseFormation = getListingFormation();

    // ↓ Le Suspense temporise l'affichage du composant "FormationListingContent" le temps de la promesse
    return (
        <Suspense fallback={<p>Loading</p>}>
            <FormationListingContent promise={promiseFormation} />
        </Suspense>
    )
}

function FormationListingContent({ promise }) {

    // ↓ Traiter les données de le promesse resolu !
    const result = use(promise);

    return (
        <FormationList formationData={result.data} />
    );
}
