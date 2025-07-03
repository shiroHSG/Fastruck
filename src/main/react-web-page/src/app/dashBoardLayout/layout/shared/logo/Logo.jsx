import React from "react";
import { styled } from "@mui/material";
import { Link } from "react-router-dom";

const LogoWrapper = styled("div")(() => ({
  height: "70",
  width: "150",
  overflow: "hidden",
  display: "block",
}));

const Logo = () => {
  return (
    <LogoWrapper>
      <Link >
        <img
          src={process.env.PUBLIC_URL + "/logo/logo1.png"}
          alt="logo"
          height="200"
          width="150"
          style={{ display: "block" }}
        />
      </Link>
    </LogoWrapper>
  );
};

export default Logo;
