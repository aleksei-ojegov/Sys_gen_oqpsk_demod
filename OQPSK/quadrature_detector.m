function [i_out, q_out] = quadrature_detector(i,q,s,c,e)

persistent state1,
state1 = xl_state(0,{xlSigned, 24, 22});

persistent state2,
state2 = xl_state(0,{xlSigned, 24, 22});

if e 
    %state1 = ((i*s)+(q*c))/2;
    %state2 = ((i*c)-(q*s))/2;
    %state1 = ((q*s)+(i*c))/2;
    %state2 = ((q*c)-(i*s))/2;
    state1 = ((i*c)+(q*s))/2;
    state2 = ((q*c)-(i*s))/2;
    i_out = state1;
    q_out = state2;
else
    i_out = 0;
    q_out = 0;
end