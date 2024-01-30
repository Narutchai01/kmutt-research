import acsLogo from "../../assets/img/acslogo2.png";
import { LoginData } from "../../interface/interface";
import { useState} from "react";
import { useNavigate } from "react-router-dom";
import {axiosInstance} from "../../lib/axios"

const LoginPage = () => {
  const navigate = useNavigate();

  localStorage.setItem("authen", "false");

  const [loginData, setLoginData] = useState<LoginData>({
    Email: "",
    Password: "",
  });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setLoginData((prev) => ({
      ...prev,
      [name]: value,
    }));
  };

const handleSubmit = (e: React.FormEvent) => {
  try {
    e.preventDefault(); 
    axiosInstance.post("/api/admin/loginadmin", loginData).then(() => {
      localStorage.setItem("authen", "true");
      navigate("/dashboards");
    });
  } catch (error) {
    console.log(error);
  }
};
  
  return (
    <>
      <div className="h-screen flex justify-center items-center">
        <div className="w-[539px]">
          <div className="w-ful rounded-xl shadow-2xl py-20">
            <div className="flex justify-center">
              <img src={acsLogo} alt="acs logo" />
            </div>
            <form className="mx-auto px-20 flex flex-col gap-10" onSubmit={handleSubmit}>
              <div className="flex flex-col gap-2">
                <label htmlFor="email">Email address</label>
                <input type="email" className="border-[1px] border-primary py-2 rounded-xl" name="Email" onChange={handleChange} />
              </div>
              <div className="flex flex-col gap-2">
                <label htmlFor="email">Enter your password</label>
                <input type="password" className="border-[1px] border-primary py-2 rounded-xl" name="Password" onChange={handleChange}/>
              </div>
              <div className="flex justify-center bg-primary py-3 text-xl text-white rounded-xl">
                <button type="submit">Sign in</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </>
  );
};

export default LoginPage;
