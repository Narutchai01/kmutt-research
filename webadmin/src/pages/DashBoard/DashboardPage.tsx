import Layout from "../../components/Layout";
import { Chart } from "react-chartjs-2";
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend,
  BarElement,
  ArcElement,
} from "chart.js";
import CardCounte from "./components/Card/CardCounte";
import { useEffect, useState } from "react";
import { axiosInstance } from "../../lib/axios";

ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend,
  ArcElement,
  BarElement
);

interface lineDataInterface {
  message: string;
  date: string[];
  couter: number[];
}

interface barDataInterface {
  Policy_type: string[];
  coun_policy: number[];
}

interface doughnutDataInsterface {
  Province: string[];
  ProvinceCounter: number[];
}

const DashboardPage = () => {
  const [cardData, setCardData] = useState([]);
  const [lineData, setLineData] = useState<lineDataInterface>({
    message: "",
    date: [],
    couter: [],
  });

  const [barData, setBarData] = useState<barDataInterface>({
    Policy_type: [],
    coun_policy: [],
  });

  const [doughnutData, setDoughnutData] = useState<doughnutDataInsterface>({
    Province: [],
    ProvinceCounter: [],
  });
  const fetchCardData = async () => {
    try {
      const res = await axiosInstance.get("/api/admin/getChartCard");
      setCardData(res.data.data);
    } catch (error) {
      console.log(error);
    }
  };

  const fetchLineData = async () => {
    try {
      const res = await axiosInstance.get("/api/admin/getChartLine");
      setLineData(res.data);
    } catch (error) {
      console.log(error);
    }
  };

  const fetchBarData = async () => {
    try {
      await axiosInstance
        .get("/api/admin/getChartbar")
        .then((res) => setBarData(res.data));
    } catch (error) {
      console.log(error);
    }
  };

  const fechDoughnutsData = async () => {
    try {
      await axiosInstance
        .get("/api/admin/getChartDoughnut")
        .then((res) => setDoughnutData(res.data));
    } catch (error) {
      console.log(error);
    }
  };

  useEffect(() => {
    fetchLineData();
    fetchCardData();
    fetchBarData();
    fechDoughnutsData();
  }, []);

  const dataLine = {
    labels: lineData.date,
    datasets: [
      {
        axis: "y",
        label: "Case",
        data: lineData.couter,
        fill: false,
        backgroundColor: [
          "rgba(255, 99, 132, 0.2)",
          "rgba(255, 159, 64, 0.2)",
          "rgba(255, 205, 86, 0.2)",
          "rgba(75, 192, 192, 0.2)",
          "rgba(54, 162, 235, 0.2)",
          "rgba(153, 102, 255, 0.2)",
          "rgba(201, 203, 207, 0.2)",
        ],
        borderColor: [
          "rgb(255, 99, 132)",
          "rgb(255, 159, 64)",
          "rgb(255, 205, 86)",
          "rgb(75, 192, 192)",
          "rgb(54, 162, 235)",
          "rgb(153, 102, 255)",
          "rgb(201, 203, 207)",
        ],
        borderWidth: 1,
      },
    ],
  };

  const dataBar = {
    labels: barData.Policy_type,
    datasets: [
      {
        axis: "y",
        label: "Case",
        data: barData.coun_policy,
        fill: false,
        backgroundColor: [
          "rgba(255, 99, 132, 0.2)",
          "rgba(255, 159, 64, 0.2)",
          "rgba(255, 205, 86, 0.2)",
          "rgba(75, 192, 192, 0.2)",
          "rgba(54, 162, 235, 0.2)",
          "rgba(153, 102, 255, 0.2)",
          "rgba(201, 203, 207, 0.2)",
        ],
        borderColor: [
          "rgb(255, 99, 132)",
          "rgb(255, 159, 64)",
          "rgb(255, 205, 86)",
          "rgb(75, 192, 192)",
          "rgb(54, 162, 235)",
          "rgb(153, 102, 255)",
          "rgb(201, 203, 207)",
        ],
        borderWidth: 1,
      },
    ],
  };

  console.log(doughnutData);

  const dataDoughnuts = {
    labels: doughnutData.Province,
    datasets: [
      {
        axis: "y",
        label: "Case",
        data: doughnutData.ProvinceCounter,
        fill: false,
        backgroundColor: [
          "rgba(255, 99, 132, 0.2)",
          "rgba(255, 159, 64, 0.2)",
          "rgba(255, 205, 86, 0.2)",
          "rgba(75, 192, 192, 0.2)",
          "rgba(54, 162, 235, 0.2)",
          "rgba(153, 102, 255, 0.2)",
          "rgba(201, 203, 207, 0.2)",
        ],
        borderColor: [
          "rgb(255, 99, 132)",
          "rgb(255, 159, 64)",
          "rgb(255, 205, 86)",
          "rgb(75, 192, 192)",
          "rgb(54, 162, 235)",
          "rgb(153, 102, 255)",
          "rgb(201, 203, 207)",
        ],
        borderWidth: 1,
      },
    ],
  };
  const options = {
    responsive: true,
    plugins: {
      legend: {
        position: "top" as const,
      },
      title: {
        display: true,
        text: "Chart.js Line Chart",
      },
    },
  };

  return (
    <Layout>
      <div className="grid gap-12 px-24 py-10">
        <h1 className="text-3xl font-bold">DashBoard</h1>
        <div className="flex justify-between [&>*:nth-child(odd)]:bg-[#E3F5FF] [&>*:nth-child(even)]:bg-[#E5ECF6]">
          {cardData.map(
            (data: { title: string; value: number }, index: number) => (
              <CardCounte key={index} title={data.title} value={data.value} />
            )
          )}
        </div>
        <div className=" flex justify-center bg-slate-100 rounded-3xl">
          <div className="w-3/4 flex justify-cente">
            <Chart type="line" data={dataLine} options={options} />
          </div>
        </div>
        <div className="grid grid-cols-2 gap-10 ">
          <div className=" rounded-3xl border-2 bg-slate-100 grid justify-center items-center">
            <h1 className=" font-bold">Bar Chart</h1>
            <Chart type="bar" data={dataBar} options={options} />
          </div>
          <div className=" rounded-3xl border-2 bg-slate-100 grid items-center py-5">
            <h1 className=" font-bold">Doughnut Chart</h1>
            <div className="grid justify-center">
              <div className="w-[470px]">
                <Chart type="doughnut" data={dataDoughnuts} options={options} />
              </div>
            </div>
          </div>
        </div>
      </div>
    </Layout>
  );
};

export default DashboardPage;
