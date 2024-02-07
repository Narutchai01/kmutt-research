import { CustomerData } from "../../../interface/interface";
import PropType from "prop-types";
import { Modal, Label,FileInput } from "flowbite-react";
import { useState } from "react";
const PropCustomerbyID = ({ data }: { data: CustomerData }) => {

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
        <div className="flex justify-end">
          <button className="w-[180px] h-[44px] border-1 border-[#140554] bg-[#140554] text-white rounded-md" onClick={() => setOpenModal(true)}>Edit</button>
        </div>
      </div>
      <Modal show={openModal} size="xl" onClose={onCloseModal} popup>
        <Modal.Header />
        <Modal.Body>
          <div className="space-y-6">
            <h3 className="text-[24px] font-medium text-gray-900 dark:text-white text-center">Edit Customer</h3>
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
                          <FileInput id="dropzone-file" className="hidden" />
                        </Label>
                      </div>
              </div>
              <div className="mb-2 flex flex-col">
                <label htmlFor="Firstname" className="text-[12px] text-gray-300">Firstname</label>
                <input
                type="text"
                name="Firstname"
                placeholder=" "
                className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300 focus:border-2 focus:border-[#120554]"
              />
              </div>
             
              <div className="mb-2 flex flex-col">
                <label htmlFor="Surname" className="text-[12px] text-gray-300">Surname</label>
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
                name="address"
                placeholder=" "
                className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300"
              />
              <label htmlFor="address" className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1 focus:border-2 focus:border-[#120554]">Address</label>
              
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
              <label htmlFor="email" className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1 focus:border-2 focus:border-[#120554]">email</label>
              
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


PropCustomerbyID.prototype = {
    data: PropType.object.isRequired,
};

export default PropCustomerbyID;
