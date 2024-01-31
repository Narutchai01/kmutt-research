import Layout from "../../components/Layout";
import { useState, useEffect } from "react";
import { axiosInstance } from "../../lib/axios";
import { AdminData } from "../../interface/interface";
import PropAdminInfo from "./components/PropAdminInfo";

const AdminInfo = () => {
    const [data, setData] = useState<AdminData[]>([]);
  
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
    console.log(data);
    
    return (
        <>
            <Layout>
            <div className="py-5 container mx-auto px-2 flex flex-col gap-y-10">
                <h1 className="text-5xl font-bold">Admin Information</h1>
                <>
                {data.map((items: AdminData , index:number) => (
                    <PropAdminInfo key={index} data={items} />
                ))}
                </>
            </div>
            </Layout>
        </>
    )
}
export default AdminInfo;