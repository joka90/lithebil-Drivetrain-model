%% masses radiuses and inertias
m_chain=0.833
len_chain=1.5%slack length
m_front_sproket=0.161
m_back_sproket=0.781
m_drive_shaft=0.684
m_diff=2.5%TODO guess

r_front_sproket=0.037
r_back_sproket=0.143
r_drive_shaft=0.0018
r_diff=4/1000%TODO guess 

inertia_front_sproket=0.5*m_front_sproket*r_front_sproket^2
inertia_back_sproket=0.5*m_back_sproket*r_back_sproket^2
inertia_drive_shaft=0.5*m_drive_shaft*r_drive_shaft^2
inertia_diff=0.5*m_diff*r_diff^2

gearratio_ratio_chain=r_front_sproket/r_back_sproket

%% chain data

chain_stiffness=0%todo
chain_damping=0%todo

i_f=r_back_sproket/r_front_sproket
