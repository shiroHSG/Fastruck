'use client';
import { Grid, Box } from '@mui/material';
import PageContainer from '../dashBoardLayout/components/container/PageContainer';
import SalesOverview from '../dashBoardLayout/components/dashboard/SalesOverview';
import YearlyBreakup from '../dashBoardLayout/components/dashboard/YearlyBreakup';
import MonthlyEarnings from '../dashBoardLayout/components/dashboard/MonthlyEarnings';
import ProductPerformance from '../dashBoardLayout/components/dashboard/ProductPerformance';

const Dashboard = () => {
  return (
    <PageContainer title="Dashboard" description="this is Dashboard">
      <Grid container spacing={3}>
        {/* 1행 - SalesOverview (한 줄 전체 차지) */}
        <Grid item xs={12}>
          <Box sx={{ width: '100%' }}>
            <SalesOverview />
          </Box>
        </Grid>

        {/* 2행 - 좌우 나란히 */}
        <Grid item xs={12} sm={6} md={6}>
          <Box sx={{ width: '100%' }}>
            <YearlyBreakup />
          </Box>
        </Grid>
        <Grid item xs={12} sm={6} md={6}>
          <Box sx={{ width: '100%' }}>
            <MonthlyEarnings />
          </Box>
        </Grid>

        {/* 3행 - ProductPerformance */}
        <Grid item xs={12}>
          <Box sx={{ width: '100%' }}>
            <ProductPerformance />
          </Box>
        </Grid>
      </Grid>
    </PageContainer>
  );
};

export default Dashboard;
