export const CheckDataEdit = (data: any) => {
    if (typeof data !== "string") {
        return false;
    }
    const newData = data.split(" ").join("");
    switch (newData.length ) {
        case 0:
            return false;
        default:
            return true;
    }
};