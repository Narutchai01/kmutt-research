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
exports.EditSurveyor = void 0;
const server_1 = require("../../../server");
const ChackDataEdit_1 = require("../../../utils/ChackDataEdit");
const EditSurveyor = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const id = req.params.id;
        const { First_name, Last_name, Birthday, Emaill, Telephone, Password } = req.body;
        const findsurveyorSQL = `SELECT * FROM Surveyor WHERE SurveyorID = ?`;
        const updateSQL = `UPDATE Surveyor SET First_name = ? , Last_name = ? , Birth_date = ? , Email = ? , Phone_number = ? , Password = ? WHERE SurveyorID = ?`;
        yield (0, server_1.Connect)();
        const findSurveyorBYID = yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(findsurveyorSQL, [id]));
        const data = {
            First_name: (yield (0, ChackDataEdit_1.CheckDataEdit)(First_name)) ? First_name : findSurveyorBYID[0][0].First_name,
            Last_name: (yield (0, ChackDataEdit_1.CheckDataEdit)(Last_name)) ? Last_name : findSurveyorBYID[0][0].Last_name,
            Birthday: (yield (0, ChackDataEdit_1.CheckDataEdit)(Birthday)) ? Birthday : findSurveyorBYID[0][0].Birthday,
            Email: (yield (0, ChackDataEdit_1.CheckDataEdit)(Emaill)) ? Emaill : findSurveyorBYID[0][0].Email,
            Telephone: (yield (0, ChackDataEdit_1.CheckDataEdit)(Telephone)) ? Telephone : findSurveyorBYID[0][0].Telephone,
            Password: (yield (0, ChackDataEdit_1.CheckDataEdit)(Password)) ? Password : findSurveyorBYID[0][0].Password,
        };
        yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(updateSQL, [data.First_name, data.Last_name, data.Birthday, data.Email, data.Telephone, data.Password, id]));
        res.status(200).json({ message: "Update Success" });
    }
    catch (error) {
        console.log(error);
    }
});
exports.EditSurveyor = EditSurveyor;
