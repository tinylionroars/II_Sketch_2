import processing.video.*;
import processing.serial.*; 
 
Serial port;                             // Create object from Serial class 
int val;                                 // Data received from the serial port 
int preVal;

Capture video;

int x = 0;

void setup() {
  size(1280,480);
  video = new Capture (this, 640, 480, 30); //(this LOOKUPWTFmeansthissketch, w, h, fps OPT)
  video.start();
  
  String portName = Serial.list()[0]; // replace this number with the port you are using
  port = new Serial(this, portName, 9600);
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
  
  if (val == 0) {
    x = 0;
  }
}