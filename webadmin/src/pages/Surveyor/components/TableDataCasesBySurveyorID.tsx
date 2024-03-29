import { useParams } from "react-router-dom";
import { useState, useEffect } from "react";
import { axiosInstance } from "../../../lib/axios";
import PropDataCaseBySurveyorID from "./PropDataCaseBySurveyorID";
import { CaseBySurveyorIDData } from "../../../interface/interface";

const TableDataCasesBySurveyorID = () => {
    const { id } = useParams<{ id: string }>();
    const [data, setData] = useState([]);

    const getCasesBySurveyorID = async () => {
        try {
            axiosInstance.get(`/api/admin/getCaseBySurveyorID/${id}`).then((res) => {
                setData(res.data);
            });
        } catch (err) {
            console.log(err);
        }
    };

    useEffect(() => {
        getCasesBySurveyorID();
    }, []);



  return (
    <>
      <table className="w-full">
        <thead className="w-full bg-[#F0F0F0] h-11">
          <tr className="w-full">
            <th className="">Car ID</th>
            <th className="text-left">Case ID</th>
            <th className="text-left">Status</th>
            <th className=" text-left">Date</th>
            <th className=""></th>
          </tr>
        </thead>
        <tbody className="w-full h-auto">
          {data.map((data : CaseBySurveyorIDData ,index : number) => (
            <PropDataCaseBySurveyorID data={data} key={index} />
          ))}
        </tbody>
      </table>
    </>
  );
};



export default TableDataCasesBySurveyorID;
