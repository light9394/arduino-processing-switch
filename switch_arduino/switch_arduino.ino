    
int pin = 9;
void setup() {
  // put your setup code here, to run once:
  pinMode(pin, INPUT_PULLUP);
  Serial.begin(9600);

}
void loop() {

  if (digitalRead(9) == LOW) {
    Serial.write("1");
    delay(100);
  }
  else {
    Serial.write("0");
    delay(100);
  } 
}
