// Vaiables setup for NeoPixels
#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif

#define PIN            6
#define NUMPIXELS      12

Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);

// Variables setup for Ultrasonic Distance Sensor
const int trigPin = 9;
const int echoPin = 10;

long duration;
int distance;

// Variables setup for Potentiometer
const int potPin = 0;
int potVal;


void setup() {
  // Initializing NeoPixels
  pixels.begin();
  pixels.show();
  pixels.setBrightness(4);
  
  // Setup sensor input & output
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  Serial.begin(9600);
}

void loop() {
  
  // Use potentiometer to set brightness
  
  potVal = analogRead(potPin);
  int adjustedBrightness = map(potVal, 0, 1024, 0, 32);
  pixels.setBrightness(adjustedBrightness);

  
  // Get distance from sensor
  
  // Clears the trigPin
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);

  // Sets the trigPin on HIGH state for 10 micro seconds
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  // Read the echoPin & calculate distance in CM
  duration = pulseIn(echoPin, HIGH);

  distance = duration * 0.034 / 2;

  // Print to Serial for debug
  Serial.print("Distance: ");
  Serial.print(distance);
  Serial.println("cm");

  // Output to NeoPixels

  int pixelDistance = map(distance, 0, 50, 0, NUMPIXELS -1);
  Serial.print("Pixel distance: ");
  Serial.println(pixelDistance);

  for(int i=0;i<pixelDistance;i++){
    pixels.setPixelColor(i, pixels.Color(66,191,244));
  }
  pixels.show(); // This sends the updated pixel color to the hardware.
  // Turn off the lights at the end of each cycle
  for(int i=0; i<pixelDistance; i++){
    pixels.setPixelColor(i, 0);
    }
}
