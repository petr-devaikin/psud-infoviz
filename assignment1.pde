int minPopulationToDisplay = 10000;

float minX, maxX;
float minY, maxY;
int totalCount;
float minPopulation, maxPopulation;
float minSurface, maxSurface;
float minAltitude, maxAltitude;
Place[] places;
Place pickedPlace = null;

color darkGray = color(50, 50, 50);

void setup() {
  size(800, 800);
  readData();
}

void draw() {
  background(darkGray);
  
  fill(255);
  textSize(16);
  textAlign(LEFT);
  text("Displaying populations above " + minPopulationToDisplay, 10, 20);
  
  for (int i = 0; i < totalCount; ++i) {
    if (places[i].population > minPopulationToDisplay && pickedPlace != places[i])
      places[i].draw();
  }
  
  // draw picked place on top
  if (pickedPlace != null)
    pickedPlace.draw();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP && minPopulationToDisplay < 10000000) {
      minPopulationToDisplay *= 10;
    } else if (keyCode == DOWN && minPopulationToDisplay > 100) {
      minPopulationToDisplay /= 10;
    }
    redraw();
  }
}

void mouseMoved() {
  Place hoveredPlace = pick(mouseX, mouseY);
  if (hoveredPlace != pickedPlace) {
    if (pickedPlace != null)
      pickedPlace.highlighted = false;
    pickedPlace = hoveredPlace;
    if (pickedPlace != null)
      pickedPlace.highlighted = true;
    redraw();
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
      float(placeData[1]),
      float(placeData[2]),
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

Place pick(int px, int py) {
  Place result = null;
  for (int i = totalCount - 1; i >= 0; i--)
    if (places[i].population > minPopulationToDisplay && places[i].contains(px, py)) {
      result = places[i];
      break;
    }
  return result;
}