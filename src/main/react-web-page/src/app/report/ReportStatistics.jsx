'use client';
import React, { useEffect, useState } from 'react';
import { Card, CardContent, Typography, CircularProgress, Box } from '@mui/material';
import ReportApi from '../../api/reportApi';

const ReportStatistics = () => {
  const [stats, setStats] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    ReportApi.getStatistics()
      .then((res) => {
        setStats(res.data);
        setLoading(false);
      })
      .catch((err) => {
        console.error('신고 통계 불러오기 실패:', err);
        setLoading(false);
      });
  }, []);

  if (loading) {
    return (
      <Card>
        <CardContent>
          <Typography variant="h6">신고 현황</Typography>
          <Box display="flex" justifyContent="center" alignItems="center" p={2}>
            <CircularProgress />
          </Box>
        </CardContent>
      </Card>
    );
  }

  return (
    <Card>
      <CardContent>
        <Typography variant="h6" gutterBottom>🚨 신고 많이 받은 차주</Typography>
        {stats.length === 0 ? (
          <Typography color="text.secondary">신고된 차주가 없습니다.</Typography>
        ) : (
          <Box component="ul" sx={{ pl: 2, mt: 1 }}>
            {stats.slice(0, 3).map((item, index) => (
            <li key={item.carrierId}>
                <Typography>
                {index + 1}. <strong>{item.carrierName}</strong> - {item.reportCount}건 신고
                </Typography>
            </li>
            ))}
          </Box>
        )}
      </CardContent>
    </Card>
  );
};

export default ReportStatistics;
