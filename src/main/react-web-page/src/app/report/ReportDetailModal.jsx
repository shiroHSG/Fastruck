'use client';
import React from 'react';
import {
  Dialog, DialogTitle, DialogContent, DialogActions,
  Typography, Button, Stack
} from '@mui/material';

const ReportDetailModal = ({ open, onClose, report }) => {
  if (!report) return null;

  return (
    <Dialog open={open} onClose={onClose} maxWidth="sm" fullWidth>
      <DialogTitle>🚨 신고 상세 정보</DialogTitle>
      <DialogContent dividers>
        <Stack spacing={1}>
          <Typography><strong>신고 ID:</strong> {report.id}</Typography>
          <Typography><strong>계약 ID:</strong> {report.contractId}</Typography>
          <Typography><strong>신고자 ID:</strong> {report.reporterId}</Typography>
          <Typography><strong>피신고자 ID:</strong> {report.targetId}</Typography>
          <Typography><strong>사유:</strong> {report.reason}</Typography>
          <Typography><strong>내용:</strong> {report.description}</Typography>
          <Typography><strong>신고일:</strong> {new Date(report.createdAt).toLocaleString()}</Typography>
        </Stack>
      </DialogContent>
      <DialogActions>
        <Button onClick={onClose} color="primary">닫기</Button>
      </DialogActions>
    </Dialog>
  );
};

export default ReportDetailModal;
