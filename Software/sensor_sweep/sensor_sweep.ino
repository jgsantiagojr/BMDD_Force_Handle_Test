
#include <Adafruit_LSM6DS33.h>
#include <Wire.h>

struct Pressure_sensors
{
  int s1_pin;
  int s2_pin;
  int s3_pin;
};

struct IMUs
{
  int left_addr;
  int right_addr;
};

struct Pressure_sensors left_side ={A0,A1,A2};
struct Pressure_sensors right_side = {A3,A4,A5};
struct IMUs imus = {0x6A ,0x6B};

Adafruit_LSM6DS33 right_imu;
Adafruit_LSM6DS33 left_imu;

void read_IMU(Adafruit_LSM6DS33 imu, String type);
void read_Pressures(struct Pressure_sensors sensors, String type);
bool led = true;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  Wire.begin();
  if (!left_imu.begin_I2C(imus.left_addr)){
    Serial.println("Failed to find 0x6A left IMU");
  }
  if (!right_imu.begin_I2C(imus.right_addr)){
    Serial.println("Failed to find 0x6B right IMU");
  }
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  read_IMU(right_imu, "R");
  read_IMU(left_imu, "L");

  read_Pressures(right_side, "R");
  read_Pressures(left_side, "L");

  if(led){
    led = false;
    digitalWrite(LED_BUILTIN, HIGH);
  }else{
    led = true;
    digitalWrite(LED_BUILTIN, LOW);
  }
  delay(10);
  
}

void read_IMU(Adafruit_LSM6DS33 imu, String type){
  sensors_event_t accel;
  sensors_event_t gyro;
  sensors_event_t temp;
  imu.getEvent(&accel, &gyro, &temp);
  Serial.print(type);
  Serial.print("AccelX:");
  Serial.println(accel.acceleration.x);
  Serial.print(type);
  Serial.print("AccelY:");
  Serial.println(accel.acceleration.y);
}

void read_Pressures(struct Pressure_sensors sensors, String type){
  int s1_value = analogRead(sensors.s1_pin);
  int s2_value = analogRead(sensors.s2_pin);
  int s3_value = analogRead(sensors.s3_pin);
  
  Serial.print(type);
  Serial.print("Sense1:");
  Serial.println(s1_value);
  Serial.print(type);
  Serial.print("Sense2:");
  Serial.println(s2_value);
  Serial.print(type);
  Serial.print("Sense3:");
  Serial.println(s3_value); 
}
