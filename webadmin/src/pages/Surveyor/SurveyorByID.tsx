import Layout from "../../components/Layout";
import { useParams } from "react-router-dom";
import { useState, useEffect } from "react";
import { axiosInstance } from "../../lib/axios";
import PropSurveyorByID from "./components/PropSurveyorByID";
import { SurveyorByIDData } from "../../interface/interface";
import TableDataCasesBySurveyorID from "./components/TableDataCasesBySurveyorID";

const SurveyorByID = () => {
  const { id } = useParams<{ id: string }>();

  const [data, setData] = useState([]);
  const getSurveyorByID = async () => {
    try {
      axiosInstance.get(`/api/admin/getsurveyor/${id}`).then((res) => {
        setData(res.data);
      });
    } catch (err) {
      console.log(err);
    }
  };
  useEffect(() => {
    getSurveyorByID();
  }, []);

  return (
    <>
      <Layout>
        <div className="py-5 container mx-auto px-2 flex flex-col gap-y-10">
          <h1 className="text-5xl font-bold">Surveyor {id}</h1>
          {data.map((item: SurveyorByIDData, index: number) => (
            <PropSurveyorByID key={index} data={item} />
          ))}
          <div className="w-full my-10 rounded-lg border-2 ">
            <TableDataCasesBySurveyorID />
          </div>
        </div>
      </Layout>
    </>
  );
};

export default SurveyorByID;
