function [un,xn]=pidfunc(umann,amn,rn,yn,ctrlparam,ubounds,Ts,xn_1)
K=ctrlparam(1);
Ti=ctrlparam(2);
Td=ctrlparam(3);
mu=ctrlparam(4);
theta=ctrlparam(5:end);

In_1=xn_1(1);
en_1=xn_1(2);
vm_1=xn_1(3);
Kp_1=xn_1(4);%för omparametrisering

umin=ubounds(1);
umax=ubounds(2);
en=rn-yn;
%modbyte
if amn == 1 % om auto
    Integration=In_1+K*Ts*en/Ti;
    Integration=(Kp_1/K)*Integration;%omräkning av i-delen p104
    va=K*en+Integration+K*Td*(en-en_1)/Ts;
    vn=va;
    vm=vm_1;
else % om man
    Integration=In_1;
    va=(Kp_1/K)*Integration;%omräkning av i-delen p104
    vm=vm_1+Ts*umann;
    vn=vm;
end

%saturation
if vn<umin
    un=umin;
elseif vn>umax
    un=umax;
else
    un=vn;

end
%tracking mode p101
Tta=Ti;
Ttm=Ti;

In=Integration+(Ts/Tta)*(un-va);
vm=vm+(Ts/Ttm)*(un-vm);
xn=[In;en;vm;K];
