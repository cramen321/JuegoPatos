import processing.serial.*;

Serial port;

int sensor;
int sensor2;
int sensor3;
int sensor4;

float posX[];
float posY[];

float posX1[];
float posY1[];

float posX2[];
float posY2[];

int estado[];

float distancia = 0;
float distancia1 = 0;
float distancia2 = 0;

int time = 0;

int puntaje = 0;

PImage pato;
PImage pato1;
PImage pato2;
PImage fondo;
PImage fondo1;
PImage mano;

float offset = 0;
float easing = 0.05;

int gameScreen = 0;

float curY;
float curX;
void setup()
{
 port= new Serial(this, Serial.list()[0],9600);
    
 size(400,600);
 
 pato=loadImage("patito.png");
 pato1=loadImage("patito2.png");
 pato2=loadImage("patito3.png");
 fondo=loadImage("fondoPatos.jpg");
 fondo1=loadImage("fondo1.jpg");
 mano=loadImage("mano.png");
  
 
 posX= new float[100];
 posY= new float[100];
 
 posX1= new float[100];
 posY1= new float[100];
 
  posX2= new float[100];
 posY2= new float[100];
 
 estado = new int[150];
 
 //lleno el arreglo
 for(int i=0;i<100;i++)
 {
   posX[i]= random(-1600);
   posY[i]= 100;
   
   posX1[i]= random(1600);
   posY1[i]= 200;
   
   posX2[i]= random(-1600);
   posY2[i]= 300;
   
   estado[i] = 1;
 }
}
void draw()
{
  println(port.read());
  
  if (gameScreen == 0) {
    initScreen();
  } else if (gameScreen == 1) {
    gameScreen();
  }
}
void initScreen(){
  image(fondo1,0,0,400,600); 
}
public void mousePressed() {
  // if we are on the initial screen when clicked, start the game
  
  if (gameScreen==0) {
    startGame();
  }
}
void startGame() {
  gameScreen=1;
}
void gameScreen(){  
 background(45,92,134);
 image(fondo,0,0,400,600); 
 
 if(port.available()>0){
   sensor=port.read();
   sensor2=port.read();
   sensor3=port.read();
   sensor4=port.read();

   if(sensor==1){
     curY+=20;
   }
   if(sensor2==1){
     curX+=20;
   }
   }
 image(mano,curY,420,39,340); 
 
 fill(255,0,0);
 rect(curY,curX,10,10);
  
 fill(150,68,20);
 for(int i=0; i<100; i++)
 {
   if(estado[i] == 1)
   {
  //ellipse(posX[i],posY[i],20,20); 
  image(pato,posX[i],posY[i],42,42);
  image(pato1,posX1[i],posY1[i],42,42); 
  image(pato2,posX2[i],posY2[i],42,42); 
   }
 }
 
 for(int i=0; i<100; i++)
 {
   //damos movimiento a las bolitas
  posX[i]= posX[i]+ random(5,12); 
  posX1[i]= posX1[i]- random(6,8);
  posX2[i]= posX2[i]+ random(8,10);
 }
 
 for(int i=0; i<100; i++)
 {
 // if(mousePressed)
 if(sensor3==1)
  {
    //las matamos a cierta distancia
    distancia = dist(curX, curY, posX[i], posY[i]);
    distancia1 = dist(curX, curY, posX1[i], posY1[i]);
    distancia2 = dist(curX, curY, posX2[i], posY2[i]);
    if(distancia<=30)
    {
     estado[i]=0; 
    }
    else if(distancia1<=30)
    {
      estado[i]=0; 
    }
    else if(distancia2<=30)
    {
      estado[i]=0; 
    }
  }
 }
 
 fill(255);
 text("SCORE: "+puntaje, 30,415);
 puntaje=0;
 for(int i=0; i<100; i++)
 {
   if(estado[i] == 0)
   {
    puntaje = puntaje+1; 
   }
 }
 
 println(puntaje);
 
 //tiempo
 time= millis()/1000;
 text("tiempo "+time, 300,415);
 if(time>=13)
 {
 fill(255);
 text("GAME OVER", 155,200);  
 }
}
