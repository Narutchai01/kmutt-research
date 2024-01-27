import { Route, Routes } from "react-router-dom";
import DashboardPage from "./pages/DashBoard/DashboardPage";

function App() {
  return (
    <>
      <Routes>
        <Route path="/" element={<h1>Home</h1>} />
        {/* <Layout> */}
          <Route path="/Dashboards" element={<DashboardPage />} />
        {/* </Layout> */}
      </Routes>
    </>
  );
}

export default App;
