/*
    Arduino and MPU6050 IMU - 3D Visualization Example 
     by Dejan, https://howtomechatronics.com
*/
import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;
//PImage img;
Serial myPort;
String data="";
float roll, pitch,yaw;
void setup() {
  size (2000, 1000, P3D);
  //img = loadImage("ESTRUDECT.jpg");
  myPort = new Serial(this, "COM13", 115200); // starts the serial communication
  myPort.bufferUntil('\n');
}
void draw() {
  translate(width/2, height/2, 0);
  background(233);
  textSize(22);
  text("Roll: " + int(roll) + "     Pitch: " + int(pitch) + "    Yaw: " + int(yaw), -50, 265);
  // Rotate the object
  //rotateX(radians(pitch));
  //rotateZ(radians(roll));
  //rotateY(radians(yaw));
  
  rotateX(radians(roll));
  rotateZ(radians(-yaw));
  rotateY(radians(pitch));
  
  // 3D 0bject
  textSize(30);  
  fill(0, 76, 153);
  box (386, 40, 200); // Draw box
  //image(img, 40, 200);
  textSize(25);
  
  fill(255, 255, 255);
  text("www.agrcology.com", -183, 10, 101);
  //delay(10);
  //println("ypr:\t" + angleX + "\t" + angleY); // Print the values to check whether we are getting proper values
}
// Read data from the Serial Port
void serialEvent (Serial myPort) { 
  // reads the data from the Serial Port up to the character '.' and puts it into the String variable "data".
  data = myPort.readStringUntil('\n');
  // if you got any bytes other than the linefeed:
  if (data != null) {
    data = trim(data);
    // split the string at "/"
    String items[] = split(data, '/');
    if (items.length > 1) {
      //--- Roll,Pitch in degrees
      roll = float(items[0]);
      pitch = float(items[1]);
      yaw = float(items[2]);
    }
  }
}
