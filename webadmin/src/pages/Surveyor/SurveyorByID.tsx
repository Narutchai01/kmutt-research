import Layout from "../../components/Layout";
import { useParams } from "react-router-dom";
import { useState, useEffect } from "react";
import { axiosInstance } from "../../lib/axios";

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

  console.log(data);

  return (
    <>
      <Layout>
        <h1>Surveror {id}</h1>
      </Layout>
    </>
  );
};

export default SurveyorByID;
