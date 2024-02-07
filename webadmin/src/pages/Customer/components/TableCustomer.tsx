import { useState,useEffect } from "react";
import { axiosInstance } from "../../../lib/axios";
import { CustomerData } from "../../../interface/interface";
import PropCustomer from "./PropCustomer";


const TableCustomer = () => {

    const [customer,setCustomer] = useState([])
    
    const getCustomer = async () => {
        try {
            axiosInstance.get(`/api/customer/getcustomer`).then((res) => {
                setCustomer(res.data)
            })
        } catch (error) {
            console.log(error);
            
        }
    }


    useEffect(() => {
        getCustomer()
    },[])

    console.log(customer);
    

  return (
    <>
      <table className="w-full">
        <thead className="bg-[#F0F0F0] h-11">
          <tr>
            <th className="text-center">Customer ID</th>
            <th>Owner</th>
            <th className=" text-left">Email</th>
            <th className="text-left">Line ID</th>
            <th className="text-left">Tel</th>
            <th className="text-left">Address</th>
            <th></th>
          </tr>
        </thead>
        <tbody className="w-full">
         {customer.map((item: CustomerData, index: number) => (
            <PropCustomer key={index} data={item} />
            ))}
        </tbody>
      </table>
    </>
  );
};

export default TableCustomer;
