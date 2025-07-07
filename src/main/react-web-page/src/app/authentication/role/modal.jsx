'use client';
import axios from '../../../api/axiosInstance';
import React, { useState } from 'react';
import {
  Dialog, DialogTitle, DialogContent, DialogActions,
  Button, MenuItem, FormControl, Select, InputLabel
} from '@mui/material';

const roleOptions = ['SHIPPER', 'CARRIER', 'ADMIN'];

const ChangeRoleModal = ({ open, onClose, member, onSuccess }) => {
  const [newRole, setNewRole] = useState(member.role);
  const [loading, setLoading] = useState(false);

  const handleSubmit = async () => {
    try {
      setLoading(true);
      await axios.put(`/api/member/${member.id}/role`, { role: newRole });
      onSuccess(); // 🔄 목록 새로고침 + 모달 닫기
    } catch (error) {
      console.error('권한 변경 실패:', error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <Dialog
      open={open}
      onClose={onClose}
      fullWidth
      maxWidth="sm" // sm, md, lg 등 가능
      sx={
        {'& .MuiDialog-paper': {
          minHeight: '50px',
          maxWidth: '300px',
          },
        }
      }
    >
      <DialogTitle>권한 변경: {member.name}</DialogTitle>
      <DialogContent>
        <FormControl fullWidth margin="normal">
          <InputLabel style={{ backgroundColor: 'white', padding: '0 4px' }}>권한</InputLabel>
          <Select value={newRole} onChange={(e) => setNewRole(e.target.value)}>
            {roleOptions.map((r) => (
              <MenuItem key={r} value={r}>{r}</MenuItem>
            ))}
          </Select>
        </FormControl>
      </DialogContent>
      <DialogActions>
        <Button onClick={onClose} disabled={loading}>취소</Button>
        <Button onClick={handleSubmit} variant="contained" disabled={loading || newRole === member.role}>
          저장
        </Button>
      </DialogActions>
    </Dialog>
  );
};

export default ChangeRoleModal;
