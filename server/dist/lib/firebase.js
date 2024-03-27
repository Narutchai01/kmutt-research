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
    apiKey: "AIzaSyD42yjFKk5kQGBgO5fV66MuYa3NVBXaixY",
    authDomain: "kmuttv3.firebaseapp.com",
    projectId: "kmuttv3",
    storageBucket: "kmuttv3.appspot.com",
    messagingSenderId: "533406544389",
    appId: "1:533406544389:web:7861d1c460cb934885226c",
    measurementId: "G-RSP7KPBZTJ"
};
// Initialize Firebase
exports.app = (0, app_1.initializeApp)(firebaseConfig);
