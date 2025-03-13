function [z,t] = fft_sum(x,y,i,l)

persistent state1,
state1 = xl_state(0,{xlSigned, 32, 20});

persistent state2,
state2 = xl_state(0,{xlSigned, 32, 20});

persistent state3,
state3 = xl_state(0,{xlSigned, 32, 20});

if x >= 0
    state1 = x;
else
    state1 = -x;
end    

if y >= 0
    state2 = y;
else
    state2 = -y;
end  

if i
    state3 = xfix({xlUnsigned, 32, 20}, state1 + state2);
end

z = xfix({xlUnsigned, 32, 20}, state3);
t = l;
