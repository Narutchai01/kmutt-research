import PropTypes from "prop-types";
import { CaseBySurveyorIDData } from "../../../interface/interface";

const PropDataCaseBySurveyorID = ({ data }: { data: CaseBySurveyorIDData }) => {


    const date = new Date(data.Date_opened).toLocaleDateString("en-GB");

  return (
    <>
      <tr className=" h-16 border-t-2">
        <td className="text-center">
          <h1>{data.CarID}</h1>
        </td>
        <td>
          <h1>{data.CaseID}</h1>
        </td>
        <td>
          <h1>{data.Status}</h1>
        </td>
        <td>
          <h1>{date}</h1>
        </td>
        <td className="pr-5">
          <div className="flex justify-end gap-2">
            <div className="border-primary border-[1px] flex justify-center px-5 py-2 rounded-lg font-bold hover:bg-primary hover:text-white">
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

PropDataCaseBySurveyorID.propTypes = {
  data: PropTypes.object,
};

export default PropDataCaseBySurveyorID;
