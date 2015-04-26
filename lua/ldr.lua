-- Functions  
function read_ldr()
     value = adc.read(0)
     percentage = math.floor(((100/1024)*value)+0.5)

     if connected == 1 then
          m:publish(base_topic ..  "/light",percentage,0,0,function(conn) end)
     end
end

-- Start timer, send every 10 seconds
tmr.alarm(5, 10000, 1, function()
     read_ldr()
end)
