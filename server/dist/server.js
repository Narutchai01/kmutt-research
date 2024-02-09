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
exports.Connect = exports.conn = void 0;
const express_1 = __importDefault(require("express"));
const config_1 = require("./lib/config");
const promise_1 = __importDefault(require("mysql2/promise"));
const multer_1 = __importDefault(require("multer"));
const cookie_parser_1 = __importDefault(require("cookie-parser"));
const cors_1 = __importDefault(require("cors"));
const Surveyor_1 = __importDefault(require("./routers/Surveyor"));
const Cases_1 = __importDefault(require("./routers/Cases"));
const Customer_1 = __importDefault(require("./routers/Customer"));
const Insurance_1 = __importDefault(require("./routers/Insurance"));
const Cars_1 = __importDefault(require("./routers/Cars"));
const Admin_1 = __importDefault(require("./routers/Admin"));
const app = (0, express_1.default)();
const PORT = config_1.Config.PORT;
app.use(express_1.default.json());
app.use((0, cookie_parser_1.default)());
app.use((0, cors_1.default)({
    origin: true,
    credentials: true,
}));
exports.conn = null;
const Connect = () => __awaiter(void 0, void 0, void 0, function* () {
    exports.conn = yield promise_1.default.createConnection({
        host: config_1.Config.DB_HOST,
        user: config_1.Config.DB_USER,
        password: config_1.Config.DB_PASSWORD,
        database: config_1.Config.DB_NAME,
        port: config_1.Config.DB_PORT,
    });
    console.log("Database Connected");
});
exports.Connect = Connect;
const multerMid = (0, multer_1.default)({
    storage: multer_1.default.memoryStorage(),
});
app.use(multerMid.array("file"));
app.get("/", (req, res) => {
    res.send("Hello World!");
});
app.use("/api/cars", Cars_1.default);
app.use("/api/surveyor", Surveyor_1.default);
app.use("/api/cases", Cases_1.default);
app.use("/api/customer", Customer_1.default);
app.use("/api/insurance", Insurance_1.default);
app.use("/api/admin", Admin_1.default);
app.listen(PORT, () => __awaiter(void 0, void 0, void 0, function* () {
    // await Connect();
    console.log(`⚡️[server]: Server is running at http://localhost:${PORT}`);
}));
