import controlP5.*;
import javax.swing.Timer;
import java.awt.event.*;
import java.nio.ByteBuffer;
import processing.serial.*;


/***********************************************
 * User spcification section
 **********************************************/
int windowWidth =1200;      // set the size of the 
int windowHeight = 600;     // form

float InScaleMin = 15;       // set the Y-Axis Min
float InScaleMax = 35;    // and Max for both
float OutScaleMin = 0;      // the top and 
float OutScaleMax = 255;    // bottom trends

int field1StartX = 10;
int field1StartY = 20;
int fieldSizeX = 100;
int fieldSizeY = 20;
int fieldSpaceX = 20;
int fieldSpaceY = 20;

//float displayFactor = 1; //display Time as Milliseconds
//float displayFactor = 1000; //display Time as Seconds
int displayFactor = 60000; //display Time as Minutes

int windowSpanMin = 5, // number of minutes into the past you want to display
    windowSpan = windowSpanMin * displayFactor;    
int refreshRate = 100;      // how often you want the graph to be reDrawn;

//other declared variables
int nextRefresh; //sets refresh rate counter
int arrayLength = windowSpan / refreshRate+1;
int[] probe1Data = new int[arrayLength];     //temperature arrays
int[] probe2Data = new int[arrayLength];  
int[] probe3Data = new int[arrayLength];

float graphTop = 25;
float graphHeight = (windowHeight-70);
//float outputTop = inputHeight+50;
//float outputHeight = (windowHeight-70)*1/3;

float ioLeft = 350, ioWidth = windowWidth-ioLeft-50;
float ioRight = ioLeft+ioWidth;
float pointWidth= (ioWidth)/float(arrayLength-1);
int vertCount = 10;

/***********************************************
 * end user spec
 **********************************************/
 
int nPoints =0;
int debugcount = 0;
float probe1temp, probe2temp, probe3temp; //declare temps
boolean madeContact = false, justSent = true, firstrun=true; //declare comm bools
int   d, m, y, h, mn, s, ms, msStart;

/* setup timer */
Timer hsclock = new Timer(1000, new ActionListener(){
  public void actionPerformed(ActionEvent e){
    msStart = millis();
  }
});
 

      

/*  setup controlP5   */
ControlP5 controlP5; //initialize controlP5 instance
controlP5.Button send_settingsButton, savebutton, restartbutton; //define buttons
controlP5.Textfield probe1field, probe2field, probe3field, set1, set2, set3, Kp1, Ki1, Kd1;  //define fields



PFont AxisFont, TitleFont;

PrintWriter output, serialDebug;

void setup(){
  serialDebug = createWriter("serialDebux.txt"); //start debug file
  output = createWriter("TempData.txt");  //start data log
  
  frameRate(30);
  size(windowWidth , windowHeight);
  AxisFont = loadFont("axis.vlw");
  TitleFont = loadFont("Titles.vlw");
  
  hsclock.start(); //start ms clock

  setupUI();
  //setupSerial();
  nextRefresh=millis();
}

void draw(){
  background(0);
  fill(255);
  
  print("run ");
  println(debugcount);
  d = day();
  m = month();
  y = year();
  h = hour();
  mn = minute();
  s = second();
  ms = millis() - msStart;
  
  
  fakeData();
  drawGraph();
  output.println(m + "/" + d + "/" + y + " " + h + ":" + mn + ":" + s + "." + ms + ", " + probe1temp + ", " + probe2temp + ", " + probe3temp);
  debugcount++;
}


void fakeData(){
  madeContact = true;
  if (debugcount==0) {
    probe1temp=20;
    probe2temp=25;
    probe3temp=16;
    firstrun=false;
    print("first run: ");
  }
  if (debugcount>0){
    if (probe1temp <= 22){
      probe1temp += random(-0.02,.1);
      //print("probe1 low");
    }
    if (probe1temp > 22 && probe1temp < 28) {
      probe1temp += random(-.1,.1);
      //print("probe1 med");
    }
    if (probe1temp >= 28) {
      probe1temp += random(-.1,0.02);
      //print("probe1 high");
    }
    
    if (probe2temp <= 18){
      probe2temp += random(-0.02,.1);
    }
    if (probe2temp > 18 && probe2temp < 20) {
      probe2temp += random(-.1,.1);
    }
    if (probe2temp >= 20) {
      probe2temp += random(-.1,0.02);
    }
    
    if (probe3temp <= 30){
      probe3temp += random(-0.02,.1);
    }
    if (probe3temp > 30 && probe3temp < 32) {
      probe3temp += random(-.1,.1);
    }
    if (probe3temp >= 32) {
      probe3temp += random(-.1,0.02);
    }

    
  }
  probe1field.setText(nf(probe1temp,2,2));
  probe2field.setText(nf(probe2temp,2,2));
  probe3field.setText(nf(probe3temp,2,2));
      
}




