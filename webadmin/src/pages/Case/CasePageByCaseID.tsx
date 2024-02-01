import Layout from '../../components/Layout'
import { useParams } from 'react-router-dom'

const CasePageByCaseID = () => {
    const { caseID } = useParams<{ caseID: string }>()
  return (
   <>
   <Layout>
    <div>
    <h1>{caseID}</h1>
    </div>
    </Layout>
   </> 
  )
}

export default CasePageByCaseID
