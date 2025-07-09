// src/hooks/useAdminAuth.js
import { useEffect, useState } from 'react';
import { fetchMyInfo } from '../api/authApi';

const useAdminAuth = () => {
  const [isLoading, setLoading] = useState(true);
  const [isAdmin, setIsAdmin] = useState(false);

  useEffect(() => {
    const checkRole = async () => {
      try {
        const user = await fetchMyInfo();
        if (user.role === 'ADMIN') {
          setIsAdmin(true);
        }
      } catch (e) {
        console.warn('인증 정보 불러오기 실패:', e);
      } finally {
        setLoading(false);
      }
    };

    checkRole();
  }, []);

  return { isLoading, isAdmin };
};

export default useAdminAuth;
