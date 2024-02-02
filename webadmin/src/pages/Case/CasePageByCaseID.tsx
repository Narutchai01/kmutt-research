import Layout from '../../components/Layout'
import { useParams } from "react-router-dom";
import { useState, useEffect } from "react";
import { axiosInstance } from "../../lib/axios";
import { CaseData } from "../../interface/interface";
import PropCaseByID from './components/PropCaseByID';

const CasePageByCaseID = () => {
  const { caseID } = useParams<{ caseID: string }>()
  const { id } = useParams<{ id: string }>();
  const [ data, setData] = useState([]);
  const getSurveyorByID = async () => {
    try {
      axiosInstance.get(`/api/admin/getCaseBySurveyorID/${id}`).then((res) => {
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
    <h1 className="text-5xl font-bold">Case {caseID}</h1>
    {data.map((item: CaseData, index: number) => (
            <PropCaseByID key={index} data={item} />
          ))}
    </div>
    </Layout>
   </> 
  )
}

export default CasePageByCaseID
