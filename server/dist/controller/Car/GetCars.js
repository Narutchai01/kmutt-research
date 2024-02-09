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
exports.GetCars = void 0;
const server_1 = require("../../server");
const GetCars = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        yield (0, server_1.Connect)();
        const sql = 'SELECT Car.CarID , Car.Province , Customer.First_name , Customer.Last_name , Insurance.Policy_type  ,Car.image  FROM Customer JOIN Car USING(CustomerID) JOIN Insurance USING(Policy_number);';
        const result = yield (server_1.conn === null || server_1.conn === void 0 ? void 0 : server_1.conn.query(sql));
        if (!result[0]) {
            res.status(404).json({ message: 'Not Found' });
        }
        res.status(200).send(result[0]);
    }
    catch (error) {
        console.log(error);
    }
});
exports.GetCars = GetCars;
