import React from "react";
import { Card } from "@mui/material";

const BlankCard = ({ children, className }) => {
  return (
    <Card
      sx={{ p: 0, position: "relative" }}
      className={className}
      elevation={9}
    >
      {children}
    </Card>
  );
};

export default BlankCard;
