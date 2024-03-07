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
exports.GetcaseByCaseID = void 0;
const server_1 = require("../../server");
const GetcaseByCaseID = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { caseID } = req.query;
        yield (0, server_1.Connect)();
        const sql = `SELECT * FROM Cases WHERE CaseID = ?`;
        const result = yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(sql, [caseID]));
        res.status(200).send(result[0]);
    }
    catch (error) {
        console.log(error);
    }
});
exports.GetcaseByCaseID = GetcaseByCaseID;
