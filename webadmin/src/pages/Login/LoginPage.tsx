import acsLogo from "../../assets/img/acslogo2.png";
import { LoginData } from "../../interface/interface";
import { useState } from "react";

const LoginPage = () => {

  const [loginData, setLoginData] = useState<LoginData>({
    email: "",
    password: "",
  });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setLoginData((prev) => ({
      ...prev,
      [name]: value,
    }));
  };
  
  console.log(loginData);
  




  return (
    <>
      <div className="h-screen flex justify-center items-center">
        <div className="w-[539px]">
          <div className="w-ful rounded-xl shadow-2xl py-20">
            <div className="flex justify-center">
              <img src={acsLogo} alt="acs logo" />
            </div>
            <form className="mx-auto px-20 flex flex-col gap-10">
              <div className="flex flex-col gap-2">
                <label htmlFor="email">Email address</label>
                <input type="email" className="border-[1px] border-primary py-2 rounded-xl" name="email" onChange={handleChange} />
              </div>
              <div className="flex flex-col gap-2">
                <label htmlFor="email">Enter your password</label>
                <input type="password" className="border-[1px] border-primary py-2 rounded-xl" name="password" onChange={handleChange}/>
              </div>
              <div className="flex justify-center bg-primary py-3 text-xl text-white rounded-xl">
                <button>Sign in</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </>
  );
};

export default LoginPage;
