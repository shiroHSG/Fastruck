import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { ThemeProvider, CssBaseline } from '@mui/material';

import { baselightTheme } from './utils/theme/DefaultColors';
import DashboardLayout from './app/dashBoardLayout/layout';

// 페이지 컴포넌트
import Dashboard from './app/dashBoardLayout/page';
import LoginPage from './app/authentication/login/page';
import RegisterPage from './app/authentication/register/page';

// 로그인/회원가입 전용 레이아웃 (별도 레이아웃이 없다면 생략 가능)
const AuthLayout = ({ children }) => (
  <div style={{ height: '100vh' }}>{children}</div>
);

function App() {
  return (
    <ThemeProvider theme={baselightTheme}>
      <CssBaseline />
      <Router>
        <Routes>
          {/* ✅ "/" 접속 시 로그인 페이지로 리다이렉션 */}
          <Route path="/" element={<Navigate to="/authentication/login" replace />} />

          <Route path="/authentication/login" element={<AuthLayout><LoginPage /></AuthLayout>} />
          <Route path="/dashboard" element={<DashboardLayout><Dashboard /></DashboardLayout>} />
          <Route path="/authentication/register" element={<AuthLayout><RegisterPage /></AuthLayout>} />
        </Routes>
      </Router>
    </ThemeProvider>
  );
}

export default App;
