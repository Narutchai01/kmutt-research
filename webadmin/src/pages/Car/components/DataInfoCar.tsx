import { CarInfoData } from "../../../interface/interface";
import PropTypes from "prop-types";
import { Modal, Label, FileInput } from "flowbite-react";
import React, { useState } from "react";
import { axiosInstance } from "../../../lib/axios";

const DataInfoCar = ({ data }: { data: CarInfoData }) => {
  const [openModal, setOpenModal] = useState(false);
  const [file, setFile] = useState<File | null>(null);
  const [changeData, setChangeData] = useState({
    Brand: "",
    Model: "",
    Color: "",
  });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setChangeData({ ...changeData, [name]: value });
  };

   const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = e.target.files;
    if (files) {
      setFile(files[0]);
    }
  };

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    try {
      e.preventDefault();
      await axiosInstance.put(`/api/admin/updateCar/${data.CarID}/${data.Province}`, {
        Brand: changeData.Brand,
        Model: changeData.Model,
        Color: changeData.Color,
      }).then((res) => {
        window.location.reload();
        console.log(res.data);
        
      })
      setOpenModal(false);
    } catch (error) {
     console.log(error);
      
    }
  };

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
        <div className="flex justify-end">
          <button
            className="border-1 border-[#140554] bg-[#140554] text-white rounded-md w-[180px] h-[44px]"
            onClick={() => setOpenModal(true)}
          >
            Edit
          </button>
        </div>
      </div>
      <Modal show={openModal} size="xl" onClose={onCloseModal} popup>
        <Modal.Header />
        <Modal.Body>
          <form className="space-y-6" onSubmit={handleSubmit}>
            <h3 className="text-[24px] font-medium text-gray-900 dark:text-white text-center">
              Edit Car
            </h3>
            <div className="flex flex-row gap-3">
              <div className="relative z-0 w-full mb-1">
                <label>Car ID</label>
                <h5>{data.CarID}</h5>
              </div>

              <div className="relative z-0 w-full ">
                <label>Province</label>
                <h5>{data.Province}</h5>
              </div>
            </div>

            <div className="flex flex-row gap-3">
              <div className="relative z-0 w-full mb-1">
                <input
                  type="text"
                  name="Model"
                  onChange={handleChange}
                  placeholder=" "
                  className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300"
                />
                <label
                  htmlFor="Model"
                  className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1 focus:border-2 focus:border-[#120554]"
                >
                  Model
                </label>
              </div>
              <div className="relative z-0 w-full mb-1">
                <input
                  type="text"
                  name="Brand"
                  onChange={handleChange}
                  placeholder=" "
                  className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300"
                />
                <label
                  htmlFor="Brand"
                  className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1 focus:border-2 focus:border-[#120554]"
                >
                  Brand
                </label>
              </div>
              <div className="relative z-0 w-full ">
                <input
                  type="text"
                  name="Color"
                  onChange={handleChange}
                  placeholder=" "
                  className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300"
                />
                <label
                  htmlFor="Color"
                  className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1 focus:border-2 focus:border-[#120554]"
                >
                  Color
                </label>
              </div>
            </div>

            <div className="relative z-0 w-full ">
              <div className="mb-3">
                <div>
                  <Label
                    htmlFor="multiple-file-upload"
                    value="Upload multiple files"
                    className="text-[12px] text-gray-300"
                  />
                </div>
                <FileInput id="multiple-file-upload" multiple onChange={handleFileChange} />
              </div>
              <div className="flex w-full items-center justify-center">
                <Label
                  htmlFor="dropzone-file"
                  className="dark:hover:bg-bray-800 flex h-64 w-full cursor-pointer flex-col items-center justify-center rounded-lg border-2 border-dashed border-gray-300 bg-gray-50 hover:bg-gray-100 dark:border-gray-600 dark:bg-gray-700 dark:hover:border-gray-500 dark:hover:bg-gray-600"
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
                </Label>
              </div>
            </div>
            <div className="flex justify-center">
              <button className="border-1 border-[#120554] bg-[#120554] rounded-md w-[180px] h-[44px] text-white">
                Edit
              </button>
            </div>
          </form>
        </Modal.Body>
      </Modal>
    </>
  );
};

DataInfoCar.prototype = {
  data: PropTypes.object,
};

export default DataInfoCar;
