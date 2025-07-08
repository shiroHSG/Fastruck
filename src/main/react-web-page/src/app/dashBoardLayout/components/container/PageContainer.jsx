import React, { useEffect } from 'react';
// import { Helmet } from 'react-helmet'; // 필요 시 주석 해제 가능

const PageContainer = ({ title, description, children }) => {
  useEffect(() => {
    if (title) document.title = title;
    // description은 SEO 목적 외에는 대부분 생략 가능
  }, [title]);

  return <>{children}</>;
};

export default PageContainer;
