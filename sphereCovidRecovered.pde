// setuping global variables
float x = 0;
float[] RX,RY,RZ;
int density = 0; // number of dots in sphere surface
int R;

void setup() {

  String url = "https://coronavirus-19-api.herokuapp.com/all";
  JSONObject json = loadJSONObject(url);
  int recovered = json.getInt("recovered");
  int deaths = json.getInt("deaths");
  int cases = json.getInt("cases");
  int active = cases - (recovered + deaths);
  density = deaths /100;
  
  size(800, 800, P3D);
  background(0);
  // rate of looping through draw 
  frameRate(30);
  // Radius of sphere
  R = 100;
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
     //moving camera through sphere
     camera(0, 0, height/2, 0, 0, -x*60, 0, 1, 0);
      
     stroke(150);
     strokeWeight(2);
     x += 0.005;
     pushMatrix();
     rotateZ(x/2);
     rotateX(x/2);
     for(int i = 0; i < density-1 ; i++){
        stroke(250);
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
