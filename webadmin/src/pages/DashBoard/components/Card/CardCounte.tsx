import React from "react";

interface CardCounteProps {
  title: string;
  value: number;
}



const CardCounte:React.FC<CardCounteProps> = ({title,value}) => {
  return (
    <>
      <div className=" rounded-lg border-2 h-20 w-72 px-8">
        <h1 className="text-xl font-semibold">{title}</h1>
        <span className="text-4xl font-bold">{value}</span>
      </div>
    </>
  );
};

export default CardCounte;
