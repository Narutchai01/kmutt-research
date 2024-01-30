import PropType from "prop-types";
import { CarData } from "../../../interface/interface";
import { axiosInstance } from "../../../lib/axios";

const PropCar = ({ data }: { data: CarData }) => {
  const deleteCarByID = async (id: string) => {
    id = id.replace(/ /g, "%20");
    axiosInstance.delete(`/api/cars/deleteCarByID/${id}`).then((res) => {
      console.log(res.data);
    });
  };
  return (
    <>
      <tr className=" h-16 border-t-2">
        <td className="text-center">{data.CarID}</td>
        <td>
          <h1>{data.Province}</h1>
        </td>
        <td>
          <h1>
            {data.First_name} {data.Last_name}
          </h1>
        </td>
        <td className="">
          <h1>{data.Policy_type}</h1>
        </td>
        <td className="pr-5">
          <div
            className="border-primary border-[1px] flex justify-center py-2 rounded-lg font-bold hover:bg-primary hover:text-white"
            onClick={() => deleteCarByID(data.CarID)}
          >
            <button>Delete</button>
          </div>
        </td>
      </tr>
    </>
  );
};

PropCar.propTypes = {
  data: PropType.object.isRequired,
};
export default PropCar;
