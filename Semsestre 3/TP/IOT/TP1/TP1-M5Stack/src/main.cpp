#include <M5Stack.h> 
uint8_t i=0; 

void setup(){ 
  M5.begin(); //Init M5Core. Initialize M5Core
  M5.Power.begin(); //Init Power module. Initialize the power module
  M5.Lcd.setTextColor(RED);
  M5.Lcd.setTextSize(3);
  M5.Lcd.println("Hello IUT !"); 
  Serial.begin(115200); 
}

void loop() { 
  delay(500);
  M5.Lcd.setTextColor(GREEN);
  M5.Lcd.print("Affichage :");
  i = i+1;
  M5.Lcd.println(i+1);

  Serial.println("On a affiché : " + (String)i); 

}