import axios from './axiosInstance';

const BASE_URL = '/api/member';

// ✅ 로그인
export const login = async (email, password) => {
  try {
    const response = await axios.post(`${BASE_URL}/login`, {
      email,
      password,
    }, {
      withCredentials: true
    });

    const { accessToken } = response.data;
    localStorage.setItem('accessToken', accessToken);
    return response.data;
  } catch (error) {
    const message = error.response?.data?.message || '로그인 실패';
    throw new Error(message);
  }
};

// ✅ 로그아웃
export const logout = async () => {
  try {
    await axios.post(`${BASE_URL}/logout`, {}, { withCredentials: true });
  } catch (e) {
    console.warn('서버 로그아웃 실패:', e);
  }
  localStorage.removeItem('accessToken');
  window.location.href = '/login';
};

// ✅ 회원가입
export const register = async (memberData, imageFile) => {
  const formData = new FormData();
  formData.append('memberData', JSON.stringify(memberData));
  if (imageFile) {
    formData.append('image', imageFile);
  }

  const response = await axios.post(
    `${BASE_URL}/register`,
    formData,
    {
      headers: { 'Content-Type': 'multipart/form-data' },
    }
  );
  return response.data;
};

// ✅ 전체 회원 조회
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

// ✅ 내 정보 조회
export const fetchMyInfo = async () => {
  const res = await axios.get(`${BASE_URL}/me`);
  return res.data;
};
