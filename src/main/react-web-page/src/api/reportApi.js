import axiosInstance from './axiosInstance';

const ReportApi = {
  // 신고 통계 조회 (차주별 신고 수)
  getStatistics: () => axiosInstance.get('api/reports/admin/statistics'),

  // 전체 신고 리스트
  getAllReports: () => axiosInstance.get('api/reports/admin'),

  // 특정 신고 상세 조회
  getReportDetail: (reportId) => axiosInstance.get(`api/reports/${reportId}`),

  // 신고 생성 (화주 → 차주)
  createReport: (contractId, data) =>
    axiosInstance.post(`api/reports/contract/${contractId}`, data),

    // 경고 전송 API
  sendWarning: (receiverId, title, content) =>
    axiosInstance.post('api/notices/admin', {
      receiverId,
      title,
      content,
      messageType: 'WARNING'
    })
};

export default ReportApi;
