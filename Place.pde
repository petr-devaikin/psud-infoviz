class Place {
  int postalcode;
  String name;
  float x;
  float y;
  float population;
  float surface;
  float density;
  
  float radius;
  int fillColor;
  
  boolean highlighted = false;
  boolean selected = false;
  
  Place(int postalcode, String name, float x, float y, float population, float surface) {
    this.postalcode = postalcode;
    this.name = name;
    this.x = x;
    this.y = y;
    this.population = population;
    this.surface = surface;
    this.density = surface > 0 ? population / surface : 0;
    
    radius = 50 * pow(pow(population / maxPopulation, 0.5), 1 / 0.7); // perception of area
    int fillValue = int(pow(1 - density / maxDensity, 1 / 0.33) * densityColors.length); // perception of brightness
    if (fillValue == densityColors.length)
      fillValue--;
    this.fillColor = densityColors[densityColors.length - 1 - fillValue];
  }

  void draw() {
    drawArea();
  }
  
  void drawArea() {
    if (highlighted)
      stroke(color(255), 150);
    else
      noStroke();
    fill(fillColor);
    
    ellipse(mapX(x), mapY(y), 2 * scaledRadius(), 2 * scaledRadius());
  }
  
  void drawText() {
    if (!highlighted && !selected)
      return;
      
    textSize(14);
    textAlign(CENTER);
    
    if (highlighted)
      fill(darkGray, 200);
    else
      fill(darkGray, 100);
     
    rect(mapX(x) - textWidth(name) / 2 - 3, mapY(y) - scaledRadius() - 18, textWidth(name) + 6, 16);
      
    if (highlighted)
      fill(255);
    else
      fill(210);
      
    text(name, mapX(x), mapY(y) - scaledRadius() - 6);
  }
  
  boolean contains(float px, float py) {
    return dist(mapX(x), mapY(y), px, py) <= scaledRadius() + 1;
  }
  
  float scaledRadius() {
    return zoom * radius;
  }
}