import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { ThemeProvider, CssBaseline } from '@mui/material';

import { baselightTheme } from './utils/theme/DefaultColors';
import DashboardLayout from './app/dashBoardLayout/layout';

// 페이지 컴포넌트
import Dashboard from './app/dashBoardLayout/page';
import LoginPage from './app/authentication/login/page';
import RegisterPage from './app/authentication/register/page';
import CargoRequestList from './app/cms/cargo/CargoRequestList';
import CargoRequestDetail from './app/cms/cargo/CargoRequestDetail';
// import ShadowPage from './app/dashBoardLayout/utilities/shadow/page';
import SamplePage from './app/dashBoardLayout/sample-page/page';
import MemberListPage from './app/authentication/role/page';

// ✅ 관리자 보호 라우트
import AdminRoute from './router/AdminRoute';

// 로그인/회원가입 전용 레이아웃
const AuthLayout = ({ children }) => (
  <div style={{ height: '100vh' }}>{children}</div>
);

function App() {
  return (
    <ThemeProvider theme={baselightTheme}>
      <CssBaseline />
      <Router>
        <Routes>
          {/* 기본 경로 → dashboard로 리디렉트 */}
          <Route path="/" element={<Navigate to="/dashboard" replace />} />

          {/* 인증 관련 */}
          <Route path="/authentication/role" element={<DashboardLayout><MemberListPage /></DashboardLayout>} />
          <Route path="/authentication/login" element={<AuthLayout><LoginPage /></AuthLayout>} />
          <Route path="/authentication/register" element={<AuthLayout><RegisterPage /></AuthLayout>} />

          {/* ✅ 관리자 전용 페이지들 */}
          <Route
            path="/dashboard"
            element={
              <AdminRoute>
                <DashboardLayout><Dashboard /></DashboardLayout>
              </AdminRoute>
            }
          />

          <Route
            path="/cms/cargo/CargoRequestList"
            element={
              <AdminRoute>
                <DashboardLayout><CargoRequestList /></DashboardLayout>
              </AdminRoute>
            }
          />

          <Route
            path="/cms/cargo/CargoRequestDetail/:id"
            element={
              <AdminRoute>
                <DashboardLayout><CargoRequestDetail /></DashboardLayout>
              </AdminRoute>
            }
          />

          <Route
            path="/sample-page"
            element={
              <AdminRoute>
                <DashboardLayout><SamplePage /></DashboardLayout>
              </AdminRoute>
            }
          />

          {/* 없는 경로 → login로 */}
          <Route path="*" element={<Navigate to="/authentication/login" replace />} />
        </Routes>
      </Router>
    </ThemeProvider>
  );
}

export default App;
