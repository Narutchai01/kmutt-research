import { SurveyData } from "../../../interface/interface";
import PropType from "prop-types";
import { axiosInstance } from "../../../lib/axios";

const PropDataSurveyor = ({ data }: { data: SurveyData }) => {

  const deleteSurveyor = (id: number) => {
    axiosInstance.delete(`/api/surveyor/deleteSurveyorByID/${id}`)
    .then((res) => {
      console.log(res);
    })
    .catch((err) => {
      console.log(err);
    });
  };


  return (
    <>
      <tr>
        <td>{data.SurveyorID}</td>
        <td>
          {data.First_name} {data.Last_name}
        </td>
        <td>{data.Email}</td>
        <td>
          <button onClick={()=> deleteSurveyor(data.SurveyorID)}>Delete</button>
        </td>
      </tr>
    </>
  );
};

PropDataSurveyor.propTypes = {
  data: PropType.object.isRequired,
};

export default PropDataSurveyor;
