import Layout from "../../components/Layout";
import { FaPlus } from "react-icons/fa6";
import TableInsurance from "./components/TableInsurance";
import { useState } from "react";
import { Modal } from "flowbite-react";
import { axiosInstance } from "../../lib/axios";

const InsurancePage = () => {
  const [openModal, setOpenModal] = useState(false);
  const [insuranceData, setInsuranceData] = useState({
    Policy_number: "",
    CustomerID: "",
    Policy_type: "",
    Start_date: "",
    End_date: "",
  });

  function onCloseModal() {
    setOpenModal(false);
    // setEmail('');
  }

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setInsuranceData({ ...insuranceData, [name]: value });
  };

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    try {
      e.preventDefault();
      await axiosInstance
        .post(`/api/insurance/addInsurance`, insuranceData)
        .then(() => {
          onCloseModal();
        });
    } catch (error) {
      console.log(error);
    }
  };

  return (
    <>
      <Layout>
        <div className="py-3 px-5 w-full">
          <div className="grid grid-cols-[1fr_7fr_1fr] items-center">
            <h1 className="w-full font-bold text-3xl">Insurance</h1>
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
                <button>Add Insurance</button>
              </div>
            </div>
          </div>
          <div className="w-full h my-10 rounded-lg border-2 border-">
            <TableInsurance />
          </div>
        </div>
      </Layout>
      <Modal show={openModal} size="xl" onClose={onCloseModal} popup>
        <Modal.Header />
        <Modal.Body>
          <div className="space-y-6">
            <h3 className="text-[24px] font-medium text-gray-900 dark:text-white text-center">
              Add Insurance
            </h3>
            <form onSubmit={handleSubmit}>
              <div className="relative z-0 w-full mb-5">
                <input
                  type="text"
                  name="Policy_type"
                  placeholder=" "
                  onChange={handleChange}
                  className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300 focus:border-2 focus:border-[#120554]"
                />
                <label
                  htmlFor="pn"
                  className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1"
                >
                  Policy number
                </label>
              </div>
              <div className="flex justify-between gap-3">
                <div className="relative z-0 w-full">
                  <input
                    type="text"
                    name="CustomerID"
                    placeholder=" "
                    onChange={handleChange}
                    className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300 focus:border-2 focus:border-[#120554]"
                  />
                  <label
                    htmlFor="cusid"
                    className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1"
                  >
                    Customer ID
                  </label>
                </div>
                <div className="relative z-0 w-full ">
                  <input
                    type="text"
                    name="Policy_type"
                    onChange={handleChange}
                    placeholder=" "
                    className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300 focus:border-2 focus:border-[#120554]"
                  />
                  <label
                    htmlFor="pt"
                    className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1"
                  >
                    Policy type
                  </label>
                </div>
              </div>
              <div className="flex justify-between gap-3">
                <div className="relative z-0 w-full ">
                  <input
                    type="text"
                    name="Start_date"
                    onChange={handleChange}
                    placeholder=" "
                    className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300 focus:border-2 focus:border-[#120554]"
                  />
                  <label
                    htmlFor="sd"
                    className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1"
                  >
                    Start date
                  </label>
                </div>
                <div className="relative z-0 w-full ">
                  <input
                    type="text"
                    name="End_date"
                    placeholder=" "
                    onChange={handleChange}
                    className="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-1 rounded-md border-gray-300 focus:border-2 focus:border-[#120554]"
                  />
                  <label
                    htmlFor="ed"
                    className="absolute duration-300 top-[-13px] left-3 text-[12px] text-gray-300 bg-white p-1"
                  >
                    End date
                  </label>
                </div>
              </div>
            </form>
            <div className="flex justify-center">
              <button type="submit" className="border-1 border-[#120554] bg-[#120554] rounded-md w-[180px] h-[44px] text-white">
                Add
              </button>
            </div>
          </div>
        </Modal.Body>
      </Modal>
    </>
  );
};
export default InsurancePage;
