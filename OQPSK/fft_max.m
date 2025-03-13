function [N, pinc, Bufe, N_bufe] = fft_max(x,y)
 
persistent max,
max = xl_state(0,{xlUnsigned, 32, 20});

persistent max1,
max1 = xl_state(0,{xlUnsigned, 32, 20});

persistent count,
count = xl_state(0,{xlSigned, 32, 0});

persistent tru,
tru = xl_state(0,{xlSigned, 2, 0});

persistent count_out,
count_out = xl_state(0,{xlSigned, 32, 0});

persistent count_out2,
count_out2 = xl_state(0,{xlSigned, 32, 0});

persistent buffer,
buffer = xl_state(0,{xlSigned, 32, 0});

persistent buffer_z,
buffer_z = xl_state(0,{xlSigned, 12, 0});

persistent counter_buf,
counter_buf = xl_state(0,{xlSigned, 10, 0});

persistent count_pinc,
count_pinc = xl_state(0,{xlSigned, 32, 32});

if y
    if max1 > max
        count_out = 1023;
    end
    if count_out < 512
        count_out2 = count_out;
    else
        count_out2 = count_out - 1024;
    end
    if tru == 0
        tru = 1;
    else
        %buffer = buffer + count_out2;
        %counter_buf = counter_buf + 1;
        %if counter_buf == 16
            count_pinc = ((count_out2-4)/1024)/4;
            %count_pinc = (((buffer)/16)/1024)/4;
            %buffer_z = buffer/16;
            counter_buf = 0;
            buffer = 0;
        %end
    end
    count = 0;
    count_out = 0;
    max = 0;
    max1 = x;
else
    if max < x
        max = x;
        count_out = count;
    end
    count = count + 1;
end
     
N = xfix({xlSigned, 10, 0},count_out2);
pinc = xfix({xlSigned, 32, 32}, count_pinc);
Bufe = xfix({xlSigned, 32, 0},buffer);
N_bufe = xfix({xlSigned, 10, 0},counter_buf);
%Bufe_z = xfix({xlSigned, 12, 0},buffer_z);