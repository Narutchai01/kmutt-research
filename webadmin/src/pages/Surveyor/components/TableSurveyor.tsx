import { useState, useEffect } from "react";
import { axiosInstance } from "../../../lib/axios";
import PropDataSurveyor from "./PropDataSurveyor";
import { SurveyData } from "../../../interface/interface";
import { useNavigate } from "react-router-dom";

const TableSurveyor = () => {
  const [surveyor, setSurveyor] = useState([]);
  const navigate = useNavigate();

const getSurveyor = async () => {
  try {
    const res = await axiosInstance.get("/api/admin/getsurveyor");
    setSurveyor(res.data);
  } catch (error) { 
    navigate('/');
  }
};

useEffect(() => {
  getSurveyor();
});

  


  return (
    <>
      <table className="w-full">
        <thead className="w-full bg-[#F0F0F0] h-11">
          <tr className="w-full">
            <th className="">ID</th>
            <th className="text-left">Name</th>
            <th className="text-left">Email</th>
            <th className=""></th>
          </tr>
        </thead>
        <tbody className="w-full h-auto">
          {
            surveyor.map((data : SurveyData , index : number) => (
              <PropDataSurveyor key={index} data={data} />
            ))
          }
        </tbody>
      </table>
    </>
  );
};

export default TableSurveyor;
