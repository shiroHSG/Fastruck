import React from 'react';
import {
  Box,
  AppBar,
  Toolbar,
  styled,
  Stack,
  IconButton,
  Badge,
  Button
} from '@mui/material';
import { IconBellRinging, IconMenu } from '@tabler/icons-react';
import Profile from './Profile';

const AppBarStyled = styled(AppBar)(({ theme }) => ({
  boxShadow: 'none',
  background: theme.palette.background.paper,
  justifyContent: 'center',
  backdropFilter: 'blur(4px)',
  [theme.breakpoints.up('lg')]: {
    minHeight: '70px',
  },
}));

const ToolbarStyled = styled(Toolbar)(({ theme }) => ({
  width: '100%',
  color: theme.palette.text.secondary,
}));

function Header({ toggleSidebar, toggleMobileSidebar }) {
  return (
    <AppBarStyled position="sticky" color="default">
      <ToolbarStyled>

        {/* ✅ 데스크탑용 토글 버튼 */}
        <IconButton
          color="inherit"
          aria-label="toggle sidebar"
          onClick={toggleSidebar}
          sx={{
            display: {
              lg: 'inline-flex',
              xs: 'none',
            },
          }}
        >
          <IconMenu width="20" height="20" />
        </IconButton>

        {/* ✅ 모바일용 햄버거 메뉴 */}
        <IconButton
          color="inherit"
          aria-label="menu"
          onClick={toggleMobileSidebar}
          sx={{
            display: {
              lg: 'none',
              xs: 'inline',
            },
          }}
        >
          <IconMenu width="20" height="20" />
        </IconButton>

        {/* 알림 */}
        <IconButton
          size="large"
          aria-label="show notifications"
          color="inherit"
        >
          <Badge variant="dot" color="primary">
            <IconBellRinging size="21" stroke="1.5" />
          </Badge>
        </IconButton>

        <Box flexGrow={1} />

        {/* 우측 영역: 로그인 버튼 + 프로필 */}
        <Stack spacing={1} direction="row" alignItems="center">
          <Button
            variant="contained"
            href="/authentication/login"
            disableElevation
            color="primary"
          >
            Login
          </Button>
          <Profile />
        </Stack>
      </ToolbarStyled>
    </AppBarStyled>
  );
}

export default Header;
