//REFERENCE
//Some methods are inspired by my classmate Chenye Zhu, Yifan Wang, week8 tutorial sheet and my tutor
import java.util.*;
processing.core.PShape ball;
//difine the gravity
float gravity=0.98;
//Add a ball array for adding new ball
ArrayList<Ball> array=new ArrayList<Ball>();
ArrayList<String> picture=new ArrayList <String>();

//initial set up and loading pictures
void setup(){
size(800,800,P3D);
picture.add("1.jpg");
picture.add("2.jpg");
picture.add("3.jpg");
picture.add("4.jpg");
}

//the function draw the ball
void draw(){
lights();
background(0);
pushMatrix();
translate(width/2,height/2,-400);
wall();
stroke(255,255,255);
popMatrix();

//create new ball if click
if(mousePressed==true){
float mx=mouseX;
float my=mouseY;
PImage img=loadImage(picture.get(int(random(0,4))));
Ball globe=new Ball(mx,my,15,img);
array.add(globe);
mousePressed=false;
}
//display and move every ball in the ball array
for(int i=0;i<array.size();i++){
  array.get(i).display();
  array.get(i).move_collision();
  
  //check the collision between balls
  if(i!=0){
    for(int j=0;j<i;j++){
     // print("testing");
     int xdistance=int(array.get(i).getx()-array.get(j).getx());
     int ydistance=int(array.get(i).gety()-array.get(j).gety());
     int zdistance=int(array.get(i).getz()-array.get(j).getz());
     // if the distance between balls is less than the diameter, there will be a coillision
      if(sqrt(xdistance*xdistance+ydistance*ydistance+zdistance*zdistance)<30){
        print("collsion");
        array.get(i).inverseV();
        array.get(j).inverseV();
        }
      }
    }//*/
  }
}

//initial setting of walls
void wall(){
beginShape();  
vertex(400, 400, -400);
vertex(-400, 400, -400);
vertex(-400, 400, 400);
vertex(400, 400, 400);

vertex(400, -400, 400);
vertex(-400, -400, 400);
vertex(-400, -400, -400);
vertex(400, -400, -400);
vertex(-400, -400, -400);
vertex(-400, -400, 400);
vertex(400, -400, 400);

vertex(400, 400, 400);
vertex(-400, 400, 400);
vertex(-400, -400, 400);
vertex(400, -400, 400);
vertex(-400, -400, 400);
vertex(-400, 400, 400);
vertex(400, 400, 400);
vertex(400, -400, 400);
vertex(-400, -400, 400);
vertex(-400, -400, -400);

vertex(400, -400, -400);
vertex(-400, -400, -400);
vertex(-400, 400, -400);
vertex(400, 400, -400);
vertex(-400, 400, -400);
vertex(-400, -400, -400);
vertex(-400, -400, 400);
vertex(400, -400, 400);
vertex(400, 400, 400);

vertex(-400, 400, 400);
vertex(-400, 400, -400);
vertex(-400, -400, -400);
vertex(400, -400, -400);
vertex(400, 400, -400);
vertex(400, 400, 400);
vertex(400, -400, 400);
vertex(400, -400, -400);
endShape();
}

//ball object
class Ball{
private float x;
private float y;
private float z=0;
private int r;
private float vx;
private float vy;
private float vz;
private PImage image; 
//constructor
Ball(float x,float y,int r,PImage image){
  this.x=x;
  this.y=y;
  this.r=r;
  this.vx=random(-20,20);
  this.vy=random(-20,20);
  this.vz=random(-30,-50);//random(-10,-3);
  this.image=image;
}

float getx(){
  return x;
}
float gety(){
  return y;
}
float getz(){
  return z;
}

//if balls have collision with each other, change their speed direction
void inverseV(){
vx=-0.9*vx;

vy=-0.9*vy;
if(vy>0){
y+=random(0,50);
}
if(vy<=0){
y-=random(0,50);
}
vz=-0.9*vz;
}
//display ball
void display(){
  pushMatrix();
  translate(x,y,z);
  noFill();
  ball=createShape(SPHERE,r);
  ball.setStroke(false);
  ball.setTexture(image);
  shape(ball);
  smooth();
  popMatrix();
  }

//ball movement and collision with wall
void move_collision(){
//move
  x+=vx;
  y+=vy;
  z+=vz;
  if(vx>0){
   vx=vx-0.15; 
  }
  if(vx<0){
  vx=vx+0.15;
  }
  if(vy>0){
  vy=vy-0.15;
  }
  if(vy<0){
  vy=vy+0.15;
  }
  if(vz>0){
  vz=vz-0.15;
  }
  if(vz<0){
  vz=vz+0.15;
  }
  if(vx>-0.15&&vx<0.15){
  vx=0;
  }
  if(vy>-0.15&&vy<0.15){
  vy=0;
  }
  if(vz>-0.15&&vz<0.15){
  vz=0;
  }

  if(z<=-600){
    vz=-vz;
  }
  
  if(z>0){
    vz=-vz;
  }

  if(y>770){
    vy=-vy;
  }
  if(y>770&&vz==0&&vx==0){
  vy+=0;
  }
  else{
  vy+=gravity;
  }
  if(x>750||x<0){
    vx=-vx;
  }
}
}
