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
    noStroke();
    if (highlighted) {
      drawText();
      fill(color(255, 100, 100, alpha));
    }
    else
      fill(color(100, 200, 255, alpha));
    ellipse(mapX(x), mapY(y), 2 * radius, 2 * radius);
  }
  
  void drawText() {
    textSize(14);
    textAlign(CENTER);
    
    fill(darkGray, 150);
    rect(mapX(x) - textWidth(name) / 2 - 3, mapY(y) - radius - 18, textWidth(name) + 6, 16);
    
    fill(255);
    text(name, mapX(x), mapY(y) - radius - 6);
  }
  
  boolean contains(int px, int py) {
    return dist(mapX(x), mapY(y), px, py) <= radius + 1;
  }
}