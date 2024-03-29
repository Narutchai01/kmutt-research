"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.auth = void 0;
const auth = (req, res, next) => {
    try {
        const token = req.cookies.token;
        if (!token)
            return res.status(401).json({ errorMessage: "Unauthorized" });
        next();
    }
    catch (error) {
        console.log(error);
    }
};
exports.auth = auth;
