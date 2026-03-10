import express, { Request, Response } from 'express';
import cors from 'cors';

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// 기본 확인용
app.get('/', (req: Request, res: Response) => {
  res.send('Backend server is running');
});

// 테스트용
app.get('/hello', (req: Request, res: Response) => {
  res.json({
    message: 'Hello from backend',
  });
});

// 헬스체크용
app.get('/healthz', (req: Request, res: Response) => {
  res.status(200).json({
    ok: true,
    uptime: process.uptime(),
    timestamp: new Date().toISOString(),
  });
});

// 서버 시작
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});