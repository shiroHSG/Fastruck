import React, { useEffect, useState } from 'react';
import Chart from 'react-apexcharts';
import { useTheme } from '@mui/material/styles';
import {
  Stack,
  Typography,
  Avatar,
  Box,
  Select,
  MenuItem,
} from '@mui/material';
import { IconArrowUpRight, IconArrowDownRight } from '@tabler/icons-react';
import DashboardCard from '../../components/shared/DashboardCard';
import { getMonthlyEarnings } from '../../../../api/dashboardApi';

const MonthlyEarnings = () => {
  const theme = useTheme();
  const [seriesData, setSeriesData] = useState([]);
  const [total, setTotal] = useState(0);
  const [growthRate, setGrowthRate] = useState(0);
  const [selectedYear, setSelectedYear] = useState(new Date().getFullYear());

  const secondary = theme.palette.secondary.main;
  const secondarylight = '#f5fcff';
  const errorlight = '#fdede8';

  useEffect(() => {
    const fetchData = async () => {
      try {
        // 현재 연도 데이터
        const current = await getMonthlyEarnings(selectedYear);
        const currentTotals = Array(12).fill(0);
        let currentSum = 0;

        current.forEach(({ month, totalPrice }) => {
          const monthIndex = parseInt(month, 10) - 1;
          currentTotals[monthIndex] = totalPrice;
          currentSum += totalPrice;
        });

        setSeriesData(currentTotals);
        setTotal(currentSum);

        // 작년 데이터
        const last = await getMonthlyEarnings(selectedYear - 1);
        let lastSum = 0;
        last.forEach(({ totalPrice }) => {
          lastSum += totalPrice;
        });

        const growth =
          lastSum > 0 ? ((currentSum - lastSum) / lastSum) * 100 : 0;
        setGrowthRate(growth);
      } catch (err) {
        console.error('월별 수익 불러오기 실패:', err);
      }
    };

    fetchData();
  }, [selectedYear]);

  const optionscolumnchart = {
    chart: {
      type: 'area',
      fontFamily: "'Plus Jakarta Sans', sans-serif",
      foreColor: '#adb0bb',
      toolbar: { show: false },
      height: 60,
      sparkline: { enabled: true },
      group: 'sparklines',
    },
    stroke: { curve: 'smooth', width: 2 },
    fill: {
      colors: [secondarylight],
      type: 'solid',
      opacity: 0.05,
    },
    markers: { size: 0 },
    tooltip: {
      theme: theme.palette.mode === 'dark' ? 'dark' : 'light',
    },
  };

  const seriescolumnchart = [
    {
      name: '월별 수익',
      color: secondary,
      data: seriesData,
    },
  ];

  const isPositive = growthRate >= 0;

  return (
    <DashboardCard
      title="월별 수익"
      action={
        <Select
          size="small"
          value={selectedYear}
          onChange={(e) => setSelectedYear(e.target.value)}
        >
          {[...Array(5)].map((_, i) => {
            const year = new Date().getFullYear() - i;
            return (
              <MenuItem key={year} value={year}>
                {year}년
              </MenuItem>
            );
          })}
        </Select>
      }
      footer={
        <Box sx={{ width: '100%', height: 120 }}>
          <Chart
            options={optionscolumnchart}
            series={seriescolumnchart}
            type="area"
            height="100%"
            width="100%"
          />
        </Box>
      }
    >
      <Typography variant="h3" fontWeight="700" mt={0}>
        ₩{total.toLocaleString()}
      </Typography>

      <Stack direction="row" spacing={1} my={1} alignItems="center">
        <Avatar sx={{
            bgcolor: isPositive ? '#E6FFFA' : '#FFE6E6',
            width: 18,
            height: 18,
          }}>
          {isPositive ? (
            <IconArrowUpRight width={12} color="#13DEB9" />
          ) : (
            <IconArrowDownRight width={12} color="#FA896B" />
          )}
        </Avatar>
        <Typography
          variant="subtitle2"
          fontWeight="600"
          color={isPositive ? '#13DEB9' : '#FA896B'}
        >
          {isPositive ? '+' : ''}
          {growthRate.toFixed(1)}%
        </Typography>
        <Typography variant="subtitle2" color="textSecondary">
          작년 대비
        </Typography>
      </Stack>
    </DashboardCard>
  );
};

export default MonthlyEarnings;
