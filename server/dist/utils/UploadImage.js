"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.upLoadImageCustomer = exports.upLoadImageCar = exports.upLoadImageCase = exports.uploadImageSurveyor = void 0;
const storage_1 = require("firebase/storage");
const firebase_1 = require("../lib/firebase");
const uuid_1 = require("uuid");
const metadata = {
    contentType: "image/jpeg",
};
const uploadImageSurveyor = (file) => __awaiter(void 0, void 0, void 0, function* () {
    const storage = (0, storage_1.getStorage)(firebase_1.app);
    const storageRef = (0, storage_1.ref)(storage, `imagesSurveyor/${(0, uuid_1.v4)()}`);
    const snapshot = yield (0, storage_1.uploadBytes)(storageRef, file, metadata);
    const url = yield (0, storage_1.getDownloadURL)(snapshot.ref);
    return url;
});
exports.uploadImageSurveyor = uploadImageSurveyor;
const upLoadImageCase = (file) => __awaiter(void 0, void 0, void 0, function* () {
    const storage = (0, storage_1.getStorage)(firebase_1.app);
    const storageRef = (0, storage_1.ref)(storage, `imagesCase/${(0, uuid_1.v4)()}`);
    const snapshot = yield (0, storage_1.uploadBytes)(storageRef, file, metadata);
    const url = yield (0, storage_1.getDownloadURL)(snapshot.ref);
    return url;
});
exports.upLoadImageCase = upLoadImageCase;
const upLoadImageCar = (file) => __awaiter(void 0, void 0, void 0, function* () {
    const storage = (0, storage_1.getStorage)(firebase_1.app);
    const storageRef = (0, storage_1.ref)(storage, `imagesCar/${(0, uuid_1.v4)()}`);
    const snapshot = yield (0, storage_1.uploadBytes)(storageRef, file, metadata);
    const url = yield (0, storage_1.getDownloadURL)(snapshot.ref);
    return url;
});
exports.upLoadImageCar = upLoadImageCar;
const upLoadImageCustomer = (file) => __awaiter(void 0, void 0, void 0, function* () {
    const storage = (0, storage_1.getStorage)(firebase_1.app);
    const storageRef = (0, storage_1.ref)(storage, `imagesCustomer/${(0, uuid_1.v4)()}`);
    const snapshot = yield (0, storage_1.uploadBytes)(storageRef, file, metadata);
    const url = yield (0, storage_1.getDownloadURL)(snapshot.ref);
    return url;
});
exports.upLoadImageCustomer = upLoadImageCustomer;
