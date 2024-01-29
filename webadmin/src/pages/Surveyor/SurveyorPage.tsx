import Layout from "../../components/Layout";
import { FaPlus } from "react-icons/fa6";
import TableSurveyor from "./components/TableSurveyor";

const SurveyorPage = () => {
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
              <div className="bg-primary flex text-white px-3 py-2 rounded-xl gap-2">
                <FaPlus className="text-2xl" />
                <button>Add Surveyor</button>
              </div>
            </div>
          </div>
          <div>
            <TableSurveyor />
          </div>
        </div>
      </Layout>
    </>
  );
};

export default SurveyorPage;
