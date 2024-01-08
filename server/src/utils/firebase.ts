import  { initializeApp, cert } from "firebase-admin/app";
import { getStorage } from "firebase-admin/storage";
import {firebaseConfig} from "../lib/FirebaseConFig";


const serviceAccount = firebaseConfig;




initializeApp({
  credential: cert(serviceAccount),
  storageBucket: "gs://kmutt-recearch.appspot.com",
});

const bucket = getStorage().bucket('my-custom-bucket');