import { CaseData } from "../../../interface/interface";
import PropType from "prop-types";

const PropCaseByID = ({ data }: { data: CaseData }) => {

    const DateOpened = new Date(data.Date_opened).toLocaleDateString("en-GB");

  return (
    <>
      <div className="flex flex-col gap-10">
        <div className=" grid grid-cols-[1fr_3fr_3fr] items-center">
          <div>
            <h1 className="text-2xl font-bold">CaseID</h1>
            <p className="text-sm">{data.CaseID}</p>
          </div>
          <div>
            <h1 className="text-2xl font-bold">CarID</h1>
            <p className="text-sm">{data.CarID} {data.Province}</p>
          </div>
        </div>
        <div className="grid grid-cols-2">
          <div className="">
            <h1 className="text-2xl font-bold">Surveyor ID</h1>
            <p className="text-sm">{data.SurveyorID.toString().padStart(4,"0")}</p>
          </div>
          <div>
            <h1 className="text-2xl font-bold">Date opened (dd/mm/yy)</h1>
            <p className="text-sm">{DateOpened}</p>
          </div>
        </div>
        <div className="grid grid-cols-1">
          <div className="">
            <h1 className="text-2xl font-bold">Description</h1>
            <p className="text-sm">{data.Description}</p>
          </div>
        </div>
      </div>
    </>
  );
};

PropCaseByID.prototype = {
    data: PropType.object.isRequired,
};

export default PropCaseByID ;
