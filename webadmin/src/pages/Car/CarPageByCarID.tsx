import Layout from "../../components/Layout"
import { useParams } from "react-router-dom"


const CarPageByCarID = () => {

    const { id } = useParams()

  return (
    <>
        <Layout >
         <div className="py-5 container mx-auto px-2 flex flex-col gap-y-10">
          <h1 className="text-5xl font-bold">Car{id}</h1>
          <div>
            
          </div>
        </div>
        </Layout>
    </>
  )
}

export default CarPageByCarID
