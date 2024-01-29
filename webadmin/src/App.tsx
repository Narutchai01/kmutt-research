import { Route, Routes } from "react-router-dom";
import DashboardPage from "./pages/DashBoard/DashboardPage";
import SurveyorPage from "./pages/Surveyor/SurveyorPage";
import LoginPage from "./pages/Login/LoginPage";

function App() {
  return (
    <>
      <Routes>
          <Route path="/Dashboards" element={<DashboardPage />} />
          <Route path="/" element={<LoginPage/>} />
          <Route path="/SurveyorPage" element={<SurveyorPage/>} />
      </Routes>
    </>
  );
}

export default App;
