export type PlaceItem = {
  name: string;
  address: string;
  lat: number;
  lng: number;
  source: "keyword" | "address" | "map_pick";
  buildingName?: string;
  placeId?: string;
  regionPrimary?: string;
  regionSecondary?: string;
};