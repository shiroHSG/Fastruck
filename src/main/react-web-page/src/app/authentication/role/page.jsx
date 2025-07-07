'use client';
import axios from '../../../api/axiosInstance';
import React, { useEffect, useState } from 'react';
import {
  Box, Typography, Table, TableBody, TableCell, TableContainer,
  TableHead, TableRow, Paper, Pagination, Button
} from '@mui/material';
import ChangeRoleModal from './modal';

const roles = ['SHIPPER', 'CARRIER', 'ADMIN'];
const ITEMS_PER_PAGE = 10;
const formatDate = (value) => {
  const date = new Date(value);
  return isNaN(date) ? '-' : date.toISOString().substring(0, 10);
};

const MemberListPage = () => {
  const [members, setMembers] = useState([]);
  const [selectedMember, setSelectedMember] = useState(null);
  const [openModal, setOpenModal] = useState(false);
  const [pageByRole, setPageByRole] = useState({ SHIPPER: 1, CARRIER: 1, ADMIN: 1 });

  // ✅ 회원 전체 목록 불러오기
  const fetchMembers = async () => {
    try {
      const response = await axios.get('/api/member/all');
      setMembers(response.data);
    } catch (error) {
      console.error('회원 목록 불러오기 실패:', error);
    }
  };

  useEffect(() => {
    fetchMembers();
  }, []);

  const handleOpenModal = (member) => {
    setSelectedMember(member);
    setOpenModal(true);
  };

  const handleCloseModal = () => {
    setSelectedMember(null);
    setOpenModal(false);
  };

  const handlePageChange = (role, event, value) => {
    setPageByRole(prev => ({ ...prev, [role]: value }));
  };

  const renderTable = (role) => {
    const filtered = members.filter(m => m.role === role);
    const page = pageByRole[role] || 1;
    const paginated = filtered.slice((page - 1) * ITEMS_PER_PAGE, page * ITEMS_PER_PAGE);

    return (
      <Box mb={5} key={role}>
        <Typography variant="h6" mb={2}>{role} 목록</Typography>
        <TableContainer component={Paper}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>이름</TableCell>
                <TableCell>이메일</TableCell>
                <TableCell>전화번호</TableCell>
                <TableCell>가입일</TableCell>
                <TableCell>권한</TableCell>
                <TableCell align="right">관리</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {paginated.map((member) => (
                <TableRow key={member.id}>
                  <TableCell>{member.name}</TableCell>
                  <TableCell>{member.email}</TableCell>
                  <TableCell>{member.phone || '-'}</TableCell>
                  <TableCell>{formatDate(member.createdAt)}</TableCell>
                  <TableCell>{member.role}</TableCell>
                  <TableCell align="right">
                    <Button variant="outlined" size="small" onClick={() => handleOpenModal(member)}>
                      권한 변경
                    </Button>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
          {filtered.length > ITEMS_PER_PAGE && (
            <Box display="flex" justifyContent="center" p={2}>
              <Pagination
                count={Math.ceil(filtered.length / ITEMS_PER_PAGE)}
                page={page}
                onChange={(e, val) => handlePageChange(role, e, val)}
              />
            </Box>
          )}
        </TableContainer>
      </Box>
    );
  };

  return (
    <Box p={3}>
      <Typography variant="h4" gutterBottom>전체 회원 관리</Typography>
      {roles.map(renderTable)}

      {/* 권한 변경 모달 */}
      {selectedMember && (
        <ChangeRoleModal
          open={openModal}
          onClose={handleCloseModal}
          member={selectedMember}
          onSuccess={() => {
            fetchMembers(); // 변경 후 목록 갱신
            handleCloseModal();
          }}
        />
      )}
    </Box>
  );
};

export default MemberListPage;
