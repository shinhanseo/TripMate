const ALLOWED_CATEGORIES = ["food", "cafe", "drink", "travel", "activity"] as const;

type Category = (typeof ALLOWED_CATEGORIES)[number];

export function isValidCategory(value: unknown): value is Category {
  return ALLOWED_CATEGORIES.includes(value as Category);
}