import { CustomerData } from "../../../interface/interface";
import PropType from "prop-types";
import { Modal, Label, FileInput } from "flowbite-react";
import { useState } from "react";
import { axiosInstance } from "../../../lib/axios";

const PropCustomerbyID = ({ data }: { data: CustomerData }) => {
  const [openModal, setOpenModal] = useState(false);
  const [file, setFile] = useState<File | null>(null);
  const [customerData, setCustomerData] = useState({
    FirstName: "",
    LastName: "",
    Address: "",
    Phone_number: "",
    Line: "",
    Email: "",
  });

  function onCloseModal() {
    setOpenModal(false);
  }

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setCustomerData({ ...customerData, [name]: value });
  };

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = e.target.files;
    if (files) {
      setFile(files[0]);
    }
  };

  const formData = new FormData();

  formData.append("FirstName", customerData.FirstName);
  formData.append("LastName", customerData.LastName);
  formData.append("Address", customerData.Address);
  formData.append("Phone_number", customerData.Phone_number);
  formData.append("Line", customerData.Line);
  formData.append("Email", customerData.Email);
  if (file) {
    formData.append("Image", file);
  }

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    try {
      e.preventDefault();
      await axiosInstance
        .post(`/api/customer/addCustomer`, formData)
        .then(() => {
          onCloseModal();
        });
    } catch (error) {
      console.log(error);
    }
  };

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
            <p className="text-sm">
              {data.CustomerID.toString().padStart(4, "0")}
            </p>
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
          <button
            className="w-[180px] h-[44px] border-1 border-[#140554] bg-[#140554] text-white rounded-md"
            onClick={() => setOpenModal(true)}
          >
            Edit
          </button>
        </div>
      </div>
      <Modal show={openModal} size="xl" onClose={onCloseModal} popup>
        <Modal.Header />
        <Modal.Body>
          <form onSubmit={handleSubmit} className="space-y-6">
            <h3 className="text-[24px] font-medium text-gray-900 dark:text-white text-center">
              Edit Customer
            </h3>
            <div className="flex justify-between ">
              <div>
                <div className="flex w-[99px] h-[99px] items-center justify-center">
                  <Label
                    htmlFor="dropzone-file"
                    className="dark:hover:bg-bray-800 flex  w-full cursor-pointer flex-col items-center justify-center rounded-full border-2 border-gray-300 bg-gray-50 hover:bg-gray-100 dark:border-gray-600 dark:bg-gray-700 dark:hover:border-gray-500 dark:hover:bg-gray-600"
                  >
                    <div className="flex flex-col items-center justify-center pb-6 pt-5">
                      {file ? (
                        <img
                          src={URL.createObjectURL(file)}
                          alt="preview"
                          className="w-full h-full object-cover"
                        />
                      ) : (
                        <span className="text-[12px] text-gray-300">
                          Drag and drop your file here
                        </span>
                      )}
                    </div>
                    <FileInput
                      id="dropzone-file"
                      className="hidden"
                      onChange={handleFileChange}
                    />
                  </Label>
                </div>
              </div>
              <div className="mb-2 flex flex-col">
                <label
                  htmlFor="FirstName"
                  className="text-[12px] text-gray-300"
                >
                  Firstname
                </label>
                <input
                  type="text"
                  name="FirstName"
                  placeholder=" "
                  onChange={handleChange}
                  className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300 focus:border-2 focus:border-[#120554]"
                />
              </div>

              <div className="mb-2 flex flex-col">
                <label htmlFor="Surname" className="text-[12px] text-gray-300">
                  Surname
                </label>
                <input
                  type="text"
                  name="LastName"
                  placeholder=" "
                  onChange={handleChange}
                  className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300 focus:border-2 focus:border-[#120554]"
                />
              </div>
            </div>
            <div className="relative z-0 w-full mb-5">
              <input
                type="text"
                onChange={handleChange}
                name="Address"
                placeholder=" "
                className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300"
              />
              <label
                htmlFor="address"
                className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1 focus:border-2 focus:border-[#120554]"
              >
                Address
              </label>
            </div>
            <div className="flex flex-row gap-3">
              <div className="relative z-0 w-full mb-1">
                <input
                  type="text"
                  name="Phone_number"
                  onChange={handleChange}
                  placeholder=" "
                  className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300"
                />
                <label
                  htmlFor="phonenumber"
                  className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1 focus:border-2 focus:border-[#120554]"
                >
                  Phone number
                </label>
              </div>
              <div className="relative z-0 w-full ">
                <input
                  type="text"
                  name="Line"
                  placeholder=" "
                  onChange={handleChange}
                  className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300"
                />
                <label
                  htmlFor="lineid"
                  className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1 focus:border-2 focus:border-[#120554]"
                >
                  Line ID
                </label>
              </div>
            </div>
            <div className="relative z-0 w-full">
              <input
                type="text"
                name="Email"
                placeholder=" "
                onChange={handleChange}
                className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300"
              />
              <label
                htmlFor="email"
                className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1 focus:border-2 focus:border-[#120554]"
              >
                email
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

PropCustomerbyID.prototype = {
  data: PropType.object.isRequired,
};

export default PropCustomerbyID;
