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
  
  Place(int postalcode, String name, float x, float y, float population, float surface) {
    this.postalcode = postalcode;
    this.name = name;
    this.x = x;
    this.y = y;
    this.population = population;
    this.surface = surface;
    this.density = surface > 0 ? population / surface : 0;
    
    radius = 100 * sqrt(population / 2125246);
    alpha = 50 + 100 * density / 23734.783;
  }

  void draw() {
    noStroke();
    fill(color(100, 200, 255, alpha));
    ellipse(x, y, radius, radius);
  }
}