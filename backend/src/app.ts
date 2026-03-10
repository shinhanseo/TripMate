import express, { Request, Response } from 'express';
import session from "express-session";
import cors from 'cors';

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());
app.use(
  session({
    secret: "your-secret-key",
    resave: false,
    saveUninitialized: false,
  })
);

app.get("/health", (req: Request, res: Response) => {
  res.status(200).json({
    status: "ok",
    timestamp: new Date().toISOString(),
  });
});

// 서버 시작
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});