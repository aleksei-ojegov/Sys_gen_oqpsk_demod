function z = dds(looper, furie, flag, fur_mod)

persistent odin,
%odin = xl_state(0.00325520833333,{xlSigned, 32, 32}); % 100 ���
%odin = xl_state(0.01666666666666,{xlSigned, 32, 32}); % 512 ���
odin = xl_state(0.03255208333333,{xlSigned, 32, 32}); % 1000 ���

persistent fur_const,
fur_const = xl_state(0,{xlSigned, 32, 32});

persistent fur_const_2,
fur_const_2 = xl_state(0,{xlSigned, 32, 32});

persistent fur_const_flag,
fur_const_flag = xl_state(0,{xlSigned, 32, 32});

persistent count2,
count2 = xl_state(0,{xlUnsigned, 24, 0});

persistent fur_mod_buf,
fur_mod_buf = xl_state(0,{xlUnsigned, 10, 0});

persistent state1,
state1 = xl_state(0,{xlSigned, 32, 32});

%if furie ~= 0
%    fur_const = furie;
%end 

if fur_mod ~= 0
    fur_mod_buf = fur_mod;
end

if fur_mod_buf == 1
    fur_const = 0;
    fur_const_flag = 0;
elseif fur_mod_buf == 2
    if furie ~= 0
        fur_const = furie;
    end
end
    
%if count2 < 30720000
%    count2 = count2 + 1;
%else
%    count2 = 0;
%    fur_const_2 = fur_const;
%end

%state1 = odin + fur_const - looper;

if flag == 1 
    state1 = odin + fur_const_flag - looper;
else
    fur_const_flag = fur_const;
    state1 = odin + fur_const_flag - looper;
end

z = xfix({xlUnsigned, 32, 32}, state1);