int sliderWidth = 250;
int sliderShift = 90;
int sliderMaxValue = 10000000;
  
void drawSlider() {
  noStroke();
  fill(yellow, 150);
  rect(
    mapSlider(minPopulationToDisplay),
    45,
    mapSlider(sliderMaxValue) - mapSlider(minPopulationToDisplay),
    5
  );
  
  stroke(255);
  line(sliderShift, 45, sliderShift + sliderWidth, 45);
  
  fill(255);
  textSize(12);
  textAlign(CENTER, TOP);
  
  for (int i = 1; i <= sliderMaxValue; i *= 10) {
    int v = i == 1 ? 0 : i;
    float x = mapSlider(v);
    line(x, 50, x, 45);
    text(getValueName(v), x, 50);
  }
  
  textAlign(LEFT, TOP);
  text("Population:", 10, 50);
  
  drawSliderCities();
}

void drawSliderCities() {
  float step = 1;
  int[] histogram = new int[int(mapSlider(sliderMaxValue) / step)];
  for (int i = 0; i < totalCount; i++) {
    float x = mapSlider(int(places[i].population));
    histogram[int(x / step)]++;
  }
  
  noStroke();
  fill(70);
  for (int i = 0; i < histogram.length; i++) {
    if (mapSlider(minPopulationToDisplay) < i * step)
      fill(yellow, 100);
    rect(i * step, 45, step, -histogram[i] * 0.04);
  } 
}

float mapSlider(int value) {
  if (value == 0)
    return sliderShift;
    
  return sliderShift + log(value) / log(sliderMaxValue) * sliderWidth;
}

String getValueName(int value) {
  if (value >= 1000000)
    return value / 1000000 + "m";
  if (value >= 1000)
    return value / 1000 + "k";
  else
    return str(value);
}