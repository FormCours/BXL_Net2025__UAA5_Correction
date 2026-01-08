import { Route, Routes } from 'react-router'
import './App.css'
import HomePage from './pages/home/HomePage'
import FormationsPage from './pages/formation/FormationsPage'
import FormationDetailPage from './pages/formation/FormationDetailPage'
import AboutPage from './pages/about/AboutPage'
import NotFoundPage from './pages/error/NotFoundPage'
import Header from './ui/Header/Header'
import { Toaster } from 'sonner'

function App() {

  return (
    <>
      <Header />
      <main>
        <Toaster richColors />
        <Routes>
          <Route index element={<HomePage />} />
          <Route path='formation'>
            <Route index element={<FormationsPage />} />
            <Route path=':id' element={<FormationDetailPage />} />
          </Route>
          <Route path='about' element={<AboutPage />} />
          <Route path='*' element={<NotFoundPage />} />
        </Routes>
      </main>
    </>
  )
}

export default App
