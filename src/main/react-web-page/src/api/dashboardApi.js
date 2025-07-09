// src/api/dashboardApi.js
import axiosInstance from './axiosInstance';

export const getMonthlyEarnings = async (year) => {
  const response = await axiosInstance.get(
    `/api/bid-proposals/monthly-earnings?year=${year}`
  );
  return response.data; // ✅ 확인 필요
  
};

// ✅ 추가: 연도별 회원 수 통계 (PieChart용)
export const getUserStatsByYear = async (year) => {
  const response = await axiosInstance.get(
    `/api/member/count/by-year?year=${year}`
  );
  return response.data;
};

// ✅ 추가: 최근 계약 5건 불러오기
export const getLatestContracts = async () => {
  const response = await axiosInstance.get(`/api/dashboard/recent`);
  return response.data;
};