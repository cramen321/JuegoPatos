//se guardan en sensor value los valores de 0 a 1024
int sensorValue;
int sensorValue2;
int sensorValue3;
int sensorValue4;

int inputIN = 13;
int inputIN2 = 12;
int inputIN3 = 11;
int inputIN4 = 10;

int valorPulsador = 0;
String data;

void setup() {
  // put your setup code here, to run once:

  Serial.begin(9600);
  pinMode(sensorValue, INPUT);
  pinMode(sensorValue2, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  //hay una diferrencia si al final se pone /4

  sensorValue = digitalRead(inputIN);
  sensorValue2 = digitalRead(inputIN2);
  sensorValue3 = digitalRead(inputIN3);
  sensorValue4 = digitalRead(inputIN4);

data=normalizeData(sensorValue,sensorValue2);
Serial.println(data);

  //comprobar valores, mostrarlos en el monitor en forma de nùmero
  Serial.print(sensorValue, DEC);
  Serial.print(sensorValue2, DEC);
  Serial.print(sensorValue3, DEC);
  Serial.print(sensorValue4, DEC);

  //enviar valores a processing
  Serial.write(sensorValue);
  Serial.write(sensorValue2);
  Serial.write(sensorValue3);
  Serial.write(sensorValue4);


  delay(100);
}
String normalizeData(int b1, int b2) {
 
  String B1string = String(b1);
  String B2string = String(b2);
 
  
  String ret = String("S") + B1string + B2string + String("E");
  return ret;
}
