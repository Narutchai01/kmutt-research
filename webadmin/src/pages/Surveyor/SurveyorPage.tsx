import Layout from "../../components/Layout";
import { FaPlus } from "react-icons/fa6";
import TableSurveyor from "./components/TableSurveyor";

import { Modal} from "flowbite-react";
import { useState } from "react";
const SurveyorPage = () => {

  
  const [openModal, setOpenModal] = useState(false);




  function onCloseModal() {
    setOpenModal(false);
    // setEmail('');
  }



  return (
    <>
      <Layout>
        <div className="py-3 px-5 w-full">
          <div className="grid grid-cols-[1fr_7fr_1fr] items-center">
            <h1 className="w-full font-bold text-3xl">Surveyor</h1>
            <div className="flex justify-center w-full h-full">
              <input
                type="text"
                className="w-full bg-gray-500 border-2 rounded-xl h-full"
              />
            </div>
            <div className="w-full flex justify-end">
              <div className="bg-primary flex text-white px-3 py-2 rounded-xl gap-2" onClick={() => setOpenModal(true)}>
                <FaPlus className="text-2xl" />
               <button >Add Customer</button>
              </div>
            </div>
          </div>
          <div className="w-full my-10 rounded-lg border-2 ">
            <TableSurveyor />
          </div>
        </div>
      </Layout>
      <Modal show={openModal} size="xl" onClose={onCloseModal} popup>
        <Modal.Header />
        <Modal.Body>
          <div className="space-y-6">
            <h3 className="text-[24px] font-medium text-gray-900 dark:text-white text-center">Add Surveyor</h3>
            <div className="flex justify-between gap-3">
            <div className="relative z-0 w-full mb-5">
              <input
                type="text"
                name="fn"
                placeholder=" "
                className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300 focus:border-2 focus:border-[#120554]"
              />
              <label htmlFor="fn" className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1">Firstname</label>
              
            </div>
            <div className="relative z-0 w-full mb-5">
              <input
                type="text"
                name="sn"
                placeholder=" "
                className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300 focus:border-2 focus:border-[#120554]"
              />
              <label htmlFor="sn" className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1">Surname</label>
              
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
            <button className="border-1 border-[#120554] bg-[#120554] rounded-md w-[180px] h-[44px] text-white">Add</button>

            </div>
            
         
          
          </div>
        </Modal.Body>
      </Modal>

    </>
  );
};

export default SurveyorPage;
