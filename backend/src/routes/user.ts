import { Router } from 'express';
import { authRequired, AuthRequest } from "../middleware/authRequired.js";
import { pool } from "../db.js";

const router = Router();

function isValidNickname(nickname: string) {
  const trimmedNickname = nickname.trim();

  if (trimmedNickname.length < 2) {
    return false;
  }

  if (trimmedNickname.length > 12) {
    return false;
  }

  const nicknameRegex = /^[가-힣a-zA-Z0-9_]+$/;

  if (!nicknameRegex.test(trimmedNickname)) {
    return false;
  }

  return true;
}

router.post("/nickname", authRequired, async (req: AuthRequest, res) => {
  const userId = req.user!.userId;
  const rawNickname = req.body.nickname;

  if (typeof rawNickname !== "string") {
    return res.status(400).json({
      success: false,
      message: "nickname is not string",
    });
  }

  const nickname = String(rawNickname || "").trim();

  if (!isValidNickname(nickname)) {
    return res.status(400).json({
      success: false,
      message: "invalid nickname",
    });
  }

  const client = await pool.connect();
  try {
    await client.query('begin');
    const nicknameCheckRes = await client.query(
      `
      select user_id
      from user_profiles
      where nickname = $1
      `,
      [nickname]
    );

    if (nicknameCheckRes.rowCount !== 0) {
      await client.query('rollback');
      return res.status(409).json({
        success: false,
        message: "duplication nickname"
      });
    }

    const nicknameRes = await client.query(
      `
      update user_profiles
      set nickname = $1,
          update_at = now()
      where user_id = $2
      returning user_id
      `,
      [nickname, userId]
    );

    if (nicknameRes.rowCount === 0) {
      return res.status(500).json({
        success: false,
        message: "failed to set nickname"
      });
    }

    await client.query('commit');

    return res.status(200).json({
      success: true,
      message: "success to set nickname"
    });

  } catch (error: any) {
    await client.query('rollback');
    return res.status(500).json({
      success: false,
      message: "failed to set nickname"
    });
  } finally {
    client.release();
  }
});

export default router;