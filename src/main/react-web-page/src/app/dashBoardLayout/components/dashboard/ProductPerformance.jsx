import React, { useEffect, useState } from 'react';
import {
  Typography,
  Box,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
  Chip,
  Tooltip,
  Stack
} from '@mui/material';
import { IconInfoCircle } from '@tabler/icons-react';
import DashboardCard from '../../components/shared/DashboardCard';
import { getLatestContracts } from '../../../../api/dashboardApi';

const statusColorMap = {
  MOVING_TO_HUB: 'primary.main',
  LOADING: 'secondary.main',
  DEPARTED: 'error.main',
  ARRIVED: 'warning.main',
  COMPLETED: 'success.main',
};

const statusDescriptionMap = {
  MOVING_TO_HUB: 'MOVING_TO_HUB: 집하지로 이동 중',
  LOADING: 'LOADING: 화물 적재 중',
  DEPARTED: 'DEPARTED: 배송 출발',
  ARRIVED: 'ARRIVED: 배송지 도착',
  COMPLETED: 'COMPLETED: 배송 완료',
};

const ProductPerformance = () => {
  const [contracts, setContracts] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const result = await getLatestContracts();
        setContracts(result);
      } catch (error) {
        console.error('최근 계약 불러오기 실패:', error);
      }
    };

    fetchData();
  }, []);

  return (
    <DashboardCard title="Product Performance">
      <Box sx={{ overflow: 'auto', width: { xs: '280px', sm: 'auto' } }}>
        <Table aria-label="contract table" sx={{ whiteSpace: 'nowrap', mt: 2 }}>
          <TableHead>
            <TableRow>
              <TableCell>
                <Typography variant="subtitle2" fontWeight={600}>No.</Typography>
              </TableCell>
              <TableCell>
                <Typography variant="subtitle2" fontWeight={600}>화물 요청자</Typography>
              </TableCell>
              <TableCell>
                <Typography variant="subtitle2" fontWeight={600}>운송기사</Typography>
              </TableCell>
              <TableCell>
                <Stack direction="row" alignItems="center" spacing={0.5}>
                  <Typography variant="subtitle2" fontWeight={600}>운송 상태</Typography>
                  <Tooltip
                    title={
                      <Box sx={{ whiteSpace: 'pre-line' }}>
                        {Object.values(statusDescriptionMap).join('\n')}
                      </Box>
                    }
                    arrow
                    placement="top"
                  >
                    <IconInfoCircle size={16} style={{ cursor: 'pointer', color: '#888' }} />
                  </Tooltip>
                </Stack>
              </TableCell>
              <TableCell align="right">
                <Typography variant="subtitle2" fontWeight={600}>금액</Typography>
              </TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {contracts.map((item) => (
              <TableRow key={item.id}>
                <TableCell>
                  <Typography fontSize={15} fontWeight={500}>{item.id}</Typography>
                </TableCell>
                <TableCell>
                  <Typography variant="subtitle2" fontWeight={600}>
                    {item.shipper_name}
                  </Typography>
                </TableCell>
                <TableCell>
                  <Typography color="textSecondary" variant="subtitle2">
                    {item.carrier_name}
                  </Typography>
                </TableCell>
                <TableCell>
                  <Chip
                    sx={{
                      px: '4px',
                      backgroundColor: statusColorMap[item.status] || 'grey.500',
                      color: '#fff',
                    }}
                    size="small"
                    label={item.status}
                  />
                </TableCell>
                <TableCell align="right">
                  <Typography variant="h6">{item.charge.toLocaleString()}원</Typography>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </Box>
    </DashboardCard>
  );
};

export default ProductPerformance;
