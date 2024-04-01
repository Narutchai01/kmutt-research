import { Modal } from "flowbite-react/lib/esm/components/Modal";
import { CaseData } from "../../../interface/interface";
import PropType from "prop-types";
import { useState } from "react";

const PropCaseByID = ({ data }: { data: CaseData }) => {

    const DateOpened = new Date(data.Date_opened).toLocaleDateString("en-GB");
    const [openModal, setOpenModal] = useState(false);
  function onCloseModal() {
    setOpenModal(false);
    // setEmail('');
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    console.log("submit");
  };
  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    console.log(name, value);
  };
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
      <div className="flex justify-end">
          <button
            className="border-0 border-[#140554] bg-[#140554] w-[180px] h-[44px] text-white rounded-md"
            onClick={() => setOpenModal(true)}
          >
            Edit case
          </button>
        </div>

      <Modal show={openModal} size="xl" onClose={onCloseModal} popup>
        <Modal.Header />
        <Modal.Body>
          <form className="space-y-6" onSubmit={handleSubmit}>
            <h3 className="text-[24px] font-medium text-gray-900 dark:text-white text-center">
              Edit Case
            </h3>
            <div className="flex row gap-5">
              <div className="w-1/2">
                <label className="text-[14px] font-bold">CaseID</label>
                <h3>{data.CaseID}</h3>
              </div>
              <div className="w-1/2">
                <label className="text-[14px] font-bold">Car ID</label>
                <h3>{data.CarID}</h3>
              </div>
            </div>
            <div className="flex row gap-5">
            <div className="w-1/2">
                <label className="text-[14px] font-bold">Surveyor ID</label>
                <h3>{data.SurveyorID}</h3>
              </div>
              <div className="w-1/2">
                <label className="text-[14px] font-bold">Date opened</label>
                <h3>{data.Date_opened}</h3>
              </div>
            </div>
            <div className="relative z-0 w-full">
              <input
                type="text"
                name="Description"
                placeholder=" "
                onChange={handleChange}
                className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300"
              />
              <label
                htmlFor="Description"
                className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1 focus:border-2 focus:border-[#120554]"
              >
                Description
              </label>
            </div>
            <div className="flex justify-center">
              <button
                type="submit"
                className="border-1 border-[#120554] bg-[#120554] rounded-md w-[180px] h-[44px] text-white"
              >
                Edit
              </button>
            </div>
          </form>
        </Modal.Body>
      </Modal>
   
    </>
  );
};

PropCaseByID.prototype = {
    data: PropType.object.isRequired,
};

export default PropCaseByID ;
