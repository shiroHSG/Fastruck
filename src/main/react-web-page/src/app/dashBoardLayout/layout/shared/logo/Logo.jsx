import React from "react";
import { styled } from "@mui/material";
import { Link } from "react-router-dom";

const LogoWrapper = styled("div")(() => ({
  height: "70px",
  width: "180px",
  overflow: "hidden",
  display: "block",
}));

const Logo = () => {
  return (
    <LogoWrapper>
      <Link to="/">
        <img
          src="/images/logos/dark-logo.svg"
          alt="logo"
          height="70"
          width="174"
          style={{ display: "block" }}
        />
      </Link>
    </LogoWrapper>
  );
};

export default Logo;
