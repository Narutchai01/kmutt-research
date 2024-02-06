import { useParams } from "react-router-dom";
import { useState, useEffect } from "react";
import { axiosInstance } from "../../../lib/axios";

import { CustomerCarData } from "../../../interface/interface";
import PropDataCarbyCustomer from "./PropDataCarbyCustomer";

const TableDataCarByCustomer = () => {
    const { id } = useParams<{ id: string }>();
    const [data, setData] = useState([]);

    const getCarByCustomer = async () => {
        try {
            axiosInstance.get(`/api/admin/getCaseBySurveyorID/${id}`).then((res) => {
                setData(res.data);
            });
        } catch (err) {
            console.log(err);
        }
    };

    useEffect(() => {
        getCarByCustomer();
    }, []);



  return (
    <>
      <table className="w-full">
        <thead className="w-full bg-[#F0F0F0] h-11">
          <tr className="w-full">
            <th className="">Car ID</th>
            <th className="text-left">Brand</th>
            <th className="text-left">Model</th>
            <th className=" text-left">Color</th>
            <th className=" text-left">Province</th>
            <th className=""></th>
          </tr>
        </thead>
        <tbody className="w-full h-auto">
          {data.map((data : CustomerCarData) => (
            <PropDataCarbyCustomer data={data} />
          ))}
        </tbody>
      </table>
    </>
  );
};



export default TableDataCarByCustomer;
