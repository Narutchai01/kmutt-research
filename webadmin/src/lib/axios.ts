import axios from "axios";

export const axiosInstance = axios.create({
  baseURL:"http://localhost:8080/" || import.meta.env.VITE_REACT_APP_BACKEND_URL, 
  withCredentials: true,
});
