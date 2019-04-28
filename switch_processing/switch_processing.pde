import meter.*;
import controlP5.*;
import processing.serial.*;


Serial myPort;  // The serial port
RadioButton passengers;
Meter m;
ControlP5 cp5, cp6, cp7, cp8;
public boolean ac1, lights1, add1;
public float lightval,range,speed_factor,speed=30,consumption1,consumption2,consumption3,consumption4,time,grad=1.5,acval;
public int adval;

void setup() {
  size(1000, 1000); 
  background(0, 0, 0);
  m=new Meter(this, 250, 400);
  m.setTitleFontName("Arial bold");
  m.setTitle("Range ");
  String[] scaleLabels={"0", "10", "20", "30", "40", "50", "60", "70", "80", "90","100","110","120","130"};
  m.setScaleLabels(scaleLabels);
  m.setScaleFontSize(18);
  m.setScaleFontName("Time new roman bold");
  m.setScaleFontColor(color(200, 30, 70));

  m.setDisplayDigitalMeterValue(true);

  m.setArcColor(color(141, 113, 178));
  m.setArcThickness(15);
  m.setMaxScaleValue(130);
  m.setMinInputSignal(0);
  m.setMaxInputSignal(130);
  m.setNeedleThickness(3);




  cp5=new ControlP5(this);
  cp6=new ControlP5(this);
  cp7=new ControlP5(this);
  cp8=new ControlP5(this);



  cp5.addButton("ac").setValue(0).setPosition(300, 100).setSize(100, 50);
  cp6.addButton("lights").setValue(0).setPosition(500, 100).setSize(100, 50);
  cp7.addButton("additional_features").setValue(0).setPosition(400, 200).setSize(100, 50);
  passengers=cp8.addRadioButton("No of people", 104, 36).setPosition(400, 300);  
  passengers.setSize(20, 20);
  passengers.setColorForeground(color(255));
  passengers.setColorActive(color(100));
  passengers.setColorBackground(color(180));
  passengers.setSpacingRow(4);    
  passengers.addItem("1", 1);
  passengers.addItem("2", 2);        
  passengers.activate(1);

myPort= new Serial(this,Serial.list()[0],9600);
}




void draw() {
  background(10, 20, 30);




  if (myPort.available() > 0) {
      char inByte = myPort.readChar();
      println(inByte);
      if(inByte == '1') {
        cp5.setColorBackground(color(255, 27, 27));
       acval=1.5; 
      }
      else if( inByte == '0' ) {
        cp5.setColorBackground(color(27, 255, 105));
        acval=0;
      }
      
    }


//  if (ac1) {
//    cp5.setColorBackground(color(255, 27, 27));    //ac is  off
//acval=0;  
//} else
//  {
//    cp5.setColorBackground(color(27, 255, 105));           //ac is on
//    acval=1;
//  }



  if (lights1) {
    cp6.setColorBackground(color(255, 27, 27));            //lights are off
lightval=0;  
} else
  {
    cp6.setColorBackground(color(27, 255, 105));          //lights are on
lightval=0.5;  
}


  if (add1) {
    cp7.setColorBackground(color(255, 27, 27));
adval=0;  
} else
  {
    cp7.setColorBackground(color(27, 255, 105));
adval=1;  
}
speed_factor=(((0.0002)*(speed*speed)-(0.0006*speed)+0.6786));
consumption1=((1.684*(1310+75))+2056.9)/1000;                            //passengers=75
consumption2=speed_factor*consumption1;
consumption3=(consumption2*0.9)+(consumption2*1.75*0.1);                  //gradient=1.75;
consumption4=consumption3+acval+adval+lightval;
time=(((((16*(0.95)*(1.1))/consumption4))));
range=(time*speed);
int result=(int) range;
if(range>130)
{
  result=130;
}




  m.updateMeter(result);



}


public void ac() {


  if (!ac1) {
    ac1=true;
  } else {
    ac1=false;
  }
}
public void lights()
{
  if (!lights1) {
    lights1=true;
  } else {
    lights1=false;
  }
}
public void additional_features()
{
  if (!add1) {
    add1=true;
  } else {
    add1=false;
  }
}
