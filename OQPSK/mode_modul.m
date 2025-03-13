function [i_o, q_o] = mode_modul(i_d,i,q,e)

persistent state1,
state1 = xl_state(0,{xlSigned, 24, 22});

persistent state2,
state2 = xl_state(0,{xlSigned, 24, 22});

if e == 1
    i_o = i;
    q_o = q;
else
    i_o = i_d;
    q_o = q;
end

