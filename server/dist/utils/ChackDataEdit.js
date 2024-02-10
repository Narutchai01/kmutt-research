"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.CheckDataEdit = void 0;
const CheckDataEdit = (data) => {
    if (typeof data !== "string") {
        return false;
    }
    const newData = data.split(" ").join("");
    switch (newData.length) {
        case 0:
            return false;
        default:
            return true;
    }
};
exports.CheckDataEdit = CheckDataEdit;
