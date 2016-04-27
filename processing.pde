
int SIZE = 50;

magnet[] rects;

class Point{
  int x,y;
  Point(int a, int b){
    x = a;
    y = b;
  }
}

class magnet{
  int x, y;
  float vx, vy;
  float ax, ay;
  magnet(int a, int b){
    x = a;
    y = b;
    vx = 0;
    vy = 0;
    ax = 0;
    ay = 0;
    fill(0.8);
    rect(x-SIZE/2, y-SIZE/2, SIZE,SIZE);
  }
  void update(){
    //ax *= 0.9;
    //ay *= 0.9;
    vx += ax;
    vx *= 0.9;
    vy += ay;
    vy *= 0.9;
    x += vx;
    y += vy;
    if(x < 0) {
      x = 0;
      vx = ax = 0;
    }
    if(y < 0) {
      y = 0;
      vy=ay=0;
    }
    if(x > width) {
      x = width;
      ax=vx=0;
    }
    if(y > height) {
      y = height;
      ay=vy=0;
    }
  }
  void display(){
    fill(0.8);
    rect(x-SIZE/2, y-SIZE/2, SIZE,SIZE);
  }
}

void setup (){
  size(640,360);
  //rectMode(CORNERS);
  rects = new magnet[0];
  //rects[0] = new magnet(width/2, height/2);
}

void draw (){
  background(102);
  fill(0.2);
  rect(mouseX-SIZE/2, mouseY-SIZE/2, SIZE,SIZE);
  update_acc();
  for (magnet n:rects){
    n.update();
    n.display();
  }
}

void update_acc(){
  for (magnet n:rects){
    float ax = 0;
    float ay = 0;
    for(magnet m:rects){
      if(n.x==m.x && n.y==m.y){
        continue;
      }
      float rad = atan2(n.x-m.x, n.y-m.y);
      //println(rad*180/3.14);
      float dist = sqrt(sq(n.x-m.x)+sq(n.y-m.y));
      ax += 10000/sq(dist)*sin(rad);
      ay += 10000/sq(dist)*cos(rad);
    }
    println("ax:", ax, "    ay:", ay);
    n.ax = ax;
    n.ay = ay;
  }
}

void mouseReleased(){
 magnet tmp= new magnet(mouseX, mouseY);
 rects = (magnet[])append(rects,tmp);
}
