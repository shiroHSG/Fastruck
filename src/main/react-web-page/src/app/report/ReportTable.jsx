'use client';
import React, { useEffect, useState } from 'react';
import {
  Table, TableHead, TableBody, TableRow, TableCell,
  TableContainer, Paper, Typography, CircularProgress, Box
} from '@mui/material';
import ReportApi from '../../api/reportApi';
import ReportDetailModal from './ReportDetailModal';

const ReportTable = () => {
  const [reports, setReports] = useState([]);
  const [loading, setLoading] = useState(true);

  // ✅ 모달 상태
  const [selectedReport, setSelectedReport] = useState(null);
  const [modalOpen, setModalOpen] = useState(false);
    
  const formatDate = (value) => {
    // 배열이면 변환해서 사용
    if (Array.isArray(value) && value.length >= 6) {
        const [year, month, day, hour, minute] = value;
        const date = new Date(year, month - 1, day, hour, minute); // ⚠️ month는 0-based
        return date.toLocaleString('ko-KR', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        }).replace(/\./g, '-').replace(' ', ' | ');
    }

    return '날짜 형식 오류';
  };

  // ✅ 행 클릭 핸들러
  const handleRowClick = (report) => {
    setSelectedReport(report);
    setModalOpen(true);
  };

  useEffect(() => {
    ReportApi.getAllReports()
      .then((res) => {
        setReports(res.data);
        setLoading(false);
      })
      .catch((err) => {
        console.error('신고 리스트 불러오기 실패:', err);
        setLoading(false);
      });
  }, []);

  if (loading) {
    return (
      <Box display="flex" justifyContent="center" alignItems="center" p={2}>
        <CircularProgress />
      </Box>
    );
  }

  return (
    <Box>
      <Typography variant="h6" gutterBottom>📋 전체 신고 리스트</Typography>
      <TableContainer component={Paper}>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell>신고 ID</TableCell>
              <TableCell>계약 ID</TableCell>
              <TableCell>신고자 ID</TableCell>
              <TableCell>피신고자 ID</TableCell>
              <TableCell>사유</TableCell>
              <TableCell>신고일</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {reports.map((report) => (
                
              <TableRow
                key={report.id}
                hover
                style={{ cursor: 'pointer' }}
                onClick={() => handleRowClick(report)}
              >
                <TableCell>{report.id}</TableCell>
                <TableCell>{report.contractId}</TableCell>
                <TableCell>
                    {report.reporterId} ({report.reporterName})
                </TableCell>
                <TableCell>
                    {report.targetId} ({report.targetName})
                </TableCell>
                <TableCell>{report.reason}</TableCell>
                <TableCell>{formatDate(report.createdAt)}</TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>

      {/* ✅ 모달 삽입 */}
      <ReportDetailModal
        open={modalOpen}
        onClose={() => setModalOpen(false)}
        report={selectedReport}
      />
    </Box>
  );
};

export default ReportTable;
