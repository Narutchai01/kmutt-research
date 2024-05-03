"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.app = void 0;
// Import the functions you need from the SDKs you need
const app_1 = require("firebase/app");
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries
// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
    apiKey: "AIzaSyDrYIcK95ucuetxzbA_hwNDIjsl_FVnvPQ",
    authDomain: "kmuttv4.firebaseapp.com",
    projectId: "kmuttv4",
    storageBucket: "kmuttv4.appspot.com",
    messagingSenderId: "504666427655",
    appId: "1:504666427655:web:ad1295a04ffadef74435a2",
    measurementId: "G-C2VZZWMP1Z"
};
// Initialize Firebase
exports.app = (0, app_1.initializeApp)(firebaseConfig);
