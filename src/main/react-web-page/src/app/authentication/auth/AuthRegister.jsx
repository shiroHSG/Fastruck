import React from 'react';
import { Box, Typography, Button, Stack } from '@mui/material';
import { Link } from 'react-router-dom';

import CustomTextField from '../../dashBoardLayout/components/forms/theme-elements/CustomTextField';

const AuthRegister = ({ title, subtitle, subtext }) => (
  <>
    {title && (
      <Typography fontWeight="700" variant="h2" mb={1}>
        {title}
      </Typography>
    )}

    {subtext}

    <Box>
      <Stack mb={3}>
        <Typography
          variant="subtitle1"
          fontWeight={600}
          component="label"
          htmlFor="name"
          mb="5px"
        >
          Name
        </Typography>
        <CustomTextField id="name" variant="outlined" fullWidth />

        <Typography
          variant="subtitle1"
          fontWeight={600}
          component="label"
          htmlFor="email"
          mb="5px"
          mt="25px"
        >
          Email Address
        </Typography>
        <CustomTextField id="email" variant="outlined" fullWidth />

        <Typography
          variant="subtitle1"
          fontWeight={600}
          component="label"
          htmlFor="password"
          mb="5px"
          mt="25px"
        >
          Password
        </Typography>
        <CustomTextField id="password" variant="outlined" fullWidth />
      </Stack>

      <Button
        color="primary"
        variant="contained"
        size="large"
        fullWidth
        component={Link}
        to="/authentication/login"
      >
        Sign Up
      </Button>
    </Box>

    {subtitle}
  </>
);

export default AuthRegister;
