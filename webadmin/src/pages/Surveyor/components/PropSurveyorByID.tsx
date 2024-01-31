import { SurveyorByIDData } from "../../../interface/interface";
import PropType from "prop-types";

const PropSurveyorByID = ({ data }: { data: SurveyorByIDData }) => {


    const Birtth_date = new Date(data.Birth_date).toISOString().slice(0,10).split("-").reverse().join("/");

  return (
    <>
      <div className="flex flex-col gap-10">
        <div className=" grid grid-cols-[1fr_3fr_3fr] items-center">
          <div className=" w-24 h-24">
            <img
              src={data.Image}
              alt=""
              className="w-full h-full rounded-full"
            />
          </div>
          <div>
            <h1 className="text-2xl font-bold">Firstname</h1>
            <p className="text-sm">{data.First_name}</p>
          </div>
          <div>
            <h1 className="text-2xl font-bold">Lastname</h1>
            <p className="text-sm">{data.Last_name}</p>
          </div>
        </div>
        <div className="grid grid-cols-2">
          <div className="">
            <h1 className="text-2xl font-bold">Surveyor ID </h1>
            <p className="text-sm">{data.SurveyorID.toString().padStart(4,"0")}</p>
          </div>
          <div>
            <h1 className="text-2xl font-bold">Birthday (dd/mm/yy)</h1>
            <p className="text-sm">{Birtth_date}</p>
          </div>
        </div>
        <div className="grid grid-cols-2">
          <div className="">
            <h1 className="text-2xl font-bold">Telephone</h1>
            <p className="text-sm">{data.Phone_number}</p>
          </div>
          <div>
            <h1 className="text-2xl font-bold">Email</h1>
            <p className="text-sm">{data.Email}</p>
          </div>
        </div>
      </div>
    </>
  );
};


PropSurveyorByID.prototype = {
    data: PropType.object.isRequired,
};

export default PropSurveyorByID;
