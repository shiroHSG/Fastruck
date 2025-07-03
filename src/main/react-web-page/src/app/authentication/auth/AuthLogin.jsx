import React from "react";
import {
  Box,
  Typography,
  FormGroup,
  FormControlLabel,
  Button,
  Stack,
  Checkbox,
} from "@mui/material";
import { Link } from "react-router-dom";

import CustomTextField from '../../dashBoardLayout/components/forms/theme-elements/CustomTextField';

const AuthLogin = ({ title, subtitle, subtext }) => (
  <>
    {title && (
      <Typography fontWeight="700" variant="h2" mb={1}>
        {title}
      </Typography>
    )}

    {subtext}

    <Stack>
      <Box>
        <Typography
          variant="subtitle1"
          fontWeight={600}
          component="label"
          htmlFor="username"
          mb="5px"
        >
          Username
        </Typography>
        <CustomTextField variant="outlined" fullWidth />
      </Box>
      <Box mt="25px">
        <Typography
          variant="subtitle1"
          fontWeight={600}
          component="label"
          htmlFor="password"
          mb="5px"
        >
          Password
        </Typography>
        <CustomTextField type="password" variant="outlined" fullWidth />
      </Box>
      <Stack
        justifyContent="space-between"
        direction="row"
        alignItems="center"
        my={2}
      >
      </Stack>
    </Stack>

    <Box>
      <Button
        color="primary"
        variant="contained"
        size="large"
        fullWidth
        component={Link}
        to="/dashboard"
        type="submit"
      >
        Sign In
      </Button>
    </Box>

    {subtitle}
  </>
);

export default AuthLogin;
