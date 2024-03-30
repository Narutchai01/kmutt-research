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

const DashboardPage = () => {
  const labels = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
  ];

  const data = {
    labels: labels,
    datasets: [
      {
        axis: "y",
        label: "My First Dataset",
        data: [65, 59, 80, 81, 56, 55, 40],
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
          <CardCounte />
          <CardCounte />
          <CardCounte />
        </div>
        <div className=" flex justify-center bg-slate-100 rounded-3xl">
          <div className="w-3/4 flex justify-cente">
            <Chart type="line" data={data} options={options} />
          </div>
        </div>
        <div className="grid grid-cols-2 gap-10 ">
          <div className=" rounded-3xl border-2 bg-slate-100 grid justify-center items-center">
            <h1 className=" font-bold">Bar Chart</h1>
            <Chart type="bar" data={data} options={options} />
          </div>
          <div className=" rounded-3xl border-2 bg-slate-100 grid items-center">
            <h1 className=" font-bold">Doughnut Chart</h1>
            <div className="grid justify-center">
              <div className="w-[470px]">
                <Chart type="doughnut" data={data} options={options} />
              </div>
            </div>
          </div>
        </div>
      </div>
    </Layout>
  );
};

export default DashboardPage;
