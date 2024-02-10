import Layout from "../../components/Layout"
import { useParams } from "react-router-dom"
import { axiosInstance } from "../../lib/axios";
import { useEffect, useState } from "react";
import { CarInfoData } from "../../interface/interface";
import DataInfoCar from "./components/DataInfoCar";


const CarPageByCarID = () => {

    const { id ,province} = useParams()
    const [data, setData] = useState([]);


    const getDataCar = async () => {
      try {
        axiosInstance.get(`/api/cars/getCarByID?CarID=${id}&Province=${province}`).then((res) => {
          setData(res.data);
        });
      } catch (error) {
        console.log(error);
        
      }
    };

    useEffect(() => {
      getDataCar();
    }, []);

    console.log(data);
    

  return (
    <>
        <Layout >
         <div className="py-5 container mx-auto px-2 flex flex-col gap-y-10">
          <h1 className="text-5xl font-bold">Car{id}</h1>
          <div>
            {data.map((item: CarInfoData ,index :number) => (
              <DataInfoCar key={index}  data={item} />
            ))}
          </div>
        </div>
        </Layout>
    </>
  )
}

export default CarPageByCarID
