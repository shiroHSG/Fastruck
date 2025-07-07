import React, { useState } from 'react';
import { Box, Typography, Button, Stack } from '@mui/material';
import CustomTextField from '../../dashBoardLayout/components/forms/theme-elements/CustomTextField';
import { register } from '../../../api/authApi'; // 경로 확인 필요
import { useNavigate } from 'react-router-dom';

const AuthRegister = ({ title, subtitle, subtext }) => {
  const [form, setForm] = useState({
    name: '',
    email: '',
    password: '',
    phone: '',
    role: 'SHIPPER', // 기본 역할
  });
  const [image, setImage] = useState(null);
  const navigate = useNavigate();

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await register(form, image);
      alert('회원가입 성공!');
      navigate('/authentication/login');
    } catch (err) {
      alert('회원가입 실패: ' + err);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      {title && (
        <Typography fontWeight="700" variant="h2" mb={1}>
          {title}
        </Typography>
      )}
      {subtext}

      <Box>
        <Stack mb={3}>
          <Typography variant="subtitle1" fontWeight={600} component="label" htmlFor="name" mb="5px">
            Name
          </Typography>
          <CustomTextField id="name" name="name" variant="outlined" fullWidth onChange={handleChange} />

          <Typography variant="subtitle1" fontWeight={600} component="label" htmlFor="email" mb="5px" mt="25px">
            Email Address
          </Typography>
          <CustomTextField id="email" name="email" variant="outlined" fullWidth onChange={handleChange} />

          <Typography variant="subtitle1" fontWeight={600} component="label" htmlFor="password" mb="5px" mt="25px">
            Password
          </Typography>
          <CustomTextField id="password" name="password" type="password" variant="outlined" fullWidth onChange={handleChange} />

          <Typography variant="subtitle1" fontWeight={600} component="label" htmlFor="phone" mb="5px" mt="25px">
            Phone (Optional)
          </Typography>
          <CustomTextField id="phone" name="phone" variant="outlined" fullWidth onChange={handleChange} />

          <Typography variant="subtitle1" fontWeight={600} component="label" htmlFor="image" mb="5px" mt="25px">
            Profile Image (Optional)
          </Typography>
          <input type="file" accept="image/*" onChange={(e) => setImage(e.target.files[0])} />
        </Stack>

        <Button type="submit" color="primary" variant="contained" size="large" fullWidth>
          Sign Up
        </Button>
      </Box>

      {subtitle}
    </form>
  );
};

export default AuthRegister;
