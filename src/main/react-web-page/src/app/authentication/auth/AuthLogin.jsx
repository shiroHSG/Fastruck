import React, { useState } from "react";
import {
  Box,
  Typography,
  Button,
  Stack,
} from "@mui/material";
import { useNavigate } from "react-router-dom";
import CustomTextField from '../../dashBoardLayout/components/forms/theme-elements/CustomTextField';
import { login } from '../../../api/authApi';

const AuthLogin = ({ title, subtitle, subtext }) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [errorMsg, setErrorMsg] = useState('');
  const navigate = useNavigate();

  const handleLogin = async (e) => {
    e.preventDefault();
    try {
      const res = await login(email, password);

      // ✅ AccessToken만 저장
      localStorage.setItem('accessToken', res.accessToken);

      console.log('로그인 성공:', res);
      navigate('/dashboard');
    } catch (err) {
      const msg = typeof err === 'string' ? err : err.message || '로그인 실패';
      setErrorMsg(msg);
    }
  };

  return (
    <form onSubmit={handleLogin}>
      {title && (
        <Typography fontWeight="700" variant="h2" mb={1}>
          {title}
        </Typography>
      )}
      {subtext}

      <Stack spacing={3}>
        <Box>
          <Typography
            variant="subtitle1"
            fontWeight={600}
            component="label"
            htmlFor="email"
            mb="5px"
          >
            Email
          </Typography>
          <CustomTextField
            id="email"
            variant="outlined"
            fullWidth
            value={email}
            onChange={(e) => setEmail(e.target.value)}
          />
        </Box>

        <Box>
          <Typography
            variant="subtitle1"
            fontWeight={600}
            component="label"
            htmlFor="password"
            mb="5px"
          >
            Password
          </Typography>
          <CustomTextField
            id="password"
            type="password"
            variant="outlined"
            fullWidth
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
        </Box>

        {errorMsg && (
          <Typography color="error" variant="body2" textAlign="center">
            {errorMsg}
          </Typography>
        )}

        <Box>
          <Button
            color="primary"
            variant="contained"
            size="large"
            fullWidth
            type="submit"
            disabled={!email || !password} // 옵션: 유효성 검사
          >
            Sign In
          </Button>
        </Box>
      </Stack>

      {subtitle}
    </form>
  );
};

export default AuthLogin;
