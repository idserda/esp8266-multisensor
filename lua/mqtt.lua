-- Config
mqtt_host = "192.168.1.15"
mqtt_port = 1883
mqtt_user = "my-mqtt-user"
mqtt_password = "my-mqtt-password"

-- Setup
connected = 0
sensor_id = wifi.sta.getmac()
base_topic = "actuator/" .. sensor_id

-- Functions
function connect_mqtt()
      m:connect(mqtt_host, mqtt_port, 0, function(conn) 
          connected = 1
          m:publish(base_topic ..  "/state" ,"ON",0,1, function(conn) end)
     end)
end

-- Init mqtt
m = mqtt.Client(sensor_id, 120, mqtt_user, mqtt_password)
m:lwt(base_topic ..  "/state", "OFF", 0, 1)

m:on("offline", function(con) 
     connected = 0
     tmr.alarm(1, 10000, 0, function()
          connect_mqtt()
     end)
end)

connect_mqtt()
