function [i_out, q_out] = oqpsk_mult(i,q,i_o,q_o,regim)

persistent i_buf,
i_buf = xl_state(0,{xlUnsigned, 1, 0});

persistent q_buf,
q_buf = xl_state(0,{xlUnsigned, 1, 0});

persistent regim_buf,
regim_buf = xl_state(0,{xlUnsigned, 1, 0});

regim_buf = 0 + regim;

switch(regim_buf)
    case 0
        i_buf = i_o;
        q_buf = q;
    case 1
        i_buf = i;
        q_buf = q_o;
    otherwise
end

i_out = i_buf;
q_out = q_buf;


