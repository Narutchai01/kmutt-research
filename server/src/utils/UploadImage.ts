import { getStorage ,getDownloadURL,uploadBytes ,ref } from "firebase/storage";
import { app } from "../lib/firebase";
import { v4 as uuidv4 } from 'uuid';

export const uploadImage = async (file:File) => {
    const storage = getStorage(app);
    const storageRef = ref(storage,`images/${uuidv4()}`);
    const snapshot = await uploadBytes(storageRef, file);
    const url = await getDownloadURL(snapshot.ref);
    return url;
};
