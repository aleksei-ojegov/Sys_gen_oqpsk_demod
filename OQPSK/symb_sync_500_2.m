function [data_sync, data_sync_clk] = symb_sync_500_2(bit_in)

persistent s_bit0,
s_bit0 = xl_state(0,{xlUnsigned, 1, 0});

persistent s_bit0_old,
s_bit0_old = xl_state(0,{xlUnsigned, 1, 0});

persistent s_nco_acc,
s_nco_acc = xl_state(0,{xlUnsigned, 32, 0});

persistent s_nco_acc31_old,
s_nco_acc31_old = xl_state(0,{xlUnsigned, 1, 0});

persistent s_nco_acc31_old2,
s_nco_acc31_old2 = xl_state(0,{xlUnsigned, 1, 0});

persistent s_bit0_sync,
s_bit0_sync = xl_state(0,{xlUnsigned, 1, 0});

persistent s_pinc,
s_pinc = xl_state(0,{xlSigned, 32, 0});

persistent s_error,
s_error = xl_state(0,{xlSigned, 2, 0});

persistent s_loop,
s_loop = xl_state(0,{xlSigned, 16, 0});

persistent s_cnt1,
s_cnt1 = xl_state(0,{xlSigned, 16, 0});

persistent v_error,
v_error = xl_state(0,{xlSigned, 16, 0});

persistent s_sum,
s_sum = xl_state(0,{xlSigned, 16, 0});

persistent v_sum,
v_sum = xl_state(0,{xlSigned, 16, 0});

s_bit0 = bit_in;

s_nco_acc = s_nco_acc + s_pinc;

if s_loop < 1400 && s_loop > -1400
    s_pinc = 64*1118481-s_loop; %1*1118481 = 8ê; 16 = 128ê; 64 = 512ê
end

if s_bit0 ~= s_bit0_old
    s_bit0_old = s_bit0;
    v_error = s_cnt1-30; %30 = 512ê; 120 = 128ê; 1920 = 8ê
    
    if v_error > 0
        s_error = 1;
    else
        s_error = -1;
    end
end

s_nco_acc31_old2 = s_nco_acc31_old;
s_nco_acc31_old = xl_slice(s_nco_acc,32,32);
if s_nco_acc31_old2 == 1 && s_nco_acc31_old == 0
    s_bit0_sync = s_bit0;
    s_cnt1 = 0;
else
    s_cnt1 = s_cnt1 + 1; 
end

v_sum = s_error + s_sum;
if v_sum >- 1024*256 && v_sum < 1024*256
    s_sum = v_sum;
end 
s_loop = s_error + s_sum/1024;

data_sync = s_bit0_sync;
%data_sync_clk = xfix({xlUnsigned, 1, 0}, xl_slice(s_nco_acc,32,31));
data_sync_clk = s_nco_acc31_old;

