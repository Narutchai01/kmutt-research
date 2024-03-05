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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.CreateCase = void 0;
const server_1 = require("../../server");
const uuid_1 = require("uuid");
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const UploadImage_1 = require("../../utils/UploadImage");
const axios_1 = __importDefault(require("axios"));
const CreateCase = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        yield server_1.client.connect();
        yield (0, server_1.Connect)();
        const token = req.params.token;
        const secert = process.env.JWT_SECRET;
        const decoded = jsonwebtoken_1.default.verify(token, secert);
        const CaseID = (0, uuid_1.v4)();
        const { CarID, Province, Description } = req.body;
        const Images = req.files;
        const addCase = `INSERT INTO Cases (CaseID, SurveyorID, CarID, Province, Description) VALUES (?,?,?,?,?)`;
        const addImageCase = `INSERT INTO Image (CaseID , Image_link) VALUES (?,?)`;
        let reportArr = [];
        const ImageArr = [];
        const DataCase = {
            CaseID,
            SurveyorID: decoded.ID,
            CarID,
            Province,
            Description,
        };
        yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(addCase, [
            DataCase.CaseID,
            DataCase.SurveyorID,
            DataCase.CarID,
            DataCase.Province,
            DataCase.Description,
        ]));
        yield Promise.all(Images.map((file) => __awaiter(void 0, void 0, void 0, function* () {
            const url = yield (0, UploadImage_1.upLoadImageCase)(file.buffer);
            ImageArr.push(url);
            const DataImageCase = {
                CaseID: CaseID,
                Image_link: url,
            };
            yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(addImageCase, [
                DataImageCase.CaseID,
                DataImageCase.Image_link,
            ]));
        })));
        yield axios_1.default.post(`http://car-service-elb-1427198968.ap-southeast-1.elb.amazonaws.com/predict`, {
            urls: ImageArr,
            car_part_conf_thres: 0.3,
            car_part_iou_thres: 0.5,
            car_damage_conf_thres: 0.3,
            car_damage_iou_thres: 0.5,
        }).then((response) => {
            reportArr.push(response.data);
        }).catch((error) => { console.log(error); });
        if (reportArr.length != 0) {
            const updateSQL = `UPDATE Cases SET Status = 'Success' WHERE CaseID = ?`;
            yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(updateSQL, [CaseID]));
        }
        const data = {
            CaseID: CaseID,
            report: reportArr
        };
        yield server_1.client.db("kmutt").collection("report").insertOne(data);
        res.status(200).json({
            ImageArr,
            data
        });
    }
    catch (error) {
        console.log(error);
    }
});
exports.CreateCase = CreateCase;
