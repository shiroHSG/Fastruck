import { Box, Typography} from '@mui/material';

export const Upgrade = () => {
  return (
    <Box
      display="flex"
      alignItems="center"
      gap={2}
      sx={{ mt: 3, p: 3, bgcolor: 'primary.light', borderRadius: '8px' }}
    >
      <>
        <Box>
          <Typography variant="h5" sx={{ width: '100px' }} fontSize="16px" mb={1}>
            관라자 전용 <br/> 페이지 입니다.
          </Typography>
        </Box>
      </>
    </Box>
  );
};
