import { useActionState } from 'react';
import { sendIncriptionToFormation } from '../../services/formation.service';
import { toast } from 'sonner';

export default function FormationInscriptionForm({ id }) {
    
    const registerAction = async (state, formData) => {

        // Données du formulaire
        const data = {
            email: formData.get('email'),
            newsletterAuthorized: formData.has('newsletterAuthorized')
        }

        // TODO Validation des données (zod)

        // Requete vers la WebAPI via les services
        const result = await sendIncriptionToFormation(id, data);

        // Affichage d'un toast
        toast('Votre inscription a bien été reçu. Merci ❤️‍🔥');

        return state;
    };

    const [state, registerSubmit, isPending] = useActionState(registerAction, null);

    return (
        <>
            <h3>Inscription à la formation</h3>
            <form action={registerSubmit}>
                <div>
                    <label htmlFor='reg-email'>Email : </label>
                    <input id='reg-email' name='email' type="email" required />
                </div>
                <div>
                    <label htmlFor='reg-newsletter'>Newsletter : </label>
                    <input id='reg-newsletter' name='newsletterAuthorized' type="checkbox" />
                </div>
                <div>
                    <button disabled={isPending}>S'inscrire</button>
                </div>
            </form>
        </>
    );
}
