import { SurveyorByIDData } from "../../../interface/interface";
import PropType from "prop-types";
import React, { useState } from "react";
import { FileInput, Label, Modal } from "flowbite-react";
import { axiosInstance } from "../../../lib/axios";

const PropSurveyorByID = ({ data }: { data: SurveyorByIDData }) => {
  const Birtth_date = new Date(data.Birth_date)
    .toISOString()
    .slice(0, 10)
    .split("-")
    .reverse()
    .join("/");
  const [file, setFile] = useState<File | null>(null);
  const [openModal, setOpenModal] = useState(false);
  const [changeData, setChangeData] = useState({
    First_name: "",
    Last_name: "",
    Birthdaty: "",
    Email: "",
    Telephone: "",
    Password: "",
  });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setChangeData((prev) => ({
      ...prev,
      [name]: value,
    }));
  };

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = e.target.files;
    if (files) {
      setFile(files[0]);
    }
  };

  const formData = new FormData();
  formData.append("First_name", changeData.First_name);
  formData.append("Last_name", changeData.Last_name);
  formData.append("Email", changeData.Email);
  formData.append("PassWord", changeData.Password);
  formData.append("Phone_number", changeData.Telephone);
  formData.append("Birth_date", changeData.Birthdaty);
  if (file) {
    formData.append("file", file);
  }

  const handleSubmit = async (e: React.FormEvent) => {
    try {
      e.preventDefault();
      await axiosInstance
        .put(`/api/admin/updateSurveyor/${data.SurveyorID}`, changeData)
        .then((res) => console.log(res));
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
            <p className="text-sm">
              {data.SurveyorID.toString().padStart(4, "0")}
            </p>
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
          <button
            className="border-0 border-[#140554] bg-[#140554] w-[180px] h-[44px] text-white rounded-md"
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
              Edit Surveyor
            </h3>
            <div className="flex justify-between ">
              <div>
                <div className="flex w-[99px] h-[99px] items-center justify-center">
                  <Label
                    htmlFor="dropzone-file"
                    className="dark:hover:bg-bray-800 flex  w-full cursor-pointer flex-col items-center justify-center rounded-full border-2 border-gray-300 bg-gray-50 hover:bg-gray-100 dark:border-gray-600 dark:bg-gray-700 dark:hover:border-gray-500 dark:hover:bg-gray-600"
                  >
                    <div className="flex flex-col items-center justify-center pb-6 pt-5">
                      {file !== null ? (
                        <img
                          src={URL.createObjectURL(file)}
                          className="object-cover h-fit w-full"

                        />
                      ) : (
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
                  htmlFor="Firstname"
                  className="text-[12px] text-gray-300"
                >
                  Firstname
                </label>
                <input
                  type="text"
                  onChange={handleChange}
                  name="First_name"
                  placeholder=" "
                  className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300 focus:border-2 focus:border-[#120554]"
                />
              </div>

              <div className="mb-2 flex flex-col">
                <label htmlFor="Surname" className="text-[12px] text-gray-300">
                  Lastname
                </label>
                <input
                  type="text"
                  onChange={handleChange}
                  name="Last_name"
                  placeholder=""
                  className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300 focus:border-2 focus:border-[#120554]"
                />
              </div>
            </div>
            <div className="relative z-0 w-full mb-5">
              <input
                type="text"
                name="Birthday"
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
                  type="text"
                  onChange={handleChange}
                  name="Email"
                  placeholder=" "
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
                  name="Telephone"
                  placeholder=" "
                  onChange={handleChange}
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
                name="Password"
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
                Edit
              </button>
            </div>
          </form>
        </Modal.Body>
      </Modal>
    </>
  );
};

PropSurveyorByID.prototype = {
  data: PropType.object.isRequired,
};

export default PropSurveyorByID;
