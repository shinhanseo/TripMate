import type { PlaceItem } from './place-type.js';
import { getJejuRegionInfo } from './place-helper.js';

export function buildPlaceItem(params: {
  name: string;
  address: string;
  lat: number;
  lng: number;
  source: "keyword" | "address" | "map_pick";
  buildingName?: string;
  placeId?: string;
}): PlaceItem {
  const { regionPrimary, regionSecondary } = getJejuRegionInfo(params.address);

  return {
    ...params,
    regionPrimary,
    regionSecondary,
  };
}