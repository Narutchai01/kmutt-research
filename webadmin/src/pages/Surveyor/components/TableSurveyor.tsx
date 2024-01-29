import { useState, useEffect } from "react";
import { axiosInstance } from "../../../lib/axios";
import PropDataSurveyor from "./PropDataSurveyor";
import { SurveyData } from "../../../interface/interface";

const TableSurveyor = () => {
  const [surveyor, setSurveyor] = useState([]);

  const getSurveyor = async () => {
    try {
      axiosInstance.get("/api/surveyor/getsurveyor").then((res) => {
        setSurveyor(res.data);
      });
    } catch (error) {
      console.log(error);
    }
  };

  useEffect(() => {
    getSurveyor();
  }, [surveyor]);

  


  return (
    <>
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
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
