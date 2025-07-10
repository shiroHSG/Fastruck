import React from "react";
import Menuitems from "./MenuItems";
import { Box } from "@mui/material";
import {
  Logo,
  Sidebar as MUI_Sidebar,
  Menu,
  MenuItem,
  Submenu,
} from "react-mui-sidebar";
import { IconPoint } from "@tabler/icons-react";
import { Link, useLocation } from "react-router-dom";
import { Upgrade } from "./Updrade";
import logo_icon from "../shared/logo/Logo";

const renderMenuItems = (items, currentPath) => {
  return items.map((item) => {
    const Icon = item.icon || IconPoint;
    const itemIcon = <Icon stroke={1.5} size="1.3rem" />;

    if (item.subheader) {
      return <Menu subHeading={item.subheader} key={item.subheader} />;
    }

    if (item.children) {
      return (
        <Submenu
          key={item.id}
          title={item.title}
          icon={itemIcon}
          borderRadius="7px"
        >
          {renderMenuItems(item.children, currentPath)}
        </Submenu>
      );
    }

    return (
      <Box px={3} key={item.id}>
        <Link to={item.href} style={{ textDecoration: 'none', color: 'inherit' }}>
          <MenuItem
            isSelected={currentPath === item.href}
            borderRadius="8px"
            icon={itemIcon}
          >
            {item.title}
          </MenuItem>
        </Link>
      </Box>
    );
  });
};

const SidebarItems = () => {
  const location = useLocation();
  const currentPath = location.pathname;

  return (
    <MUI_Sidebar
      width={"100%"}
      showProfile={false}
      themeColor={"#5D87FF"}
      themeSecondaryColor={"#49beff"}
    >
      {/* <Logo img="/images/logo/logo1.png" component={Link} to="/">
        Modernize
      </Logo> */}
      <Box
        sx={{
          width: '100%',
          aspectRatio: '3 / 1',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          overflow: 'hidden',
          backgroundColor: '#fff',
        }}
      >
        <Box
          component="img"
          src="../../../../logo/logo1.png"
          alt="Logo"
          sx={{
            height: '200%',         // PNG 여백이 클 경우 확대
            width: 'auto',
            objectFit: 'cover',
            transform: 'translateY(5%)', // 미세 조정
          }}
        />
      </Box>

      {renderMenuItems(Menuitems, currentPath)}

      <Box px={2}>
        <Upgrade />
      </Box>
    </MUI_Sidebar>
  );
};

export default SidebarItems;
