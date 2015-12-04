class Place {
  int postalcode;
  String name;
  float x;
  float y;
  float population;
  float surface;
  float density;
  
  float radius;
  float alpha;
  
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
    
    radius = 50 * sqrt(population / 2125246);
    alpha = 50 + 100 * density / 23734.783;
  }

  void draw() {
    drawText();
    drawArea();
  }
  
  void drawArea() {
    noStroke();
    if (highlighted) {
      fill(color(255, 100, 100, alpha));
    }
    else
      fill(blue, alpha);
    ellipse(mapX(x), mapY(y), 2 * scaledRadius(), 2 * scaledRadius());
  }
  
  void drawText() {
    textSize(14);
    textAlign(CENTER);
    
    if (highlighted) {
      fill(darkGray, 150);
      rect(mapX(x) - textWidth(name) / 2 - 3, mapY(y) - scaledRadius() - 18, textWidth(name) + 6, 16);
    }
      
    if (highlighted || selected) {
      if (selected && highlighted)
        fill(yellow);
      else if (selected) 
        fill(yellow, 150);
      else
        fill(255);
      text(name, mapX(x), mapY(y) - scaledRadius() - 6);
    }
  }
  
  boolean contains(float px, float py) {
    return dist(mapX(x), mapY(y), px, py) <= scaledRadius() + 1;
  }
  
  float scaledRadius() {
    return zoom * radius;
  }
}