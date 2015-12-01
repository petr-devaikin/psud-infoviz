//globally
//declare the min and max variables that you need in parseInfo
float minX, maxX;
float minY, maxY;
int totalCount; // total number of places
float minPopulation, maxPopulation;
float minSurface, maxSurface;
float minAltitude, maxAltitude;
Place[] places;

void setup() {
  size(800, 800);
  readData();
}

void draw() {
  background(0);
  color black = color(0);
  float density = 0;
  for (int i = 0; i < totalCount; ++i) {
    places[i].draw();
    if (places[i].surface != 0 && density < places[i].population / places[i].surface)
      density = places[i].population / places[i].surface;
  }
}


void readData() {
  String[] lines = loadStrings("villes.tsv");
  parseInfo(lines[0]); // read the header line
  
  places = new Place[totalCount];
  for (int i = 0; i < totalCount; i++) {
    String placeData[] = split(lines[i+2], TAB);
    places[i] = new Place(
      int(placeData[0]),
      placeData[4],
      mapX(float(placeData[1])),
      mapY(float(placeData[2])),
      float(placeData[5]),
      float(placeData[6])
    );
  }
}


void parseInfo(String line) {
  String infoString = line.substring(2); // remove the #
  String[] infoPieces = split(infoString, ',');
  totalCount = int(infoPieces[0]);
  minX = float(infoPieces[1]);
  maxX = float(infoPieces[2]);
  minY = float(infoPieces[3]);
  maxY = float(infoPieces[4]);
  minPopulation = float(infoPieces[5]);
  maxPopulation = float(infoPieces[6]);
  minSurface = float(infoPieces[7]);
  maxSurface = float(infoPieces[8]);
  minAltitude = float(infoPieces[9]);
  maxAltitude = float(infoPieces[10]);
}

float mapX(float x) {
  return map(x, minX, maxX, 0, 800);
}

float mapY(float y) {
  return map(y, minY, maxY, 800, 0);
}