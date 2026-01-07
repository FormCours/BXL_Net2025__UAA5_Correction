import { Link } from 'react-router';

export default function FormationList({ formationData }) {

    return (
        <ul>
            {formationData.map(data => (
                <FormationListItem key={data.id} {...data} />
            ))}
        </ul>
    )
}

function FormationListItem({ id, startDate, formation }) {
    return (
        <li>
            <p>{formation} • {startDate}</p>
            <p>Détail <Link to={`/formation/${id}`}>ici</Link> !</p>
        </li>
    )
}

