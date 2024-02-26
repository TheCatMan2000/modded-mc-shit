-- compressorMon.lua by TheCatMan2000
-- configurable program to control PneumaticCraft Flux Compressors
-- licensed under wtfpl

--------------------------------------------------------------
-- MAKE SURE YOUR COMPRESSOR IS SET TO RUN ON A HIGH SIGNAL --
--------------------------------------------------------------

-- configuration --
-------------------
-- what face is the compressor on in relation to the computer?
compressorFace = "bottom"
 
-- how hot is the compressor allowed to get?
maxTempC = 200 -- default is 200
-- 50c = 100% eff
-- 125c = 75% eff
-- 200c = 50% eff
 
-- how much pressure is subtracted from the danger value
-- helps account for server lag, also keeps shit from 'sploding
barHeadroom = 0.8 -- default is 0.8
 
-- dangerous settings --
-- here be dragons
activeRecheck = 0.5
shortDelay = 5
longDelay = 15

-- the actual code
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
