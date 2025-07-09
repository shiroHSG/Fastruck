'use client';
import PageContainer from '../components/container/PageContainer';
import DashboardCard from '../components/shared/DashboardCard';
import { Typography, Link, Divider } from '@mui/material';
import { Light as SyntaxHighlighter } from 'react-syntax-highlighter';
import { atomOneDark } from 'react-syntax-highlighter/dist/esm/styles/hljs';


const Icons = () => {
  return (
    <PageContainer title="Icons" description="this is Icons">
      <DashboardCard title="Icons">
        <Typography variant="h6" gutterBottom>🔍 Explore Icons</Typography>
        <Typography variant="body1">
          Visit{' '}
          <Link
            href="https://tabler-icons.io/"
            target="_blank"
            rel="noopener noreferrer"
          >
            Tabler Icons website
          </Link>
        </Typography>

        <Divider sx={{ my: 3 }} />
        <Typography variant="h6" gutterBottom>⚙️ Installation</Typography>
        <SyntaxHighlighter language="bash" style={atomOneDark}>
          npm install @tabler/icons-react
        </SyntaxHighlighter>

        <Divider sx={{ my: 3 }} />
        <Typography variant="h6" gutterBottom>🧩 Usage Example</Typography>
        <SyntaxHighlighter language="jsx" style={atomOneDark}>
{`import { IconHome } from '@tabler/icons-react';

function MyComponent() {
  return <IconHome />;
}`}
        </SyntaxHighlighter>
      </DashboardCard>
    </PageContainer>
  );
};

export default Icons;
