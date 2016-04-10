public class BasicTile {
	public Tile hwTile;
	public Tile lwTile;
	public Tile hrTile;
	public Tile lrTile;
	public Tile roadTile;
	public Tile intersectionTile;

	public BasicTile() {
		float[] hwDepartureProbabilityArray = { 0.10f, 0.10f, 0.10f, 0.10f, 0.30f, 0.40f, 0.35f, 0.20f, 0.20f, 0.20f, 0.20f, 0.20f, 0.30f, 0.30f, 0.30f, 0.30f, 0.90f, 0.90f, 0.90f, 0.50f, 0.40f, 0.30f, 0.20f, 0.10f };
		float[] hwArrivalProbabilityArray = { 0.10f, 0.10f, 0.10f, 0.10f, 0.30f, 0.40f, 0.35f, 0.90f, 0.90f, 0.20f, 0.20f, 0.20f, 0.30f, 0.30f, 0.30f, 0.30f, 0.20f, 0.20f, 0.20f, 0.20f, 0.20f, 0.10f, 0.10f, 0.10f };
		hwTile = new Tile(hwDepartureProbabilityArray, hwArrivalProbabilityArray, TileType.HW);

		float[] lwDepartureProbabilityArray = { 0.03f, 0.03f, 0.03f, 0.03f, 0.10f, 0.13f, 0.12f, 0.07f, 0.07f, 0.07f, 0.07f, 0.07f, 0.10f, 0.10f, 0.10f, 0.10f, 0.30f, 0.30f, 0.30f, 0.17f, 0.13f, 0.10f, 0.07f, 0.03f };
		float[] lwArrivalProbabilityArray = { 0.03f, 0.03f, 0.03f, 0.03f, 0.10f, 0.13f, 0.12f, 0.30f, 0.30f, 0.07f, 0.07f, 0.07f, 0.10f, 0.10f, 0.10f, 0.10f, 0.07f, 0.07f, 0.07f, 0.07f, 0.07f, 0.03f, 0.03f, 0.03f };
		lwTile = new Tile(lwDepartureProbabilityArray, lwArrivalProbabilityArray, TileType.LW);

		float[] hrDepartureProbabilityArray = { 0.10f, 0.10f, 0.10f, 0.10f, 0.30f, 0.40f, 0.35f, 0.90f, 0.90f, 0.20f, 0.20f, 0.20f, 0.30f, 0.30f, 0.30f, 0.30f, 0.20f, 0.20f, 0.20f, 0.20f, 0.20f, 0.10f, 0.10f, 0.10f };
		float[] hrArrivalProbabilityArray = { 0.10f, 0.10f, 0.10f, 0.10f, 0.30f, 0.40f, 0.35f, 0.20f, 0.20f, 0.20f, 0.20f, 0.20f, 0.30f, 0.30f, 0.30f, 0.30f, 0.90f, 0.90f, 0.90f, 0.50f, 0.40f, 0.30f, 0.20f, 0.10f };
		hrTile = new Tile(hrDepartureProbabilityArray, hrArrivalProbabilityArray, TileType.HR);

		float[] lrDepartureProbabilityArray = { 0.03f, 0.03f, 0.03f, 0.03f, 0.10f, 0.13f, 0.12f, 0.30f, 0.30f, 0.07f, 0.07f, 0.07f, 0.10f, 0.10f, 0.10f, 0.10f, 0.07f, 0.07f, 0.07f, 0.07f, 0.07f, 0.03f, 0.03f, 0.03f };
		float[] lrArrivalProbabilityArray = { 0.03f, 0.03f, 0.03f, 0.03f, 0.10f, 0.13f, 0.12f, 0.07f, 0.07f, 0.07f, 0.07f, 0.07f, 0.10f, 0.10f, 0.10f, 0.10f, 0.30f, 0.30f, 0.30f, 0.17f, 0.13f, 0.10f, 0.07f, 0.03f };
		lrTile = new Tile(lrDepartureProbabilityArray, lrArrivalProbabilityArray, TileType.LR);

		float[] roadDepartureProbabilityArray = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0 };
		float[] roadArrivalProbabilityArray = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0 };
		roadTile = new Tile(roadDepartureProbabilityArray, roadArrivalProbabilityArray, TileType.ROAD);

		float[] intersectionDepartureProbabilityArray = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0 };
		float[] intersectionArrivalProbabilityArray = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0 };
		intersectionTile = new Tile(intersectionDepartureProbabilityArray, intersectionArrivalProbabilityArray,
				TileType.INTERSECTION);
	}
}
