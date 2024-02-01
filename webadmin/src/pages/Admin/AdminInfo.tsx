import Layout from "../../components/Layout";
import { useState, useEffect } from "react";
import { axiosInstance } from "../../lib/axios";
import { AdminData } from "../../interface/interface";
import PropAdminInfo from "./components/PropAdminInfo";

const AdminInfo = () => {
  const [data, setData] = useState<AdminData>({
    AdminID: 0,
    First_name: "",
    Last_name: "",
    Email: "",
    Password: "",
    Image: "",
    Phone_number: "",
    Birth_date: "",
  });

  const getAdmin = async () => {
    try {
      const response = await axiosInstance.get(`/api/admin/getadmin`);
      setData(response.data);
    } catch (err) {
      console.error(err);
    }
  };

  useEffect(() => {
    getAdmin();
  }, []);

  return (
    <>
      <Layout>
        <div className="py-5 container mx-auto px-2 flex flex-col gap-y-10">
          <h1 className="text-5xl font-bold">Admin Information</h1>
          <PropAdminInfo data={data} />
        </div>
      </Layout>
    </>
  );
};
export default AdminInfo;
