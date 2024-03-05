// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyBk6Cxf8TJGUZ0nMd10WvJI4-j_eCIWu4o",
  authDomain: "kmutt-v2.firebaseapp.com",
  projectId: "kmutt-v2",
  storageBucket: "kmutt-v2.appspot.com",
  messagingSenderId: "933381195125",
  appId: "1:933381195125:web:8440cbb2b99ab3b9117f3c",
  measurementId: "G-RVLHGXD2M5"
};


// Initialize Firebase
export const app = initializeApp(firebaseConfig);