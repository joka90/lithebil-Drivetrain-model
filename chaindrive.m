
function [F] = chaindrive(x,x_dot,b,k,S)
    if x > S/2
        F=-(x-S/2)*k-x_dot*b;
    elseif x < -S/2
        F=-(x+S/2)*k-x_dot*b;
    else
        F=-x_dot*b;
    end
end