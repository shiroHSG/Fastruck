// src/router/AdminRoute.jsx
import React from 'react';
import { Navigate } from 'react-router-dom';
import useAdminAuth from '../hooks/useAdminAuth';

const AdminRoute = ({ children }) => {
  const { isLoading, isAdmin } = useAdminAuth();

  if (isLoading) return <div>로딩 중...</div>;

  if (!isAdmin) {
    alert('접근 권한이 없습니다.');
    return <Navigate to="/login" />;
  }

  return children;
};

export default AdminRoute;
