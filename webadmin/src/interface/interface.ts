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