export type LoginData = {
  Email: string;
  Password: string;
};
export interface AdminData {
  AdminID: number;
  First_name: string;
  Last_name: string;
  Image: string;
  Birth_date: string;
  Phone_number: string;
  Email: string;
  Password: string;
}

export interface SurveyData {
  SurveyorID: number;
  First_name: string;
  Last_name: string;
  Email: string;
}

export interface CarData {
  CarID: string;
  Province: string;
  First_name: string;
  Last_name: string;
  Policy_type: string;
  image: string;
}
export interface InsuranceData {
  Policy_number: string;
  CustomerID: number;
  Policy_type: string;
  Start_date: string;
  End_date: string;
  CarID: string;
  Province: string;
}

export interface CaseData {
  CaseID: string;
  SurveyorID: number;
  CarID: string;
  Province: string;
  Date_opened: string;
  Status: string;
  Description: string;
}

export interface CustomerData {
  CustomerID: number;
  First_name: string;
  Last_name: string;
  Address: string;
  Phone_number: string;
  Email: string;
  Line: string;
  Image: string;
}

export interface SurveyorByIDData {
  SurveyorID: number;
  First_name: string;
  Last_name: string;
  Image: string;
  Birth_date: string;
  Phone_number: string;
  Email: string;
  Password: string;
}

export interface CaseBySurveyorIDData {
  CaseID: string;
  SurveyorID: number;
  CarID: string;
  Province: string;
  Date_opened: Date;
  Status: string;
  Description: Date;
}
