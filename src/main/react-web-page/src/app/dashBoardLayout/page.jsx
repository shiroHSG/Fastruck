'use client'
import { Grid, Box } from '@mui/material';
import PageContainer from '../dashBoardLayout/components/container/PageContainer';
// components
import SalesOverview from '../dashBoardLayout/components/dashboard/SalesOverview';
import YearlyBreakup from '../dashBoardLayout/components/dashboard/YearlyBreakup';
import ProductPerformance from '../dashBoardLayout/components/dashboard/ProductPerformance';
import MonthlyEarnings from '../dashBoardLayout/components/dashboard/MonthlyEarnings';

const Dashboard = () => {
return (
  <PageContainer title="Dashboard" description="this is Dashboard">
    <Box>
      <Grid container spacing={3} sx={{ height: '100%' }}>
        {/* 왼쪽: Sales Overview */}
        <Grid item xs={12} lg={8} >
          <SalesOverview />
        </Grid>

        {/* 오른쪽: YearlyBreakup & MonthlyEarnings (세로로 쌓기) */}
        <Grid item xs={12} lg={4}>
          <Grid container spacing={3} direction="column" sx={{ height: '100%' }}>
            <Grid item>
              <YearlyBreakup />
            </Grid>
            <Grid item>
              <MonthlyEarnings />
            </Grid>
          </Grid>
        </Grid>

        {/* 아래 전체: ProductPerformance */}
        <Grid item xs={12} lg={12}>
          <ProductPerformance />
        </Grid>
      </Grid>
    </Box>
  </PageContainer>
);
}

export default Dashboard;
