import { Request, Response, NextFunction } from "express";
import jwt from "jsonwebtoken";
import { fail } from "../utils/response";

const JWT_ACCESS_SECRET = process.env.JWT_ACCESS_SECRET!;

export interface AuthUser {
  userId: number;
  type?: string;
  tokenVersion?: number;
  iat?: number;
  exp?: number;
}

export interface AuthRequest extends Request {
  user?: AuthUser;
}

export function verifyAccessToken(token: string): AuthUser {
  const payload = jwt.verify(token, JWT_ACCESS_SECRET) as AuthUser;

  if (payload.type !== "access") {
    throw new Error("invalid token type");
  }

  return payload;
}

export function authRequired(
  req: AuthRequest,
  res: Response,
  next: NextFunction
) {
  const authHeader = req.header("authorization") || "";
  const [scheme, token] = authHeader.split(" ");

  if (scheme !== "Bearer" || !token) {
    return fail(res, 401, "access token required");
  }

  try {
    const payload = verifyAccessToken(token);

    req.user = payload;
    next();
  } catch {
    return fail(res, 401, "invalid or expired access token");
  }
}
