class LightningBolt
{
  ArrayList<float[]> lightningPoints = new ArrayList<float[]>();
  int maxRandom = 25;
  
  LightningBolt(float startX)
  {
    lightningPoints.add(new float[] {startX, 0.0});
  }
  
  void addBolt()
  {
    if (lightningPoints.size() > 0)
    {
      lightningPoints.add(new float[] {lightningPoints.get(lightningPoints.size()-1)[0] + (float)((Math.random()*maxRandom)-maxRandom/2), lightningPoints.get(lightningPoints.size()-1)[1] + (float)((Math.random()*maxRandom))});
    }
  }
  
  void removeBolt()
  {
    lightningPoints.remove(0);
  }
  
  boolean boltReachesEdge()
  {
    return (this.lightningPoints.size() == 0 || this.lightningPoints.get(this.lightningPoints.size()-1)[1] < height);
  }
  
  void drawBolt()
  {
    for (int j=1; j < this.lightningPoints.size(); j++)
    {
      stroke((float)Math.random()*255, (float)Math.random()*255, (float)Math.random()*255);
      line(lightningPoints.get(j-1)[0], lightningPoints.get(j-1)[1], lightningPoints.get(j)[0], lightningPoints.get(j)[1]);
    }
  }
}

ArrayList<LightningBolt> lightningBolts = new ArrayList<LightningBolt>();
int[] backgroundColors = new int[]{0, 0, 0};
boolean[] backgroundDirections = new boolean[]{true, true, true};

void setup()
{
  size(500,500);
  background(0);
  frameRate(60);
}

void draw()
{
  background(backgroundColors[0], backgroundColors[1], backgroundColors[2]);
  
  for (int i=0; i < lightningBolts.size(); i++)
  {
    LightningBolt boltToDraw = lightningBolts.get(i);
    
    if (boltToDraw.boltReachesEdge())
    {
      boltToDraw.addBolt();
    }
    else
    {
      boltToDraw.removeBolt();
    }
    
    boltToDraw.drawBolt();
  }
  
  //maxRandom = mouseY;
  
  if (frameCount % 1 == 0)
  {
    lightningBolts.add(new LightningBolt(mouseX));
  }
  
  //backgroundColors[0] += (int)(Math.random()*4) - (backgroundDirections[0] ? 0 : 4);
  //backgroundColors[1] += (int)(Math.random()*3) - (backgroundDirections[1] ? 0 : 3);
  //backgroundColors[2] += (int)(Math.random()*2) - (backgroundDirections[2] ? 0 : 2);
  
  backgroundDirections[0] = (backgroundColors[0] > 200) ? false : backgroundDirections[0];
  backgroundDirections[1] = (backgroundColors[1] > 200) ? false : backgroundDirections[1];
  backgroundDirections[2] = (backgroundColors[2] > 200) ? false : backgroundDirections[2];
  
  backgroundDirections[0] = (backgroundColors[0] < 0) ? true : backgroundDirections[0];
  backgroundDirections[1] = (backgroundColors[1] < 0) ? true : backgroundDirections[1];
  backgroundDirections[2] = (backgroundColors[2] < 0) ? true : backgroundDirections[2];
  
  //println(backgroundColors);
}

void mousePressed()
{
  lightningBolts.add(new LightningBolt(width/2));
}
