import PropType from "prop-types";
import { InsuranceData } from "../../../interface/interface";
import { useNavigate } from "react-router-dom";

const PropInsurance = ({ data }: { data: InsuranceData }) => {
  const navigate = useNavigate();
  const startdate = new Date(data.Start_date).toISOString().split("T")[0];
  const enddate = new Date(data.End_date).toISOString().split("T")[0];

  return (
    <>
      <tr>
        <td className="text-center">
          <h1>{data.Policy_number}</h1>
        </td>
        <td className="">
          <h1>{data.CustomerID.toString().padStart(4,"0")}</h1>
        </td>
        <td className="text-left">
          <h1>{data.Policy_type}</h1>
        </td>
        <td className="text-left">
          <h1>{startdate}</h1>
        </td>
        <td className="text-left">{enddate}</td>
        <td className="text-right">
          <div className="flex justify-end gap-2">
            <div className="border-primary border-[1px] flex justify-center px-5 py-2 rounded-lg font-bold hover:bg-primary hover:text-white" 
              onClick={() => navigate(`/CarPage/${data.CarID}/${data.Province}`)}
            >
              <button>View</button>
            </div>
            <div className="border-primary border-[1px] flex justify-center px-3 py-2 rounded-lg font-bold hover:bg-primary hover:text-white">
              <button>Delete</button>
            </div>
          </div>
        </td>
      </tr>
    </>
  );
};

PropInsurance.propTypes = {
  data: PropType.object.isRequired,
};

export default PropInsurance;
