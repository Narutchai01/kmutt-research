import Layout from "../../components/Layout";
import TableCase from "./components/TableCase";


const CasePage = () => {
  return (
    <>
      <Layout>
        <div className="py-3 px-5 w-full">
          <div className="grid grid-cols-[1fr_7fr_1fr] items-center">
            <h1 className="w-full font-bold text-3xl">Case</h1>
            <div className="flex justify-center w-full h-full">
              <input
                type="text"
                className="w-full bg-gray-500 border-2 rounded-xl h-full"
              />
            </div>
            
          </div>
          <div className="w-ful h my-10 rounded-lg border-2 border-">
            <TableCase />
          </div>
        </div>
      </Layout>
    </>
  );
};

export default CasePage;
