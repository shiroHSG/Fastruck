// src/api/authApi.js
import axios from 'axios';

const BASE_URL = 'http://localhost:8080/api/member'; // 백엔드 주소

// 로그인
export const login = async (email, password) => {
  try {
    const response = await axios.post(`${BASE_URL}/login`, {
      email,
      password,
    });
    return response.data; // accessToken, refreshToken, memberId
  } catch (error) {
    throw error.response?.data?.message || '로그인 실패';
  }
};

// 회원가입
export const register = async (memberData, imageFile) => {
  const formData = new FormData();
  formData.append("memberData", JSON.stringify(memberData));
  if (imageFile) {
    formData.append("image", imageFile);
  }

  const response = await axios.post(
    "http://localhost:8080/api/member/register",
    formData,
    {
      headers: {
        "Content-Type": "multipart/form-data",
      },
    }
  );
  return response.data;
};

// ✅ 전체 회원 조회 (관리자용)
export const fetchAllMembers = async () => {
  const response = await axios.get(`${BASE_URL}/all`);
  return response.data;
};

// ✅ 권한 변경
export const updateMemberRole = async (memberId, newRole) => {
  const response = await axios.put(`${BASE_URL}/${memberId}/role`, {
    role: newRole,
  });
  return response.data;
};