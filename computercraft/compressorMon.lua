-- configuration --
-------------------
--what face is the compressor on compared to the
--computer?
compressorFace = "bottom"
 
--how hot should i allow the compressor to get
--before shutting it off?
maxTempC = 230 -- default is 200
-- 50c = 100% eff
-- 125c = 75% eff
-- 200c = 50% eff
 
--how much pressure is subtracted from the danger value
barHeadroom = 0.8 -- default is 0.8
 
-- dangerous settings --
--careful changing these settings...
activeRecheck = 0.5
shortDelay = 5
longDelay = 45
 
 
-- compressor should be set to run on high signal
-- compressor should be set to run on high signal
-- compressor should be set to run on high signal
 
-- don't fuck with anything beyond this point unless you know what you're doing
maxTempK = maxTempC + 273.15 -- temps are read in kelvin
pneu = peripheral.wrap(compressorFace)
while true do
    print(pneu.getPressure().." bar")
    print(pneu.getTemperature().." K")
        if pneu.getTemperature() >= maxTempK then
            redstone.setOutput(compressorFace,false)
            print("Compressor exceeds "..maxTempK.."K ("..maxTempC.."C). Waiting "..longDelay.." sec.")
            sleep(longDelay)
        else if pneu.getPressure() >= (pneu.getDangerPressure() - barHeadroom) then
            redstone.setOutput(compressorFace,false)
            sleep(shortDelay)
        else
            redstone.setOutput(compressorFace,true)
            sleep(activeRecheck)
        end
    end
end
