import Layout from "../../components/Layout";
import { FaPlus } from "react-icons/fa6";
import TableCar from "./components/TableCar";
import { useState } from "react";
import { Modal,Label } from "flowbite-react";

const CarPage = () => {
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
            <h1 className="w-full font-bold text-3xl">Car</h1>
            <div className="flex justify-center w-full h-full">
              <input
                type="text"
                className="w-full bg-gray-500 border-2 rounded-xl h-full"
              />
            </div>
            <div className="w-full flex justify-end">
              <div className="bg-primary flex text-white px-3 py-2 rounded-xl gap-2" onClick={() => setOpenModal(true)}>
                <FaPlus className="text-2xl" />
                <button>Add Car</button>
              </div>
            </div>
          </div>
          <div className="w-ful h my-10 rounded-lg border-2 border-">
            <TableCar />
          </div>
        </div>
      </Layout>
      <Modal show={openModal} size="xl" onClose={onCloseModal} popup>
        <Modal.Header />
        <Modal.Body>
          <div className="space-y-6">
            <h3 className="text-[24px] font-medium text-gray-900 dark:text-white text-center">Add Customer</h3>
            <div className="flex justify-between ">
              <div >
                        <div className="flex w-[99px] h-[99px] items-center justify-center">
                        <Label
                          htmlFor="dropzone-file"
                          className="dark:hover:bg-bray-800 flex  w-full cursor-pointer flex-col items-center justify-center rounded-full border-2 border-gray-300 bg-gray-50 hover:bg-gray-100 dark:border-gray-600 dark:bg-gray-700 dark:hover:border-gray-500 dark:hover:bg-gray-600"
                        >
                          <div className="flex flex-col items-center justify-center pb-6 pt-5">
                            <svg
                              className="mb-4 h-8 w-8 text-gray-500 dark:text-gray-400"
                              aria-hidden="true"
                              xmlns="http://www.w3.org/2000/svg"
                              fill="none"
                              viewBox="0 0 20 8"
                            >
                              <path
                                stroke="currentColor"
                                strokeLinecap="round"
                                
                                strokeWidth="2"
                                d="M13 13h3a3 3 0 0 0 0-6h-.025A5.56 5.56 0 0 0 16 6.5 5.5 5.5 0 0 0 5.207 5.021C5.137 5.017 5.071 5 5 5a4 4 0 0 0 0 8h2.167M10 15V6m0 0L8 8m2-2 2 2"
                              />
                            </svg>
                       
                          </div>
                         
                        </Label>
                      </div>
              </div>
              <div className="mb-2 flex flex-col">
                <label htmlFor="" className="text-[12px] text-gray-300">Firstname</label>
                <input
                type="text"
                name="Firstname"
                placeholder=" "
                className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300 focus:border-2 focus:border-[#120554]"
              />
              </div>
             
              <div className="mb-2 flex flex-col">
                <label htmlFor="" className="text-[12px] text-gray-300">Surname</label>
                <input
                type="text"
                name="Surname"
                placeholder=" "
                className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300 focus:border-2 focus:border-[#120554]"
              />
              </div>
            
             </div>
             <div className="relative z-0 w-full mb-5">
              <input
                type="text"
                name="email"
                placeholder=" "
                className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300"
              />
              <label htmlFor="email" className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1 focus:border-2 focus:border-[#120554]">Address</label>
              
            </div>
            <div className="flex flex-row gap-3">
              <div className="relative z-0 w-full mb-1">
                <input
                  type="text"
                  name="phonenumber"
                  placeholder=" "
                  className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300"
                />
                <label htmlFor="phonenumber" className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1 focus:border-2 focus:border-[#120554]">Phone number</label>
                
              </div>
              <div className="relative z-0 w-full ">
                <input
                  type="text"
                  name="lineid"
                  placeholder=" "
                  className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300"
                />
                <label htmlFor="lineid" className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1 focus:border-2 focus:border-[#120554]">Line ID</label>    
              </div>
            </div>
            <div className="relative z-0 w-full">
              <input
                type="text"
                name="email"
                placeholder=" "
                className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300"
              />
              <label htmlFor="email" className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1 focus:border-2 focus:border-[#120554]">Address</label>
              
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

export default CarPage;
