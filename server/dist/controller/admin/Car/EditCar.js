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
exports.EditCar = void 0;
const ChackDataEdit_1 = require("../../../utils/ChackDataEdit");
const server_1 = require("./../../../server");
const EditCar = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { id, province } = req.params;
        const { Brand, Model, Color } = req.body;
        const sqlFindCar = `SELECT * FROM Car WHERE CarID = ? AND Province = ?`;
        const updatesql = `UPDATE Car SET  Brand = ?, Model = ?, Color = ? WHERE CarID = ? AND Province = ?`;
        yield (0, server_1.Connect)();
        const findCar = yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(sqlFindCar, [id, province]));
        if (findCar.length === 0) {
            res.status(404).json({ message: "Car not found" });
            return;
        }
        const data = {
            Brand: (0, ChackDataEdit_1.CheckDataEdit)(Brand) ? Brand : findCar[0][0].Brand,
            Model: (0, ChackDataEdit_1.CheckDataEdit)(Model) ? Model : findCar[0][0].Model,
            Color: (0, ChackDataEdit_1.CheckDataEdit)(Color) ? Color : findCar[0][0].Color,
        };
        yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(updatesql, [
            data.Brand,
            data.Model,
            data.Color,
            id,
            province,
        ]));
        res.status(200).json({ message: "Edit car success", data });
    }
    catch (error) {
        console.log(error);
    }
});
exports.EditCar = EditCar;
