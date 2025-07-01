import React, { useEffect, useState } from 'react';
import axios from './api/customAxios';

function App() {
  const [message, setMessage] = useState('');

  useEffect(() => {
  axios.get('/api/test') 
    .then(res => setMessage(res.data.message))
    .catch(err => {
      console.error(err);
      setMessage('에러 발생');
    });
}, []);

  return (
    <div style={{ padding: "2rem", fontSize: "1.5rem" }}>
      <h1>Spring Boot API 테스트</h1>
      <p>{message || "로딩 중..."}</p>
    </div>
  );
}

export default App;
