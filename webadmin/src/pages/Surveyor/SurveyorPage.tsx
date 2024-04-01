import Layout from "../../components/Layout";
import { FaPlus } from "react-icons/fa6";
import TableSurveyor from "./components/TableSurveyor";

import { FileInput, Label, Modal } from "flowbite-react";
import React, { useState } from "react";
import { axiosInstance } from "../../lib/axios";

interface dataSurveyorInterface {
  First_name: string;
  Last_name: string;
  Email: string;
  PassWord: string;
  Phone_number: string;
  Birth_date: string;
}

const SurveyorPage = () => {
  const [openModal, setOpenModal] = useState(false);
  const [dataSurveyor, setDataSurveyor] = useState<dataSurveyorInterface>({
    First_name: "",
    Last_name: "",
    PassWord: "",
    Birth_date: "",
    Email: "",
    Phone_number: "",
  });

  function onCloseModal() {
    setOpenModal(false);
  }

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    // Add type annotation for e parameter
    const { name, value } = e.target;
    setDataSurveyor((prev) => ({
      ...prev,
      [name]: value,
    }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    try {
      e.preventDefault();
      // console.log(dataSurveyor);
      await axiosInstance
        .post(`/api/surveyor/createSurveyor`, dataSurveyor)
        .then((res) => console.log(res));
    } catch (error) {
      console.log(error);
    }
  };

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
              <div
                className="bg-primary flex text-white px-3 py-2 rounded-xl gap-2"
                onClick={() => setOpenModal(true)}
              >
                <FaPlus className="text-2xl" />
                <button>Add Surveyor</button>
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
          <form className="space-y-6" onSubmit={handleSubmit}>
            <h3 className="text-[24px] font-medium text-gray-900 dark:text-white text-center">
              Add Surveyor
            </h3>
            <div className="flex justify-between ">
              <div>
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
                <label
                  htmlFor="Firstname"
                  className="text-[12px] text-gray-300"
                >
                  Firstname
                </label>
                <input
                  type="text"
                  name="First_name"
                  onChange={handleChange}
                  placeholder=" "
                  className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300 focus:border-2 focus:border-[#120554]"
                />
              </div>

              <div className="mb-2 flex flex-col">
                <label htmlFor="Surname" className="text-[12px] text-gray-300">
                  Surname
                </label>
                <input
                  type="text"
                  name="Last_name"
                  onChange={handleChange}
                  placeholder=""
                  className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300 focus:border-2 focus:border-[#120554]"
                />
              </div>
            </div>
            <div className="relative z-0 w-full mb-5">
              <input
                type="text"
                name="Birth_date"
                onChange={handleChange}
                placeholder="dd/mm/yyyy"
                className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300"
              />
              <label
                htmlFor="address"
                className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1 focus:border-2 focus:border-[#120554]"
              >
                BirthDay
              </label>
            </div>
            <div className="flex flex-row gap-3">
              <div className="relative z-0 w-full mb-1">
                <input
                  type="email"
                  name="Email"
                  onChange={handleChange}
                  placeholder="YYYY-MM-DD"
                  className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300"
                />
                <label
                  htmlFor="phonenumber"
                  className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1 focus:border-2 focus:border-[#120554]"
                >
                  Email
                </label>
              </div>
              <div className="relative z-0 w-full ">
                <input
                  type="text"
                  name="Phone_number"
                  onChange={handleChange}
                  placeholder=" "
                  className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300"
                />
                <label
                  htmlFor="lineid"
                  className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1 focus:border-2 focus:border-[#120554]"
                >
                  Phone number
                </label>
              </div>
            </div>
            <div className="relative z-0 w-full">
              <input
                type="password"
                name="PassWord"
                placeholder=" "
                onChange={handleChange}
                className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300"
              />
              <label
                htmlFor="email"
                className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1 focus:border-2 focus:border-[#120554]"
              >
                Password
              </label>
            </div>
            <div className="flex justify-center">
              <button
                type="submit"
                className="border-1 border-[#120554] bg-[#120554] rounded-md w-[180px] h-[44px] text-white"
              >
                Add
              </button>
            </div>
          </form>
        </Modal.Body>
      </Modal>
    </>
  );
};

export default SurveyorPage;
