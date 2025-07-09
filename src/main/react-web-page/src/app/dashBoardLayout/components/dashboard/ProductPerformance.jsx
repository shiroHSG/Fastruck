import React, { useEffect, useState } from 'react';
import {
  Typography,
  Box,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
  Chip
} from '@mui/material';
import DashboardCard from '../../components/shared/DashboardCard';
import { getLatestContracts } from '../../../../api/dashboardApi';

const statusColorMap = {
  MOVING_TO_HUB: 'primary.main',
  LOADING: 'secondary.main',
  DEPARTED: 'error.main',
  ARRIVED: 'warning.main',
  COMPLETED: 'success.main',
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
                <Typography variant="subtitle2" fontWeight={600}>
                  Id
                </Typography>
              </TableCell>
              <TableCell>
                <Typography variant="subtitle2" fontWeight={600}>
                  Assigned
                </Typography>
              </TableCell>
              <TableCell>
                <Typography variant="subtitle2" fontWeight={600}>
                  Name
                </Typography>
              </TableCell>
              <TableCell>
                <Typography variant="subtitle2" fontWeight={600}>
                  Priority
                </Typography>
              </TableCell>
              <TableCell align="right">
                <Typography variant="subtitle2" fontWeight={600}>
                  Budget
                </Typography>
              </TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {contracts.map((item) => (
              <TableRow key={item.id}>
                <TableCell>
                  <Typography fontSize={15} fontWeight={500}>
                    {item.id}
                  </Typography>
                </TableCell>
                <TableCell>
                  <Typography variant="subtitle2" fontWeight={600}>
                    {item.assigned}
                  </Typography>
                </TableCell>
                <TableCell>
                  <Typography color="textSecondary" variant="subtitle2">
                    {item.name}
                  </Typography>
                </TableCell>
                <TableCell>
                  <Chip
                    sx={{
                      px: '4px',
                      backgroundColor: statusColorMap[item.priority] || 'grey.500',
                      color: '#fff',
                    }}
                    size="small"
                    label={item.priority}
                  />
                </TableCell>
                <TableCell align="right">
                  <Typography variant="h6">
                    {item.budget.toLocaleString()}원
                  </Typography>
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
