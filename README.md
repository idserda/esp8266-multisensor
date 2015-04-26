# ESP8266 MultiSensor

This code shows how to create a simple Wi-Fi module with a light, temperature and movement sensor using an ESP8266 module. It uses [mqtt](http://mqtt.org/) to send these readings to a central location.

### Parts

- ESP-12 (or another ESP8266 with 2 GPIO's and the ADC available) - €2.50
- A light-dependent resistor (LDR)  - €0.10
- A PIR sensor  - €1.00
- DS18B20 temperature sensor - €1.00
- 1kΩ + 4.7kΩ resistor - €0.10

### Wiring

TODO 

### Nodemcu

You will need the [NodeMCU](https://github.com/nodemcu) firmware for this. The current master version does not have the mqtt sending queue implemented yet (it's only in the dev branch), so you can use the firmware in the /bin directory from this repository. Otherwise publishing to multiple topics at the same time will crash NodeMCU. 

Once your ESP8266 is running NodeMCU upload all files from the /lua directory to it. Be sure to change ssid, password and mqtt connection settings in init.lua and mqtt.lua.

### MQTT 

Information will be published to the following topics. The MAC address of the ESP is used as the identifier (actuator/mac address/value). 

| topic | values | description | 
| ------| -------|-------------|
| actuator/18-FE-00-01-02-03/state | ON - OFF | Device online, controlled by mqtt [LWT](http://www-01.ibm.com/support/knowledgecenter/SSFKSJ_7.1.0/com.ibm.mq.doc/tt60360_.htm)
| actuator/18-FE-00-01-02-03/movement | ON - OFF | Movement detected 
| actuator/18-FE-00-01-02-03/light | 0-100% | Light percentage 
| actuator/18-FE-00-01-02-03/temperature  | °C | Temperature

### openHAB
You probably want to use this sensor as part of a larger home automation system. [openHAB](http://www.openhab.org/) is one of these. Check the documentation for the [mqtt binding](https://github.com/openhab/openhab/wiki/MQTT-Binding). The sensor readings can then be used like this:

```
Switch  Movement_Living     "Movement [%s]"          {mqtt="<[home:actuator/18-FE-00-01-02-03/movement:state:default]"}
Number  Light_Living        "Light [%.0f%%]"         {mttq="<[home:actuator/18-FE-00-01-02-03/light:state:default]"}
Number  Temperature_Living  "Temperature [%.1f °C]"  {mqtt="<[home:actuator/18-FE-00-01-02-03/temperature:state:default]"}
Switch  Sensor_Living       "Sensor Living"          {mqtt="<[home:actuator/18-FE-00-01-02-03/state:state:default]"}
```

### Feedback
Open an issue here or contact me [@idserda](http://www.twitter.com/idserda). 