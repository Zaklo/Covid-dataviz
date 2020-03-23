// setuping global variables
float x = 0;
float[] RX,RY,RZ;
int density = 0; // number of dots in sphere surface
int R;
int j = 0;
color[] colors = {color(201,35,35),color(50,209,74),color(255)};


void mousePressed() {
    if(j < 2) j++;
    else j = 0;
    draw();
    setup();
}

void setup() {

  String url = "https://coronavirus-19-api.herokuapp.com/all";
  JSONObject json = loadJSONObject(url);
  int recovered = json.getInt("recovered");
  int deaths = json.getInt("deaths");
  int cases = json.getInt("cases");
  int active = cases - (recovered + deaths);
  
  int[] tab = {active, recovered, deaths};
  
  density = tab[j]/100;
    
  size(1920, 1080, P3D);
  background(0);
  // rate of looping through draw 
  frameRate(30);
  // Radius of sphere
  R = 200;
  RX = new float[density];
  RY = new float[density];
  RZ = new float[density];
  // generating random variables
  for(int i = 0; i < density ; i++){
      RX[i] = random(-R,+R);
      RY[i] = random(-sqrt(pow(R,2)-pow(RX[i],2)),+sqrt(pow(R,2)-pow(RX[i],2)));
      if(random(0,1) < 0.5) {
        RZ[i] = +sqrt( pow(R,2) - pow(RX[i],2) - pow(RY[i],2) );  
      } else {
        RZ[i] = -sqrt( pow(R,2) - pow(RX[i],2) - pow(RY[i],2) );
      }
    }  
}



void draw() {
     background(0);
     lights();
     
     camera(0, 0, height/2, 0, 0, -x*60, 0, 1, 0);
     //camera(0, 0, 600-x*60, 0, 0, -x*60, 0, 1, 0);
      
     stroke(150);
     strokeWeight(2);
     x += 0.009;
     pushMatrix();
     rotateZ(x/2);
     rotateX(x/2);
     for(int i = 0; i < density-1 ; i++){
        stroke(colors[j]);
        strokeWeight(2);
        point(RX[i],RY[i],RZ[i]);
        stroke(40);
        strokeWeight(0.4);
        line(RX[i],RY[i],RZ[i],RX[i+1],RY[i+1],RZ[i+1]);
     }   
     popMatrix();
     // if you want to export each frame as image and then make a movie uncomment this line    
     //saveFrame("cplx-######.png");
}
