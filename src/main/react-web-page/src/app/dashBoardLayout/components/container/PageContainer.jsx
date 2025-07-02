import React from 'react';
// import { Helmet } from 'react-helmet'; // 필요 시 주석 해제 가능

const PageContainer = ({ title, description, children }) => {
  return (
    <div>
      <title>{title}</title>
      <meta name="description" content={description} />
      {children}
    </div>
  );
};

export default PageContainer;
