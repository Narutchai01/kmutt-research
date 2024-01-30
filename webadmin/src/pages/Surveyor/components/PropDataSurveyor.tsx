import { SurveyData } from "../../../interface/interface";
import PropType from "prop-types";
import { axiosInstance } from "../../../lib/axios";
import { useNavigate } from "react-router-dom";

const PropDataSurveyor = ({ data }: { data: SurveyData }) => {

  const navigate = useNavigate();

  const deleteSurveyor = (id: number) => {
    axiosInstance
      .delete(`/api/surveyor/deleteSurveyorByID/${id}`)
      .then((res) => {
        window.location.reload();
        console.log(res);
      })
      .catch((err) => {
        console.log(err);
      });
  };

  return (
    <>
      <tr className=" h-16 border-t-2">
        <td className="text-center">
          <h1>{data.SurveyorID.toString().padStart(4, "0")}</h1>
        </td>
        <td>
          <h1>
            {data.First_name} {data.Last_name}
          </h1>
        </td>
        <td>
          <h1>{data.Email}</h1>
        </td>
        <td className="pr-5">
          <div className="flex justify-end gap-2">
            <div
              className="border-primary border-[1px] flex justify-center px-5 py-2 rounded-lg font-bold hover:bg-primary hover:text-white"
              onClick={() => navigate(`/SurveyorPage/${data.SurveyorID}`)}
            >
              <button>View</button>
            </div>
            <div
              className="border-primary border-[1px] flex justify-center px-3 py-2 rounded-lg font-bold hover:bg-primary hover:text-white"
              onClick={() => deleteSurveyor(data.SurveyorID)}
            >
              <button>Delete</button>
            </div>
          </div>
        </td>
      </tr>
    </>
  );
};

PropDataSurveyor.propTypes = {
  data: PropType.object.isRequired,
};

export default PropDataSurveyor;
