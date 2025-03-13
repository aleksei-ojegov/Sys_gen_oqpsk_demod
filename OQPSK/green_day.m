function [i_out, q_out, plas, symma, flager, out_all, coun, regim] = green_day(i,q,clok)

persistent state1,
state1 = xl_state(0,{xlUnsigned, 1, 0});

persistent state2,
state2 = xl_state(0,{xlUnsigned, 1, 0});

persistent count,
count = xl_state(0,{xlUnsigned, 16, 0});

persistent count2,
count2 = xl_state(0,{xlUnsigned, 24, 0});

persistent count_polo,
count_polo = xl_state(0,{xlUnsigned, 8, 0});

persistent count4,
count4 = xl_state(0,{xlUnsigned, 16, 0});

persistent flag,
flag = xl_state(0,{xlUnsigned, 4, 0});

persistent inver,
inver = xl_state(0,{xlUnsigned, 2, 0});

persistent inverti,
inverti = xl_state(0,{xlUnsigned, 1, 0});

persistent invertq,
invertq = xl_state(0,{xlUnsigned, 1, 0});

persistent znak_i,
znak_i = xl_state(0,{xlUnsigned, 1, 0});

persistent znak_q,
znak_q = xl_state(0,{xlUnsigned, 1, 0});

persistent buf_i,
buf_i = xl_state(0,{xlUnsigned, 1, 0});

persistent buf_q,
buf_q = xl_state(0,{xlUnsigned, 1, 0});

persistent clock_sinc,
clock_sinc = xl_state(0,{xlUnsigned, 1, 0});

persistent clock_sinc_old,
clock_sinc_old = xl_state(0,{xlUnsigned, 1, 0});

persistent i_out_buf,
i_out_buf = xl_state(0,{xlUnsigned, 1, 0});

persistent q_out_buf,
q_out_buf = xl_state(0,{xlUnsigned, 1, 0});

persistent state_out,
state_out = xl_state(0,{xlUnsigned, 1, 0});

persistent zahvat,
zahvat = xl_state(0,{xlUnsigned, 1, 0});

persistent regim_buf,
regim_buf = xl_state(0,{xlUnsigned, 1, 0});

clock_sinc_old = clock_sinc;
clock_sinc = clok;

if clock_sinc == 0 && clock_sinc_old == 1
    buf_i = i;
    buf_q = q;
    count4 = xl_lsh(count4, 1) + buf_i;
    count4 = xl_lsh(count4, 1) + buf_q;
    
    if znak_i == 0
        state1 = buf_i;
    else
        if buf_i == 0
            inverti = 1;
        else
            inverti = 0;
        end
        state1 = inverti;
    end

    if znak_q == 0
        state2 = buf_q;
    else
        if buf_q == 0 
            invertq = 1;
        else
            invertq = 0;
        end
        state2 = invertq;
    end
    if count == 456 %456 дл€ кадра из 114 байт 
        zahvat = 0;
        count = 0;
    else
        count = count + 1;
    end
end

%if clock_sinc == 1 && clock_sinc_old == 0
%    switch(inver)
%        case 1 
%            i_out_buf = state1;
%            q_out_buf = state2;
%        case 2 
%            i_out_buf = state2;
%            q_out_buf = state1;
%        otherwise
%    end
%    state_out = i_out_buf;
%elseif clock_sinc == 0 && clock_sinc_old == 1
%    state_out = q_out_buf;
%end

count_polo = count_polo + 1;
count2 = count2 + 1;

if clock_sinc == 0 && clock_sinc_old == 1
    switch(inver)
        case 1 
            i_out_buf = state1;
            q_out_buf = state2;
        case 2 
            i_out_buf = state2;
            q_out_buf = state1;
        otherwise
    end
    state_out = i_out_buf;
    count_polo = 0; 
end

if count_polo == 59 %59 дл€ 512 к√ц; 239 дл€ 128 к√ц 
    state_out = q_out_buf;
end

switch(count4)
    case 60304 %60304
        flag = 1;
        inver = 1;
        znak_i = 0;
        znak_q = 0;
        zahvat = 1;
        count = 0;
        count2 = 0;
    case 16698 %16698
        flag = 2;
        inver = 1;
        znak_i = 1;
        znak_q = 0;
        zahvat = 1;
        count = 0;
        count2 = 0;
    case 48837 %48837
        flag = 3;
        inver = 1;
        znak_i = 0;
        znak_q = 1;
        zahvat = 1;
        count = 0;
        count2 = 0;
    case 5231 %5231
        flag = 4;
        inver = 1;
        znak_i = 1;
        znak_q = 1;
        zahvat = 1;
        count = 0;
        count2 = 0;
    case 55136 %55136
        flag = 5;
        inver = 2;
        znak_i = 0;
        znak_q = 0;
        zahvat = 1;
        count = 0;
        count2 = 0;
    case 33333 %33333
        flag = 6;
        inver = 2;
        znak_i = 0;
        znak_q = 1;
        zahvat = 1;
        count = 0;
        count2 = 0;
    case 32202 %32202
        flag = 7;
        inver = 2;
        znak_i = 1;
        znak_q = 0;
        zahvat = 1;
        count = 0;
        count2 = 0;
    case 10399 %10399
        flag = 8;
        inver = 2;
        znak_i = 1;
        znak_q = 1;
        zahvat = 1;
        count = 0;
        count2 = 0;
    otherwise
end

if count2 == 54720*3 && zahvat == 0 % 54720 - длина одного 114 байтного кадра; 3840 - дл€ EB90
    regim_buf = regim_buf + 1;
    count2 = 0;
end

i_out = xfix({xlUnsigned, 1, 0}, state1);
q_out = xfix({xlUnsigned, 1, 0}, state2);
symma = xfix({xlUnsigned, 16, 0}, count4);

plas = xfix({xlUnsigned, 4, 0}, flag);
flager = xfix({xlUnsigned, 1, 0}, zahvat);
out_all = xfix({xlUnsigned, 1, 0}, state_out);
%out_all = xfix({xlBoolean}, zahvat);
%coun = xfix({xlUnsigned, 48, 0}, count);
coun = xfix({xlBoolean}, zahvat);
regim = regim_buf;
