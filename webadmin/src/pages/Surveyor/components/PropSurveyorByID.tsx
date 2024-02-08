import { SurveyorByIDData } from "../../../interface/interface";
import PropType from "prop-types";
import { useState } from "react";
import { Modal } from "flowbite-react";


const PropSurveyorByID = ({ data }: { data: SurveyorByIDData }) => {


    const Birtth_date = new Date(data.Birth_date).toISOString().slice(0,10).split("-").reverse().join("/");

    const [openModal, setOpenModal] = useState(false);




    function onCloseModal() {
      setOpenModal(false);
      // setEmail('');
    }
  
  
  


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
        <div className="flex justify-end">
          <button className="border-0 border-[#140554] bg-[#140554] w-[180px] h-[44px] text-white rounded-md" onClick={() => setOpenModal(true)}>Edit</button>
        </div>
      </div>
      <Modal show={openModal} size="xl" onClose={onCloseModal} popup>
        <Modal.Header />
        <Modal.Body>
          <div className="space-y-6">
            <h3 className="text-[24px] font-medium text-gray-900 dark:text-white text-center">Edit Surveyor</h3>
            <div className="flex justify-between gap-3">
            <div className="relative z-0 w-full mb-5">
              <input
                type="text"
                name="Firstname"
                placeholder=" "
                className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300 focus:border-2 focus:border-[#120554]"
              />
              <label htmlFor="Firstname" className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1">Firstname</label>
              
            </div>
            <div className="relative z-0 w-full mb-5">
              <input
                type="text"
                name="Surname"
                placeholder=" "
                className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300 focus:border-2 focus:border-[#120554]"
              />
              <label htmlFor="Surname" className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1">Surname</label>
              
            </div>
             </div>
             <div className="relative z-0 w-full mb-5">
              <input
                type="text"
                name="bd"
                placeholder=" "
                className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300 focus:border-2 focus:border-[#120554]"
              />
              <label htmlFor="bd" className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1">Birthday</label>
              
            </div>
            <div className="flex flex-row gap-3">
              <div className="relative z-0 w-full mb-1">
                <input
                  type="text"
                  name="em"
                  placeholder=" "
                  className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300 focus:border-2 focus:border-[#120554]"
                />
                <label htmlFor="em" className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1">Email</label>
                
              </div>
              <div className="relative z-0 w-full ">
                <input
                  type="text"
                  name="tel"
                  placeholder=" "
                  className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300 focus:border-2 focus:border-[#120554]"
                />
                <label htmlFor="tel" className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1 ">Telephone</label>    
              </div>
            </div>
            <div className="relative z-0 w-full ">
              <input
                type="password"
                name="password"
                placeholder=" "
                className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300 focus:border-[#120554] focus:border-2 f"
              />
              <label htmlFor="password" className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1  ">Password</label>
              
            </div>
            <div className="flex justify-center">
            <button className="border-1 border-[#120554] bg-[#120554] rounded-md w-[180px] h-[44px] text-white">Edit</button>

            </div>
            
         
          
          </div>
        </Modal.Body>
      </Modal>
    </>
  );
};


PropSurveyorByID.prototype = {
    data: PropType.object.isRequired,
};

export default PropSurveyorByID;
