import { useState , useEffect } from "react";
import { axiosInstance } from "../../../lib/axios";
import { CaseData } from "../../../interface/interface";
import PropCase from "./PropCase";

const TableCase = () => {

    const [dataCase, setDataCase] = useState([])


    const getDataCase = async () => {
        try {
            const res = await axiosInstance.get("/api/cases/getCase");
            setDataCase(res.data);
        } catch (error) {
            console.log(error);
        }
    };

    useEffect(() => {
        getDataCase();
    }, []);


    console.log(dataCase);
    

  return (
    <>
      <table className="w-full">
        <thead className="bg-[#F0F0F0] h-11">
          <tr>
            <th>Car ID</th>
            <th className=" text-left">Case ID</th>
            <th className="text-left">Status</th>
            <th className="text-left">Date</th>
            <th></th>
          </tr>
        </thead>
        <tbody className="w-full">
        {dataCase.map((item: CaseData , index: number) => (
                <PropCase key={index} data={item} />
            ))}
        </tbody>
      </table>
    </>
  );
};

export default TableCase;
