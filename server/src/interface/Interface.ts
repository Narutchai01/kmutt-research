export interface ICONFIG {
    DB_URL: string;
    PORT: number;
}


export interface test_db {
    TEST_DB_HOST: string;
    TEST_DB_USER: string;
    TEST_DB_PASSWORD: string;
    TEST_DB_NAME: string;
    TEST_DB_PORT: number;
    
}

export interface SurveyorData {
    SurveyorID: string;
    First_name: string;
    Last_name: string;
    Phone_number: string;
    email: string;
    PassWord: string;
}