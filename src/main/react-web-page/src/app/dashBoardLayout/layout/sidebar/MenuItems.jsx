import {
  IconAperture,
  IconCopy,
  IconLayoutDashboard,
  IconTypography,
  IconUserPlus,
  IconUsers,
} from "@tabler/icons-react";

import { uniqueId } from "lodash";

const Menuitems = [
  {
    navlabel: true,
    subheader: "대시보드",
  },

  {
    id: uniqueId(),
    title: "Dashboard",
    icon: IconLayoutDashboard,
    href: "/dashboard",
  },
    {
    navlabel: true,
    subheader: " 사용자 관리",
  },
  {
    id: uniqueId(),
    title: "사용자 역할 변경",
    icon: IconUsers,
    href: "/authentication/Role",
  },
  {
    id: uniqueId(),
    title: "사용자 생성",
    icon: IconUserPlus,
    href: "/authentication/register",
  },
  {
    navlabel: true,
    subheader: " 계약 진행 현황",
  },
  {
    id: uniqueId(),
    title: "화물요청 목록",
    icon: IconTypography,
    href: "/cms/cargo/CargoRequestList",
  },
  {
    navlabel: true,
    subheader: " 신고 & 평가 관리",
  },
  {
    id: uniqueId(),
    title: "신고 목록",
    icon: IconCopy,
    href: "/report",
  },
  {
    navlabel: true,
    subheader: " Read Me",
  },
  {
    id: uniqueId(),
    title: "Sample Page",
    icon: IconAperture,
    href: "/sample-page",
  },

];

export default Menuitems;


