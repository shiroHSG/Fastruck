// src/api/cms.js
import axios from './axiosInstance'; // 공통 axios 인스턴스 사용

const CARGO_BASE = '/api/cargo-requests';
const BID_BASE = '/api/bid-proposals';

/**
 * ✅ 조건부 화물 요청 목록 조회
 * - 출발지 또는 도착지가 있으면 검색 API 호출
 * - 없으면 전체 목록 API 호출
 */
export const fetchCargoRequests = async (departureLocation, arrivalLocation) => {
  const hasFilter = departureLocation || arrivalLocation;
  const endpoint = hasFilter ? `${CARGO_BASE}/search` : `${CARGO_BASE}/all`;

  const response = await axios.get(endpoint, {
    params: {
      departureLocation: departureLocation || undefined,
      arrivalLocation: arrivalLocation || undefined,
    },
  });

  return response.data;
};

// ✅ 화물 요청 상세 조회
export const fetchCargoRequestById = async (id) => {
  const response = await axios.get(`${CARGO_BASE}/${id}`);
  return response.data;
};

// ✅ 특정 화물 요청의 입찰 제안 목록
export const fetchBidProposalsByCargo = async (cargoRequestId) => {
  const response = await axios.get(`${BID_BASE}/by-cargo`, {
    params: { cargoRequestId }
  });
  return response.data;
};

// ✅ 전체 화물 요청 목록 (관리자용 - 강제 전체조회용)
export const fetchAllCargoRequests = async () => {
  const response = await axios.get(`${CARGO_BASE}/all`);
  return response.data;
};
