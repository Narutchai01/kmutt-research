import Layout from "../../components/Layout";
import { useNavigate } from "react-router-dom";

const DashboardPage = () => {
  const navigate = useNavigate();
 
if (localStorage.getItem("authen") === "false"){
  navigate("/"); 
}


  return (
    <>
      <Layout>
        <h1>Dashboard</h1>
      </Layout>
    </>
  );
};

export default DashboardPage;
