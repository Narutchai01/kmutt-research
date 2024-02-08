import axios from "axios";


const api = import.meta.env.VITE_REACT_APP_BACKEND_URL



export const axiosInstance = axios.create({
  baseURL: api ?? "http://localhost:8080" ,
  withCredentials: true,
});
