import processing.video.*;
import processing.serial.*; 
 
Serial port;                             // Create object from Serial class 
int val;                                 // Data received from the serial port 
// int preVal;

Capture video;

int x = 0;

int maxFile = 500; //Total # of documented images

int fileTimer = 15; //Timer to save documentation

int fileIndex = 0; //Initial image to be saved

String[] fileNames = new String[maxFile]; //Declaring an array for images to document

//PImage startScreen;

void setup() {
  size(1280,480);
  video = new Capture (this, 640, 480, 30); //(this LOOKUPWTFmeansthissketch, w, h, fps OPT)
  video.start();
  
  //startScreen = loadImage("doc0.png");
  //image(startScreen, 0, 0, width, height);
  
  String portName = Serial.list()[0]; // replace this number with the port you are using
  port = new Serial(this, portName, 9600);
  
  for(int f = 0; f < fileNames.length; f++){
    fileNames[f] = "data/doc" + f + ".png";
  }
  
  frameRate(30);
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  if (0 < port.available()) {    // If data is available,
    //println("reading");
    val = port.read();                   // read it and store it in val
  }
  
  //image(video,0,0);
  int w = video.width;
  int h = video.height;
  copy(video, w/2, 0, 1, h, x, 0, 1, h); //needs NINE arguments copy(1thing copy from, 2xfrom, 3yfrom, 4wfrom, 5hfrom, 6xto, 7yto, 8wto, 9hto)
  
  x = x + 1;
  
  if (x > width) {
    x = 0;
  }
  
  if (val == 0) {
    x = int(random(0, width));
    
  }
  
  int fileCount = second() % fileTimer;

  if ((fileCount % fileTimer) == 0){
      saveFrame(fileNames[fileIndex]); //Saves current frame to output file
      fileIndex++; //Increases fileIndex every time conditional is called
      /*
      println("fuck is " + fuck); //Prints if conditional is met
      fuck++; //Increases fuck every time conditional is called
      */
      delay(1000); //Makes conditional run only once per reference time
    }
  
  
}