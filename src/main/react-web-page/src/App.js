import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { ThemeProvider, CssBaseline } from '@mui/material';

import { baselightTheme } from './utils/theme/DefaultColors';
import DashboardLayout from './app/dashBoardLayout/layout';

// 페이지 컴포넌트
import Dashboard from './app/dashBoardLayout/page';
import LoginPage from './app/authentication/login/page';
import RegisterPage from './app/authentication/register/page';
import TypographyPage from './app/dashBoardLayout/utilities/typography/page';
import ShadowPage from './app/dashBoardLayout/utilities/shadow/page';
import Icons from './app/dashBoardLayout/icons/page';
import SamplePage from './app/dashBoardLayout/sample-page/page';
import MemberListPage from './app/authentication/role/page';

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
          {/* 정확히 "/" 일 때만 dashboard로 리다이렉션 */}
          <Route path="/" element={<Navigate to="/dashboard" replace />} />

          {/* 인증 관련 */}
          <Route path="/authentication/role" element={<DashboardLayout><MemberListPage /></DashboardLayout>} />
          <Route path="/authentication/login" element={<AuthLayout><LoginPage /></AuthLayout>} />
          <Route path="/authentication/register" element={<AuthLayout><RegisterPage /></AuthLayout>} />

          {/* 대시보드 */}
          <Route path="/dashboard" element={<DashboardLayout><Dashboard /></DashboardLayout>} />

          {/* 향후 typography, shadow, etc. 라우트도 여기에 추가 필요 */}
          <Route path="/utilities/typography" element={<DashboardLayout><TypographyPage /></DashboardLayout>} />
          <Route path="/utilities/shadow" element={<DashboardLayout><ShadowPage /></DashboardLayout>} />
          <Route path="/icons" element={<DashboardLayout><Icons /></DashboardLayout>} />
          <Route path="/sample-page" element={<DashboardLayout><SamplePage /></DashboardLayout>} />

          {/* 없는 경로일 경우 리다이렉트 */}
          <Route path="*" element={<Navigate to="/dashboard" replace />} />
        </Routes>
      </Router>
    </ThemeProvider>
  );
}


export default App;
