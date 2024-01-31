import { CarInfoData } from "../../../interface/interface";
import PropTypes from "prop-types";

const DataInfoCar = ({ data }: { data: CarInfoData }) => {
  return (
    <>
      <div className="flex flex-col gap-10">
        <div className=" grid grid-cols-[1fr_3fr_3fr] items-center">
          <div className=" w-24 h-24">
            <img
              src={data.Customer_image}
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
        <div className="grid grid-cols-3">
          <div className="">
            <h1 className="text-2xl font-bold">Car ID</h1>
            <p className="text-sm">{data.CarID}</p>
          </div>
          <div>
            <h1 className="text-2xl font-bold">Policy number</h1>
            <p className="text-sm">{data.Policy_number}</p>
          </div>
          <div>
            <h1 className="text-2xl font-bold">Policy type</h1>
            <p className="text-sm">{data.Policy_type}</p>
          </div>
        </div>
        <div className="grid grid-cols-3">
          <div className="">
            <h1 className="text-2xl font-bold">Start date</h1>
            <p className="text-sm">{data.Start_date}</p>
          </div>
          <div>
            <h1 className="text-2xl font-bold">End date</h1>
            <p className="text-sm">{data.End_date}</p>
          </div>
        </div>
        <div className="grid grid-cols-3">
          <div className="">
            <h1 className="text-2xl font-bold">Model</h1>
            <p className="text-sm">{data.Model}</p>
          </div>
          <div>
            <h1 className="text-2xl font-bold">Brand</h1>
            <p className="text-sm">{data.Brand}</p>
          </div>
          <div>
            <h1 className="text-2xl font-bold">Color</h1>
            <p className="text-sm">{data.Color}</p>
          </div>
        </div>
        <div className="grid grid-cols-3">
          <div className="">
            <h1 className="text-2xl font-bold">Telephone</h1>
            <p className="text-sm">{data.Phone_number}</p>
          </div>
          <div>
            <h1 className="text-2xl font-bold">Email</h1>
            <p className="text-sm">{data.Email}</p>
          </div>
          <div>
            <h1 className="text-2xl font-bold">Line ID</h1>
            <p className="text-sm">{data.Line}</p>
          </div>
        </div>
        <div>
            <img src={data.Car_Image} alt="" />
        </div>
      </div>
    </>
  );
};

DataInfoCar.prototype = {
  data: PropTypes.object,
};

export default DataInfoCar;
