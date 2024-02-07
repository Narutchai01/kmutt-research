// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyAKKnnV0qbJOvOsRwyIfeTDNbfVv92ft68",
  authDomain: "test-kmutt.firebaseapp.com",
  projectId: "test-kmutt",
  storageBucket: "test-kmutt.appspot.com",
  messagingSenderId: "515520505868",
  appId: "1:515520505868:web:04d627dd3301463ed2e629",
  measurementId: "G-99G9Y4SR9J"
};

// Initialize Firebase
export const app = initializeApp(firebaseConfig);