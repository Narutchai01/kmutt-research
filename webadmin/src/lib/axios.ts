import axios from "axios";
import dotenv from "dotenv";

dotenv.config();

const API = import.meta.env.VITE_REACT_APP_BACKEND_URL;

export const axiosInstance = axios.create({
  baseURL: "http://localhost:8080" || API,
  withCredentials: true,
});
