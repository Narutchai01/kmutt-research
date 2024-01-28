import TitleProfile from "./TitleProfile";
import { NavLink } from "react-router-dom";
import { IoIosArrowForward } from "react-icons/io";
import { PiFolderUser } from "react-icons/pi";

const Navbar = () => {
  const data = {
    name: "nar chaif",
    imageURL: "https://avatars.githubusercontent.com/u/25199472?v=4",
  };

  return (
    <>
      <div className="border-r-2 border-slate-950 h-auto min-h-screen">
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
                    <div className="flex items-center gap-1">
                      <IoIosArrowForward />
                      <PiFolderUser />
                      <h1>Data</h1>
                    </div>
                  </div>
                  <ul className="px-10 py-2">
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
                    <div className="flex items-center">
                      <IoIosArrowForward />
                      <PiFolderUser />
                      <h1>Account</h1>
                    </div>
                  </div>
                  <ul className="px-8 py-2">
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
