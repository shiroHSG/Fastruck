import { Box, Typography, Button } from '@mui/material';
import { Link as RouterLink } from 'react-router-dom';

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
          <Typography variant="h5" sx={{ width: '80px' }} fontSize="16px" mb={1}>
            Haven&apos;t account ?
          </Typography>
          <Button
            color="primary"
            component={RouterLink}
            to="/authentication/register"
            variant="contained"
            aria-label="logout"
            size="small"
          >
            Sign Up
          </Button>
        </Box>
        <Box mt="-35px">
          <img
            alt="rocket"
            src="/images/backgrounds/rocket.png"
            width={100}
            height={100}
            style={{ display: 'block' }}
          />
        </Box>
      </>
    </Box>
  );
};
