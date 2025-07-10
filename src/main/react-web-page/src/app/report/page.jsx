'use client';
import { Box, Typography } from '@mui/material';
import ReportStatistics from './ReportStatistics';
import ReportTable from './ReportTable';
import ReportWarningList from './ReportWarningList';

const ReportPage = () => {
  return (
    <Box p={3}>
      <Typography variant="h4" mb={2}>🚨 신고 관리</Typography>
      <ReportStatistics />
      <Box mt={4}>
        <ReportTable />
      </Box>
      <Box mt={4}>
        <ReportWarningList />
      </Box>
    </Box>
  );
};

export default ReportPage;