-- This is a somewhat modified routine from http://www.esp8266.com/viewtopic.php?f=19&t=752

-- Setup 
pin_temp = 6  -- GPIO12

counter=0
lasttemp=-999
tempstring=""

-- Init 
ow.setup(pin_temp)

function bxor(a,b)
   local r = 0
   for i = 0, 31 do
      if ( a % 2 + b % 2 == 1 ) then
         r = r + 2^i
      end
      a = a / 2
      b = b / 2
   end
   return r
end

function read_temp()
  tmr.wdclr()     
  ow.reset(pin_temp)
  ow.skip(pin_temp)
  ow.write(pin_temp,0x44,1)
  tmr.delay(800000)
  ow.reset(pin_temp)
  ow.skip(pin_temp)
  ow.write(pin_temp,0xBE,1)

  data = nil
  data = string.char(ow.read(pin_temp))
  data = data .. string.char(ow.read(pin_temp))
  t = (data:byte(1) + data:byte(2) * 256)
   if (t > 32768) then
              t = (bxor(t, 0xffff)) + 1
              t = (-1) * t
             end
   t = t * 625
             lasttemp = t
  t1 = lasttemp / 10000
  tempstring = t1
end

function send_temp() 
     read_temp()
     if connected == 1 then
          m:publish(base_topic ..  "/temperature",tempstring,0,0,function(conn) end)
     end
end

-- Start timer, send every minute
tmr.alarm(6, 60000, 1, function()
     send_temp()
end)
