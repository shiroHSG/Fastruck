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

        // 관리자 권한 확인 (ADMIN 외 다른 권한 방지용 if-else)
        if (user?.role === 'ADMIN') {
          setIsAdmin(true);
        } else {
          setIsAdmin(false);
        }

      } catch (e) {
        console.warn('인증 정보 불러오기 실패:', e);
        setIsAdmin(false); // 예외 발생 시 관리자 아님으로 처리
      } finally {
        setLoading(false);
      }
    };

    checkRole();
  }, []);

  return { isLoading, isAdmin };
};

export default useAdminAuth;
