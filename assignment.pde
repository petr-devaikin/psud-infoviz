int minPopulationToDisplay = 1000;

float minX, maxX;
float minY, maxY;
int totalCount;
float minPopulation, maxPopulation;
float minSurface, maxSurface;
float minAltitude, maxAltitude;
Place[] places;
Place pickedPlace = null;

color darkGray = color(40);
color blue = #5ab3e6;

float translationX = 0,
    translationY = 0,
    zoom = 0.9;

float maxDensity = 23734.783;
color[] densityColors = {
#feedde,
#fdd0a2,
#fdae6b,
#fd8d3c,
#f16913,
#d94801,
#8c2d04
};


void setup() {
  size(800, 800);
  readData();
}

void draw() {
  background(darkGray);
  
  for (int i = 0; i < totalCount; ++i)
    if (places[i].population > minPopulationToDisplay) 
      places[i].draw();
  
  // text on top
  for (int i = 0; i < totalCount; ++i)
    if (places[i].population > minPopulationToDisplay) 
      places[i].drawText();
    
  drawSlider();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT && minPopulationToDisplay <= 1000000) {
      minPopulationToDisplay *= 10;
    } else if (keyCode == LEFT && minPopulationToDisplay > 1) {
      minPopulationToDisplay /= 10;
    }
    
    mouseMoved();
    
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

void mouseClicked() {
  if (pickedPlace != null) {
    pickedPlace.selected = !pickedPlace.selected;
    redraw();
  }
}

void mouseDragged() {
  translationX += (mouseX - pmouseX) / zoom;
  translationY += (mouseY - pmouseY) / zoom;
  redraw();
}

void mouseWheel(MouseEvent event) {
  // zoom to cursor
  translationX -= 1 / zoom * (mouseX - 400);
  translationY -= 1 / zoom * (mouseY - 400);
  
  zoom *= sqrt(1 + float(event.getCount()) / 10);
  
  // zoom to cursor
  translationX += 1 / zoom * (mouseX - 400);
  translationY += 1 / zoom * (mouseY - 400);
  redraw();
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
  return map(x, minX, maxX, (translationX - 400) * zoom + 400, (translationX + 400) * zoom + 400);
}

float mapY(float y) {
  return map(y, minY, maxY, (translationY + 400) * zoom + 400, (translationY - 400) * zoom + 400);
}

Place pick(float px, float py) {
  Place result = null;
  for (int i = totalCount - 1; i >= 0; i--)
    if (places[i].population > minPopulationToDisplay && places[i].contains(px, py)) {
      result = places[i];
      break;
    }
  return result;
}