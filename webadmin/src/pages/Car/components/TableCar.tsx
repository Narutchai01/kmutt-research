import PropCar from "./PropCar";
import { useState, useEffect } from "react";
import { axiosInstance } from "../../../lib/axios";
import { CarData } from "../../../interface/interface";
import { useNavigate } from "react-router-dom";

const TableCar = () => {
  const [dataCar, setDataCar] = useState([]);
  const navigator = useNavigate();

  const getData = async () => {
    try {
      axiosInstance.get(`/api/admin/getCars`).then((res) => {
        setDataCar(res.data);
      });
    } catch (error) {
      navigator("/");
      console.log(error);
    }
  };

  useEffect(() => {
    getData();
  }); // Update useEffect to have an empty dependency array

  console.log(dataCar);
  

  return (
    <>
      <table className="w-full">
        <thead className="bg-[#F0F0F0] h-11">
          <tr>
            <th>Car ID</th>
            <th className=" text-left">Province</th>
            <th className="text-left">Owner</th>
            <th className="text-left">Policy type</th>
            <th></th>
          </tr>
        </thead>
        <tbody className="w-full">
          {dataCar.map((item: CarData, index: number) => (
            <PropCar key={index} data={item} />
          ))}
        </tbody>
      </table>
    </>
  );
};

export default TableCar;
