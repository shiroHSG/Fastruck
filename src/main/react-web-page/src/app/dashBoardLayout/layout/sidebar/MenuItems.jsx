import {
  IconAperture,
  IconCopy,
  IconLayoutDashboard,
  IconLogin,
  IconMoodHappy,
  IconTypography,
  IconUserPlus,
  IconUsers,
} from "@tabler/icons-react";

import { uniqueId } from "lodash";

const Menuitems = [
  {
    navlabel: true,
    subheader: "HOME",
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
    title: "Typography",
    icon: IconTypography,
    href: "/utilities/typography",
  },
  {
    id: uniqueId(),
    title: "Shadow",
    icon: IconCopy,
    href: "/utilities/shadow",
  },
  {
    navlabel: true,
    subheader: " 신고 & 평가 관리",
  },
  {
    id: uniqueId(),
    title: "Icons",
    icon: IconMoodHappy,
    href: "/icons",
  },
  {
    id: uniqueId(),
    title: "Sample Page",
    icon: IconAperture,
    href: "/sample-page",
  },

];

export default Menuitems;


