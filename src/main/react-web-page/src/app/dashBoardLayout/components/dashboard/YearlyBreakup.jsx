import React, { useEffect, useState } from 'react';
import {
  Typography,
  Stack,
  Avatar,
  Select,
  MenuItem,
  Box,
} from '@mui/material';
import { IconArrowUpRight, IconArrowDownRight } from '@tabler/icons-react';
import DashboardCard from '../../components/shared/DashboardCard';
import PieChart from '../shared/PieChart';
import axios from 'axios';

const YearlyBreakup = () => {
  const currentYear = new Date().getFullYear();
  const [selectedYear, setSelectedYear] = useState(currentYear);
  const [data, setData] = useState({
    shipper: 0,
    carrier: 0,
    total: 0,
    growthRate: 0,
  });

  const fetchData = async (year) => {
    try {
      const res = await axios.get(
        `http://localhost:8080/api/member/count/by-year?year=${year}`
      );
      setData(res.data);
    } catch (error) {
      console.error('데이터 요청 실패:', error);
    }
  };

  useEffect(() => {
    fetchData(selectedYear);
  }, [selectedYear]);

  const isPositive = data.growthRate >= 0;

  return (
    <DashboardCard
      title="사용자"
      action={
        <Select
          value={selectedYear}
          onChange={(e) => setSelectedYear(e.target.value)}
          size="small"
        >
          {[...Array(5)].map((_, i) => {
            const year = currentYear - i;
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
          <PieChart
            data={[
              { name: 'SHIPPER', value: data.shipper },
              { name: 'CARRIER', value: data.carrier },
            ]}
          />
        </Box>
      }
    >
      <Typography variant="h3" fontWeight="700" mt={0}>
        {data.total.toLocaleString()}명
      </Typography>

      <Stack direction="row" spacing={1} my={1} alignItems="center">
        <Avatar
          sx={{
            bgcolor: isPositive ? '#E6FFFA' : '#FFE6E6',
            width: 18,
            height: 18,
          }}
        >
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
          {data.growthRate.toFixed(1)}%
        </Typography>

        <Typography variant="subtitle2" color="textSecondary">
          작년 대비
        </Typography>
      </Stack>
    </DashboardCard>
  );
};

export default YearlyBreakup;
