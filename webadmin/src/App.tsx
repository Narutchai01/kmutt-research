import { Route, Routes } from "react-router-dom";
import DashboardPage from "./pages/DashBoard/DashboardPage";
import SurveyorPage from "./pages/Surveyor/SurveyorPage";
import LoginPage from "./pages/Login/LoginPage";
import CarPage from "./pages/Car/CarPage";
import InsurancePage from "./pages/Insurance/InsurancePage";
import CasePage from "./pages/Case/CasePage";
import CustomerPage from "./pages/Customer/CustomerPage";
import SurveyorByID from "./pages/Surveyor/SurveyorByID";
import CarPageByCarID from "./pages/Car/CarPageByCarID";

function App() {
  return (
    <>
      <Routes>
        <Route path="*" element={<h1>Not Found</h1>} />
        <Route path="/" element={<LoginPage />} />
        <Route path="/Dashboards" element={<DashboardPage />} />
        <Route path="/SurveyorPage" element={<SurveyorPage />} />
        <Route path="/CarPage" element={<CarPage />} />
        <Route path="/CarPage/:id" element={<CarPageByCarID />} />
        <Route path="/InsurancePage" element={<InsurancePage />} />
        <Route path="/CasePage" element={<CasePage />} />
        <Route path="/CustomerPage" element={<CustomerPage/>} />
        <Route path="/SurveyorPage/:id" element={<SurveyorByID/>} />
      </Routes>
    </>
  );
}

export default App;
