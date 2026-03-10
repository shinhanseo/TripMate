import "express-session";

declare module "express-session" {
  interface SessionData {
    naverState?: string;
  }
}