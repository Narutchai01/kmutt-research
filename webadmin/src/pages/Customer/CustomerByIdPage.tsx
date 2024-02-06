import Layout from "../../components/Layout";
import { useParams } from "react-router-dom";
import { useState, useEffect } from "react";
import { axiosInstance } from "../../lib/axios";
import { CustomerData } from "../../interface/interface";
import PropCustomer from "./components/PropCustomer";
import TableDataCarByCustomer from "./components/TableCustomerCar";


const CustomerByIdPage = () => {
  const { id } = useParams<{ id: string }>();

  const [data, setData] = useState([]);
  const getCustomerID = async () => {
    try {
      axiosInstance.get(`/api/admin/getcustomer/${id}`).then((res) => {
        setData(res.data);
      });
    } catch (err) {
      console.log(err);
    }
  };
  useEffect(() => {
    getCustomerID();
  }, []);

  return (
    <>
      <Layout>
        <div className="py-5 container mx-auto px-2 flex flex-col gap-y-10">
          <h1 className="text-5xl font-bold">Customer {id}</h1>
          
          {data.map((item: CustomerData, index: number) => (
            <PropCustomer key={index} data={item} />
          ))}
          <div className="w-full my-10 rounded-lg border-2 ">
             <TableDataCarByCustomer  /> 
          </div>
        </div>
      </Layout>
    </>
  );
};

export default CustomerByIdPage;
