// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyAeeNNvw4eK3hrWFJMIR8Wc9lyy5qoHGF8",
  authDomain: "kmutt-recearch.firebaseapp.com",
  projectId: "kmutt-recearch",
  storageBucket: "kmutt-recearch.appspot.com",
  messagingSenderId: "57933910102",
  appId: "1:57933910102:web:8bdc35401b6afe6676ebf7",
  measurementId: "G-QNKRDE1M55"
};

// Initialize Firebase
export const app = initializeApp(firebaseConfig);