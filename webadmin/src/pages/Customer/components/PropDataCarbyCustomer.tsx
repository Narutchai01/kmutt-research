import PropTypes from "prop-types";
import { CustomerCarData } from "../../../interface/interface";

const PropDataCarbyCustomer = ({ data }: { data: CustomerCarData }) => {


  return (
    <>
      <tr className=" h-16 border-t-2">
        <td className="text-center">
          <h1>{data.CarID}</h1>
        </td>
        <td>
          <h1>{data.Brand}</h1>
        </td>
        <td>
          <h1>{data.Model}</h1>
        </td>
        <td>
          <h1>{data.Color}</h1>
        </td>
        <td>
          <h1>{data.Province}</h1>
        </td>
        <td className="pr-5">
          <div className="flex justify-end gap-2">
            <div className="border-primary border-[1px] flex justify-center px-5 py-2 rounded-lg font-bold hover:bg-primary hover:text-white">
              <button>View</button>
            </div>
            
          </div>
        </td>
      </tr>
    </>
  );
};

PropDataCarbyCustomer.propTypes = {
  data: PropTypes.object,
};

export default PropDataCarbyCustomer;
