import PropType from "prop-types";
import { CaseData } from "../../../interface/interface";
import { useState } from "react";

const PropCase = ({ data }: { data: CaseData }) => {
  const date = new Date(data.Date_opened).toISOString().split("T")[0];
  const checkStatus = useState<boolean>(false);

  return (
    <>
      <tr className=" h-16 border-t-2">
        <td className="text-center">{data.CarID}</td>
        <td>
          <h1>{data.CaseID}</h1>
        </td>
        <td>
          <h1 className={checkStatus ? "bg-red-600" : " bg-green-600"}>
            {data.Status}
          </h1>
        </td>
        <td className="">
          <h1>{date}</h1>
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

PropCase.propTypes = {
  data: PropType.object,
};

export default PropCase;
