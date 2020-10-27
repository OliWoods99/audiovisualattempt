
import ddf.minim.*;

Minim minim;
AudioInput in;


void setup()
{
  size(1000, 800);

  minim = new Minim(this);
  

  in = minim.getLineIn(Minim.MONO);
  
  System.out.println(in.bufferSize());
  
  frameRate(24);
}

void draw()
{
  background(0);
  stroke(255);
  
  //change z to change amount of circles drawn, looks cool with a high z but lags massively
  float z = 0.3;
  
  for(float i = 0; i < 1; i = i + z){
    drawCircleFFT(i);
  }
  
  saveFrame("output/####.png");
  
}
void drawCircleFFT(float t){
    float r = (( t * in.bufferSize())/ 2 * PI);
    r = r/2;
    
    for(int i = 0; i < in.bufferSize(); i++){
    
      float angle = (2 * PI)/ in.bufferSize();
      
      r = r + (in.left.get(i) * 10);
    
      float x = (r/2) * cos(i * angle) + (width/2);
      float y = (r/2) * sin(i * angle) + (height/2);
    
      float x1 = (r/2) * cos((i + 1) * angle) + (width/2);
      float y1 = (r/2) * sin((i + 1) * angle) + (height/2);
    
    
      line( x, y, x1, y1);
      
    
   }
}

void drawCircle(){
  
  int r = (int)(in.bufferSize()/ 2 * PI);
  r = r/2;
  
  //noFill();
  //ellipse(width/2,height/2,r,r);
  
  
  for(int i = 0; i <= in.bufferSize(); i++){
    
    float angle = (2 * PI)/ in.bufferSize();
    
    float x = (r/2) * cos(i * angle) + (width/2);
    float y = (r/2) * sin(i * angle) + (height/2);
    
    float x1 = (r/2) * cos((i + 1) * angle) + (width/2);
    float y1 = (r/2) * sin((i + 1) * angle) + (height/2);
    
    line(x,y,x1,y1);
  }
}
void drawLineFFT(){
  
   for(int i = 0; i < in.bufferSize() - 1; i++){
    
    line( i, (height/2) + in.left.get(i) * 100, i+1, (height/2) + in.left.get(i+1) * 100);
    line( i, (height/2) + in.right.get(i) * 100, i+1, (height/2) + in.right.get(i+1) * 100);
  }
}
