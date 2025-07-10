'use client';
import React, { useEffect, useState } from 'react';
import {
  Card, CardContent, Typography, Box, Button, Stack, CircularProgress
} from '@mui/material';
import ReportApi from '../../api/reportApi';

const ReportWarningList = () => {
  const [stats, setStats] = useState([]);
  const [sending, setSending] = useState(null); // 현재 전송 중인 carrierId

  useEffect(() => {
    ReportApi.getStatistics()
      .then((res) => setStats(res.data))
      .catch((err) => console.error('경고 리스트 로드 실패', err));
  }, []);

  const sendWarning = async (carrierId, carrierName) => {
    setSending(carrierId);
    try {
      await ReportApi.sendWarning(
        carrierId,
        `경고 알림`,
        `${carrierName}님, 누적 신고가 감지되어 관리자 경고를 보냅니다.`
      );
      alert(`🚨 ${carrierName}님에게 경고 전송 완료`);
    } catch (e) {
      alert('전송 실패');
    } finally {
      setSending(null);
    }
  };

  return (
    <Card sx={{ mt: 4 }}>
      <CardContent>
        <Typography variant="h6" gutterBottom>⚠️ 경고 대상 차주 목록</Typography>
        {stats.length === 0 ? (
          <Typography color="text.secondary">신고된 차주가 없습니다.</Typography>
        ) : (
          <Stack spacing={2}>
            {stats.map(({ carrierId, carrierName, reportCount }) => (
              <Box
                key={carrierId}
                display="flex"
                justifyContent="space-between"
                alignItems="center"
              >
                <Typography>
                  {carrierName} (신고 {reportCount}건)
                </Typography>
                <Button
                  variant="contained"
                  size="small"
                  color="error"
                  onClick={() => sendWarning(carrierId, carrierName)}
                  disabled={sending === carrierId}
                >
                  {sending === carrierId ? <CircularProgress size={20} /> : '경고 전송'}
                </Button>
              </Box>
            ))}
          </Stack>
        )}
      </CardContent>
    </Card>
  );
};

export default ReportWarningList;
