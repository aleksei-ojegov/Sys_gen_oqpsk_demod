function [s, sss, ssss, plas, i_prac, q_prac] = green(i,q)

persistent state1,
state1 = xl_state(0,{xlUnsigned, 1, 0});

persistent i_count,
i_count = xl_state(0,{xlUnsigned, 1, 0});

persistent q_count,
q_count = xl_state(0,{xlUnsigned, 1, 0});

persistent count,
count = xl_state(0,{xlUnsigned, 48, 0});

persistent count2,
count2 = xl_state(0,{xlUnsigned, 48, 0});

persistent count4,
count4 = xl_state(0,{xlSigned, 16, 0});

persistent count5,
count5 = xl_state(0,{xlSigned, 16, 0});

persistent flag,
flag = xl_state(0,{xlUnsigned, 4, 0});

persistent znak_i,
znak_i = xl_state(0,{xlUnsigned, 1, 0});

persistent znak_q,
znak_q = xl_state(0,{xlUnsigned, 1, 0});

persistent inverti,
inverti = xl_state(0,{xlUnsigned, 1, 0});

persistent invertq,
invertq = xl_state(0,{xlUnsigned, 1, 0});

if count < 3840
    count = count + 1;
else
    count = 0;
    if count2 < 1
        count4 = xl_lsh(count4, 1) + i;
        if znak_i == 0
            count5 = xl_lsh(count5, 1) + i;
            i_count = i;
        else
            if i == 0
                inverti = 1;
            else
                inverti = 0;
            end
            count5 = xl_lsh(count5, 1) + inverti;
            i_count = inverti;
        end
        state1 = i_count;
        count2 = count2 + 1;
    else
        count4 = xl_lsh(count4, 1) + q;
        if znak_q == 0
            count5 = xl_lsh(count5, 1) + q;
            q_count = q;
        else
            if q == 0
                invertq = 1;
            else
                invertq = 0;
            end
            count5 = xl_lsh(count5, 1) + invertq;
            q_count = invertq;
        end
        state1 = q_count;
        count2 = 0;
    end
    
    if (count4 == 60304 || count4 == -5232) %норма
        flag = 1;
        znak_i = 0;
        znak_q = 0;
    end
    if (count4 == 16698 || count4 == -48838) %i инверт
        flag = 2;
        znak_i = 1;
        znak_q = 0;
    end
    if (count4 == -16699 || count4 == 48837) %q инверт
        flag = 3;
        znak_i = 0;
        znak_q = 1;
    end
    if (count4 == 5231 || count4 == -60305) %i и q инверт
        flag = 4;
        znak_i = 1;
        znak_q = 1;
    end
    
    if (count4 == 55136 || count4 == -10400) %перепутал i и q, норма
        flag = 5;
        znak_i = 0;
        znak_q = 0;
        count2 = 0;
    end
    if (count4 == 33333 || count4 == -32203) %перепутал i и q, i инверт
        flag = 6;
        znak_i = 1;
        znak_q = 0;
        count2 = 0;
    end
    if (count4 == 32202 || count4 == -33334) %перепутал i и q, q инверт
        flag = 7;
        znak_i = 0;
        znak_q = 1;
        count2 = 0;
    end
    if (count4 == 10399 || count4 == -55132) %перепутал i и q, i и q инверт
        flag = 8;
        znak_i = 1;
        znak_q = 1;
        count2 = 0;
    end
end 

s = xfix({xlUnsigned, 1, 0}, state1);
sss = xfix({xlSigned, 16, 0}, count4);
ssss = xfix({xlSigned, 16, 0}, count5);
plas = xfix({xlUnsigned, 4, 0}, flag);
i_prac = xfix({xlUnsigned, 1, 0}, i_count);
q_prac = xfix({xlUnsigned, 1, 0}, q_count);
