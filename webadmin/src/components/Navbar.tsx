import TitleProfile from "./TitleProfile";
import { NavLink } from "react-router-dom";
import { IoIosArrowForward } from "react-icons/io";
import { PiFolderUser } from "react-icons/pi";
import { useState, useEffect } from "react";
import { axiosInstance } from "../lib/axios";
import { AdminData } from "../interface/interface";

const Navbar = () => {
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

  const [toggleData, setToggleData] = useState<boolean>(false);
  const [toggleAccount, setToggleAccount] = useState<boolean>(false);

  const getData = async () => {
    try {
      const res = await axiosInstance.get("/api/admin/getadmin");
      setData(res.data);
    } catch (error) {
      console.log(error);
    }
  };

  const CheckToggleData = () => {
    setToggleData(!toggleData);
  };
  const CheckToggleAccount = () => {
    setToggleAccount(!toggleAccount);
  };

  useEffect(() => {
    getData();
  }, []);

  return (
    <>
      <div className="border-r-2 h-auto min-h-screen">
        <div className="h-full p-6">
          <TitleProfile userData={data} />
          <ul className="py-10">
            <li>
              <div className="flex items-center">
                <h1 className="text-lg font-bold">Dashboard</h1>
              </div>
              <ul className="px-4 py-2">
                <li>
                  <NavLink
                    className="flex items-center space-x-4"
                    to="/dashboards"
                  >
                    Overview
                  </NavLink>
                </li>
              </ul>
            </li>
            <li>
              <div>
                <h1 className="text-lg font-bold">Pages</h1>
              </div>
              <ul className="px-4 py-2">
                <li>
                  <div>
                    <div
                      className="flex items-center gap-1"
                      onClick={CheckToggleData}
                    >
                      {toggleData ? (
                        <IoIosArrowForward onClick={CheckToggleData} />
                      ) : (
                        <IoIosArrowForward className="transform rotate-90" />
                      )}
                      <PiFolderUser />
                      <h1>Data</h1>
                    </div>
                  </div>
                  <ul className={toggleData ? "px-10 py-2" : "hidden"}>
                    <li>
                      <NavLink
                        className="flex items-center space-x-4"
                        to="/SurveyorPage"
                      >
                        Surveyor
                      </NavLink>
                    </li>
                    <li>
                      <NavLink
                        className="flex items-center space-x-4"
                        to="/dashboard/data"
                      >
                        Car
                      </NavLink>
                    </li>
                    <li>
                      <NavLink
                        className="flex items-center space-x-4"
                        to="/dashboard/data"
                      >
                        Insurance
                      </NavLink>
                    </li>
                    <li>
                      <NavLink
                        className="flex items-center space-x-4"
                        to="/dashboard/data"
                      >
                        Case
                      </NavLink>
                    </li>
                    <li>
                      <NavLink
                        className="flex items-center space-x-4"
                        to="/dashboard/data"
                      >
                        Customer
                      </NavLink>
                    </li>
                  </ul>
                </li>
                <li>
                  <div>
                    <div
                      className="flex items-center gap-1"
                      onClick={CheckToggleAccount}
                    >
                      {toggleAccount ? (
                        <IoIosArrowForward onClick={CheckToggleAccount} />
                      ) : (
                        <IoIosArrowForward className="transform rotate-90" />
                      )}
                      <PiFolderUser />
                      <h1>Account</h1>
                    </div>
                  </div>
                  <ul className={toggleAccount ? "px-10 py-2" : "hidden"}>
                    <li>
                      <NavLink
                        className="flex items-center space-x-4"
                        to="/dashboard/account"
                      >
                        Inforomation
                      </NavLink>
                    </li>
                  </ul>
                </li>
              </ul>
            </li>
          </ul>
        </div>
      </div>
    </>
  );
};

export default Navbar;
