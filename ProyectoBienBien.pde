 //Flappy
//El pájaro
int xP, yP, rP;
float g=0;
float vy; 
float vx;
PImage fotos;
PFont tipografia;
PImage fondo;

int marcador;


//Obstáculos
float x0;
float y1;
float y2;
float[] h1;
float h;
float[] h2;
float w1;
int n, dx;
float[] x;

//JUEGO
int estadoJuego;
boolean flagJuegoIniciado;
boolean flagSalto;



void setup(){
  size(1000,700);
  fondo = loadImage("fondooo.png");
  //Pelotita
  rP = 48;
  xP = 200;
  fotos = loadImage("pabloo.png");
  
  tipografia = loadFont("Flappy-Bird-48.vlw");
  textFont(tipografia);
  
  //Obstáculo
  n = 6;
  w1 = 40;
  dx = 220;
 
   //pelota pegada al borde izquierdo del canvas
  y1 = 0;
  vx = 2;
  h = 250;
  
  h1 = new float[n];
  h2 = new float[n];
  x= new float[n];
  
  inicializar();
  
 
  
}

void inicializar(){
  yP = height/2-rP;
  x0 = width + w1;
  
  //COntrolJuego
  flagJuegoIniciado = false;
  estadoJuego = 0;
  
  for(int i = 0; i < n; i++){ 
   h1[i] = random(0,height -h);
   h2[i] = height - h  - h1[i];
    y2 = h1[i] + h; 
   x[i] = x0+i*(w1+dx);
  
  }
  flagSalto = true;
  
  marcador = 0;
  vx=2;
  
}

void draw(){
  background(fondo);
  
  if(estadoJuego == 0){
  fill(255,255,100);
  textAlign(CENTER);
  textSize(100);
  text("FLAPPY PABLO", width/2, height/2-20);
  textSize(60);
  fill(255,0,100);
  text("Presione la barra espaciadora para iniciar", width/2, height/2 + 120);
  
  
  
  if(keyPressed){
    if(key == ' '){
      estadoJuego = 1;
    }
  }
  }
  
  if(estadoJuego == 1){
  

    if(keyPressed){
      if(flagSalto){
       if(key == ' '){
         vy = -10;
          g = .5;
       }
       }
    }

    textAlign(CENTER);
    fill (255);
    textSize(40);
    text(marcador, width/2, 30);
    
    
    

  //Pelota
  fill(0,250,250);
  image(fotos, xP, yP);
  vy+=g;
  yP+=vy;
  noFill();
  
  //Obstáculo
  fill(#28932E);
    
  for(int i = 0; i < n; i++){ 
    rect(x[i], y1, w1, h1[i]);
    rect(x[i], h1[i] + h, w1, h2[i]);
    
    
     
      
      
      
    //
    if((xP + rP/2) >= x[i] + (w1- 22)){
    if(xP + rP/2 <= x[i] + (w1 - 21)){
     marcador++;
    }
    }
  

  
     //movemos el obstáculo
    x[i]+=-vx; 
    if(x[i] < - (w1 + 10)){
      if(i==0){
        x[i] = x[n-1] + w1 + dx;
        vx+=0.3;
      }else{
        x[i] = x[i-1] + w1 + dx; 
      }
    
      h1[i] = random(0,height -h);
      h2[i] = height - h  - h1[i];
     
    }
    
    //Colisión pelota
      if((xP + rP >= x[i]) && (xP - 40) <= x[i] + w1){
      if((yP  <= h1[i]) || ((yP +  rP) >= h1[i] + h)){
        flagSalto = false; 
        
      }
    }
    
    if(!flagSalto){
      yP += 2;
    }
     
     
  }
    

  noFill();
 


  //Límite pelotita
  if(yP  < 0){
    yP = rP;
    vy -=vy;
  }
  if(yP > height - rP) yP = height - rP;
   
  
  
  if(yP + rP >= height){
    estadoJuego = 2;
  }
  }
  
  
  if(estadoJuego == 2){

     fill(255, 255, 0);
    textAlign(CENTER);
    text("Game Over", width/2, height/2+40);
      textSize(40);
   
    fill(#85FCDF);
    text("Record=" + marcador, width/2, height/2 + 80);
   
    fill(0, 255, 0);
    text("Presione A para iniciar nuevamente", width/2, height/2+110);
    textSize(100);
    
    
  }
  
}

void keyReleased(){
  if(estadoJuego == 2){
    if(key == 'a'){
    inicializar();
    estadoJuego=1;
      vy = -10;
          g = .5;
    
    
  
  }
  }
}
