import PropType from "prop-types";
import { CustomerData } from "../../../interface/interface";

const PropCustomer = ({ data }: { data: CustomerData }) => {
  return (
    <>
      <tr className=" h-16 border-t-2">
        <td className="text-center"><h1>{data.CustomerID.toString().padStart(4,"0")}</h1></td>
        <td className="text-center">{data.First_name} {data.Last_name}</td>
        <td>
          <h1>{data.Email}</h1>
        </td>
        <td>
          <h1>{data.Line}</h1>
        </td>
        <td className="">
          <h1>{data.Phone_number}</h1>
        </td>
        <td className="">
          <h1>{data.Address}</h1>
        </td>
        <td className="pr-5">
          <div className="border-primary border-[1px] flex justify-center py-2 rounded-lg font-bold hover:bg-primary hover:text-white">
            <button>Delete</button>
          </div>
        </td>
      </tr>
    </>
  );
};

PropCustomer.propTypes = {
  data: PropType.object.isRequired,
};

export default PropCustomer;
