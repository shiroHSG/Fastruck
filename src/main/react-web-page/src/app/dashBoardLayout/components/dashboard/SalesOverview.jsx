import React, { useState } from 'react';
import { Select, MenuItem, Box, useMediaQuery } from '@mui/material';
import { useTheme } from '@mui/material/styles';
import Chart from 'react-apexcharts';
import DashboardCard from '../shared/DashboardCard';

const SalesOverview = () => {
  const [month, setMonth] = useState('1');
  const theme = useTheme();
  const isMobile = useMediaQuery('(max-width:600px)');

  const handleChange = (event) => {
    setMonth(event.target.value);
  };

  const primary = theme.palette.primary.main;
  const secondary = theme.palette.secondary.main;

  const optionscolumnchart = {
    chart: {
      type: 'bar',
      fontFamily: "'Plus Jakarta Sans', sans-serif;",
      foreColor: '#adb0bb',
      toolbar: { show: true },
      height: '100%',
    },
    colors: [primary, secondary],
    plotOptions: {
      bar: {
        horizontal: true,
        barHeight: '100%',
        borderRadius: [6],
        borderRadiusApplication: 'end',
        borderRadiusWhenStacked: 'all',
      },
    },
    stroke: {
      show: true,
      width: 4,
      lineCap: 'butt',
      colors: ['transparent'],
    },
    dataLabels: { enabled: false },
    legend: { show: false },
    grid: {
      borderColor: 'rgba(0,0,0,0.1)',
      strokeDashArray: 3,
      padding: { top: 0, bottom: 0, left: 0, right: 0 },
    },
    yaxis: {
      categories: ['16/08', '17/08', '18/08', '19/08', '20/08', '21/08', '22/08', '23/08'],
      axisBorder: { show: false },
    },
    xaxis: {
      tickAmount: 4,
      labels: { rotate: 0 },
    },
    tooltip: {
      theme: 'dark',
      fillSeriesColor: false,
    },
  };

  const seriescolumnchart = [
    {
      name: 'Earnings this month',
      data: [355, 390, 300, 350, 390, 180, 355, 390],
    },
    {
      name: 'Expense this month',
      data: [280, 250, 325, 215, 250, 310, 280, 250],
    },
  ];

  return (
    <DashboardCard
      title="Sales Overview"
      sx={{ width: '100%' }}
      action={
        <Select
          labelId="month-dd"
          id="month-dd"
          value={month}
          size="small"
          onChange={handleChange}
        >
          <MenuItem value={1}>March 2025</MenuItem>
          <MenuItem value={2}>April 2025</MenuItem>
          <MenuItem value={3}>May 2025</MenuItem>
        </Select>
      }
      contentSX={{ p: 0 }} // ✅ 내부 padding 제거
    >
      <Box
        sx={{
          width: '100%',
          flexGrow: 1, // ✅ CardContent 안에서 height 확장
          aspectRatio: isMobile ? '4 / 3' : '6 / 5',
        }}
      >
        <Chart
          options={optionscolumnchart}
          series={seriescolumnchart}
          type="bar"
          height="100%"
          width="100%"
        />
      </Box>
    </DashboardCard>
  );
};

export default SalesOverview;
