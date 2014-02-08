function [gear] = gearchange(currentgear,N,maxgear)
    %just a simpel gear changer, maybe put torqemaps here to know the most
    %effective way to change gear.
    if 5000*pi/30 > N %rad/s
        gear=currentgear+1;
    elseif 1500*pi/30 < N %rad/s
        gear=currentgear+1;
    else
        gear=currentgear;
    end
    if gear > maxgear
        gear = maxgear;
    elseif gear < 1
        gear = 0;
    end
end