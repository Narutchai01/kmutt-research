import { useState, useEffect } from "react";
import { InsuranceData } from "../../../interface/interface";
import { axiosInstance } from "../../../lib/axios";
import PropInsurance from "./PropInsurance";
import { useNavigate } from "react-router-dom";


const TableInsurance = () => {
  const [dataInsurance, setDataInsurance] = useState([]);

  const navigate = useNavigate();
  const getDataInsurance = async () => {
    try {
      const res = await axiosInstance.get("/api/admin/getinsurance");
      setDataInsurance(res.data);
    } catch (error) {
      navigate("/");
      console.log(error);
    }
  };

  useEffect(() => {
    getDataInsurance();
  },);

  console.log(dataInsurance);

  return (
    <>
      <table className="w-full">
        <thead className="w-full bg-[#F0F0F0] h-11">
          <tr className="w-full">
            <th className="">Policy number</th>
            <th className="text-left">Customer</th>
            <th className="text-left">Policy type</th>
            <th className="text-left">Start date</th>
            <th className="text-left">End date</th>
            <th className=""></th>
          </tr>
        </thead>
        <tbody className="w-full h-auto">
          {dataInsurance.map((data: InsuranceData, index: number) => (
            <PropInsurance key={index} data={data} />
          ))}
        </tbody>
      </table>
    </>
  );
};

export default TableInsurance;
