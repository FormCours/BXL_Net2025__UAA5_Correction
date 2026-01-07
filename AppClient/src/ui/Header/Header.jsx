import {  NavLink } from 'react-router';
import style from './Header.module.css';


export default function Header() {

    return (
        <header className={style.header}>
            <h1>Correction UAA5</h1>
            <nav>
                <ul>
                    <li>
                        <NavLink to='/'>Accueil</NavLink>
                    </li>
                    <li>
                        <NavLink to='/formation'>Formation</NavLink>
                    </li>
                    <li>
                        <NavLink to='/about'>À Propos</NavLink>
                    </li>
                    {/* <li>
                        <NavLink className={({isActive}) => isActive ? 'classname_active' : 'classname_default'}>...</NavLink>
                    </li> */}
                </ul>
            </nav>
        </header>
    )
}