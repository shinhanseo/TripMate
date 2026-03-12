/**
 * --------------------------------------------------
 * 공통 API 응답 규칙
 * --------------------------------------------------
 *
 * 1. 성공 응답
 * - 반드시 ok(res, data, status?) 사용
 * - 형태:
 *
 *   {
 *     "success": true,
 *     "data": ...
 *   }
 *
 * 2. 실패 응답
 * - 반드시 fail(res, status, message, error?) 사용
 * - 형태:
 *
 *   {
 *     "success": false,
 *     "message": "..."
 *   }
 *
 * - 필요하면 error 추가:
 *
 *   {
 *     "success": false,
 *     "message": "...",
 *     "error": ...
 *   }
 *
 * --------------------------------------------------
 * ok / fail 사용 규칙
 * --------------------------------------------------
 *
 * [성공]
 * return ok(res, { item: meeting });
 * return ok(res, { items: meetings });
 * return ok(res, { access_token, refresh_token, user });
 * return ok(res, { message: "logged out" });
 * return ok(res, { item: createdMeeting }, 201);
 *
 * [실패]
 * return fail(res, 400, "invalid meeting id");
 * return fail(res, 401, "invalid access token");
 * return fail(res, 404, "meeting not found");
 * return fail(res, 409, "duplicate nickname");
 * return fail(res, 500, "failed to create meeting");
 *
 * --------------------------------------------------
 * 성공 응답에서 data 내부 규칙
 * --------------------------------------------------
 *
 * 1. 단건 조회 / 생성 / 수정
 * - item 으로 통일
 *
 * 예시:
 * return ok(res, {
 *   item: {
 *     id: 1,
 *     title: "제주 카페 동행",
 *   },
 * });
 *
 * 응답 JSON:
 * {
 *   "success": true,
 *   "data": {
 *     "item": {
 *       "id": 1,
 *       "title": "제주 카페 동행"
 *     }
 *   }
 * }
 *
 * 2. 목록 조회
 * - items 로 통일
 *
 * 예시:
 * return ok(res, {
 *   items: [
 *     { id: 1, title: "A" },
 *     { id: 2, title: "B" }
 *   ]
 * });
 *
 * 응답 JSON:
 * {
 *   "success": true,
 *   "data": {
 *     "items": [
 *       { "id": 1, "title": "A" },
 *       { "id": 2, "title": "B" }
 *     ]
 *   }
 * }
 *
 * 3. 토큰/인증 응답
 * - auth 관련 응답은 item 으로 감싸지 않아도 됨
 * - access_token, refresh_token, user 등을 그대로 data 안에 둠
 *
 * 예시:
 * return ok(res, {
 *   access_token: accessToken,
 *   refresh_token: refreshToken,
 *   user: {
 *     id: userId,
 *     nickname,
 *     profile_completed: true,
 *   },
 * });
 *
 * 응답 JSON:
 * {
 *   "success": true,
 *   "data": {
 *     "access_token": "...",
 *     "refresh_token": "...",
 *     "user": {
 *       "id": 1,
 *       "nickname": "감귤러버",
 *       "profile_completed": true
 *     }
 *   }
 * }
 *
 * --------------------------------------------------
 * Flutter 에서 사용하는 방법
 * --------------------------------------------------
 *
 * Flutter(dio/http)에서는 서버 응답 JSON을 Map<String, dynamic> 으로 받는다.
 * 따라서 보통 json["data"]["item"] 또는 json["data"]["items"] 형태로 접근한다.
 *
 * --------------------------------------------------
 * 1. 단건(item)
 * --------------------------------------------------
 *
 * 서버 응답:
 * {
 *   "success": true,
 *   "data": {
 *     "item": {
 *       "id": 1,
 *       "title": "제주 카페 동행"
 *     }
 *   }
 * }
 *
 * Flutter 예시:
 *
 * final response = await dio.get("/meetings/1");
 * final data = response.data as Map<String, dynamic>;
 * final item = data["data"]["item"] as Map<String, dynamic>;
 *
 * print(item["id"]);
 * print(item["title"]);
 *
 * --------------------------------------------------
 * 2. 목록(items)
 * --------------------------------------------------
 *
 * 서버 응답:
 * {
 *   "success": true,
 *   "data": {
 *     "items": [
 *       { "id": 1, "title": "A" },
 *       { "id": 2, "title": "B" }
 *     ]
 *   }
 * }
 *
 * Flutter 예시:
 *
 * final response = await dio.get("/meetings");
 * final data = response.data as Map<String, dynamic>;
 * final items = data["data"]["items"] as List<dynamic>;
 *
 * for (final item in items) {
 *   final map = item as Map<String, dynamic>;
 *   print(map["id"]);
 *   print(map["title"]);
 * }
 *
 * --------------------------------------------------
 * 3. auth/token 응답
 * --------------------------------------------------
 *
 * 서버 응답:
 * {
 *   "success": true,
 *   "data": {
 *     "access_token": "...",
 *     "refresh_token": "...",
 *     "user": {
 *       "id": 1,
 *       "nickname": null,
 *       "profile_completed": false
 *     }
 *   }
 * }
 *
 * Flutter 예시:
 *
 * final response = await dio.post("/auth/session/exchange", data: {
 *   "exchange_code": exchangeCode,
 * });
 *
 * final data = response.data as Map<String, dynamic>;
 * final body = data["data"] as Map<String, dynamic>;
 *
 * final accessToken = body["access_token"] as String;
 * final refreshToken = body["refresh_token"] as String;
 * final user = body["user"] as Map<String, dynamic>;
 *
 * print(accessToken);
 * print(refreshToken);
 * print(user["id"]);
 * print(user["profile_completed"]);
 *
 * --------------------------------------------------
 * 4. 닉네임 설정 후 응답 예시
 * --------------------------------------------------
 *
 * 서버:
 * return ok(res, {
 *   item: {
 *     id: nicknameRes.rows[0].user_id,
 *     nickname: nicknameRes.rows[0].nickname,
 *     profile_completed: true,
 *   },
 * });
 *
 * Flutter:
 *
 * final response = await dio.patch("/profile/nickname", data: {
 *   "nickname": "감귤러버",
 * });
 *
 * final data = response.data as Map<String, dynamic>;
 * final item = data["data"]["item"] as Map<String, dynamic>;
 *
 * print(item["id"]);
 * print(item["nickname"]);
 * print(item["profile_completed"]);
 *
 * --------------------------------------------------
 * Flutter 쪽 권장 패턴
 * --------------------------------------------------
 *
 * 1. 먼저 success 확인
 *
 * final json = response.data as Map<String, dynamic>;
 * final success = json["success"] == true;
 *
 * if (!success) {
 *   final message = json["message"];
 *   throw Exception(message);
 * }
 *
 * 2. 성공이면 data 꺼내기
 *
 * final body = json["data"] as Map<String, dynamic>;
 *
 * 3. 단건이면 body["item"]
 * 4. 목록이면 body["items"]
 * 5. auth면 body["access_token"], body["refresh_token"], body["user"]
 *
 * --------------------------------------------------
 * 권장 규칙 요약
 * --------------------------------------------------
 *
 * - 성공: ok(res, ...)
 * - 실패: fail(res, ...)
 * - 단건: data.item
 * - 목록: data.items
 * - 토큰 응답: data.access_token, data.refresh_token, data.user
 * - Flutter 에서는 보통:
 *
 *   final json = response.data as Map<String, dynamic>;
 *   final body = json["data"] as Map<String, dynamic>;
 *
 *   단건  -> body["item"]
 *   목록  -> body["items"]
 *   토큰  -> body["access_token"], body["refresh_token"], body["user"]
 *
 * --------------------------------------------------
 */

import { Response } from "express";

export function ok(res: Response, data: any = {}, status = 200) {
  return res.status(status).json({
    success: true,
    data,
  });
}

export function fail(
  res: Response,
  status: number,
  message: string,
  error?: any
) {
  return res.status(status).json({
    success: false,
    message,
    ...(error !== undefined ? { error } : {}),
  });
}