import { CustomerData } from "../../../interface/interface";
import PropType from "prop-types";

const PropCustomerbyID = ({ data }: { data: CustomerData }) => {


  

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
            <h1 className="text-2xl font-bold">Customer ID </h1>
            <p className="text-sm">{data.CustomerID.toString().padStart(4,"0")}</p>
          </div>
          <div>
            <h1 className="text-2xl font-bold">Line</h1>
            <p className="text-sm">{data.Line}</p>
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
        <div className="grid grid-cols-2">
          <div className="">
            <h1 className="text-2xl font-bold">Address</h1>
            <p className="text-sm">{data.Address}</p>
          </div>
        </div>
      </div>
    </>
  );
};


PropCustomerbyID.prototype = {
    data: PropType.object.isRequired,
};

export default PropCustomerbyID;
