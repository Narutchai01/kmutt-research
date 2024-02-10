import Layout from "../../components/Layout";
import { useParams } from "react-router-dom";
import { useState, useEffect } from "react";
import { axiosInstance } from "../../lib/axios";
import PropCaseByID from "./components/PropCaseByID";
import { CaseData } from "../../interface/interface";

const CasePageByCaseID = () => {
  const { caseID } = useParams<{ caseID: string }>();
  const [data, setData] = useState([]);
  const getCaseByID = async () => {
    try {
      axiosInstance.get(`/api/admin/getCaseByCaseID/${caseID}`).then((res) => {
        setData(res.data);
      });
    } catch (error) {
      console.log(error);
    }
  };
  useEffect(() => {
    getCaseByID();
  }, []);


  console.log(data);

  return (
    <>
      <Layout>
        <div className="py-5 container mx-auto px-2 flex flex-col gap-y-10">
          <h1 className="text-5xl font-bold">Case</h1>
          {data.map((data: CaseData) => (
            <PropCaseByID data={data} key={data.CaseID} />
          ))}
        </div>
      </Layout>
    </>
  );
};

export default CasePageByCaseID;
