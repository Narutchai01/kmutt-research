import { getStorage, getDownloadURL, uploadBytes, ref } from "firebase/storage";
import { app } from "../lib/firebase";
import { v4 as uuidv4 } from "uuid";

const metadata = {
  contentType: "image/jpeg",
};

export const uploadImageSurveyor = async (file: File) => {
  const storage = getStorage(app);
  const storageRef = ref(storage, `imagesSurveyor/${uuidv4()}`);
  const snapshot = await uploadBytes(storageRef, file, metadata);
  const url = await getDownloadURL(snapshot.ref);
  return url;
};


export const upLoadImageCase = async (file: File) => {
    const storage = getStorage(app);
    const storageRef = ref(storage, `imagesCase/${uuidv4()}`);
    const snapshot = await uploadBytes(storageRef, file, metadata);
    const url = await getDownloadURL(snapshot.ref);
    return url;
};

export const upLoadImageCar = async (file: File) => {
    const storage = getStorage(app);
    const storageRef = ref(storage, `imagesCar/${uuidv4()}`);
    const snapshot = await uploadBytes(storageRef, file, metadata);
    const url = await getDownloadURL(snapshot.ref);
    return url;
};