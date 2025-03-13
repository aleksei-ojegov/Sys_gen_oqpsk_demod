function [N, pinc, Bufe, Bufe_sr] = fft_max_orig(x,y)
 
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

persistent count_pinc,
count_pinc = xl_state(0,{xlSigned, 32, 32});

persistent buffer,
buffer = xl_state(0,{xlSigned, 32, 0});

persistent buffer_sum,
buffer_sum = xl_state(0,{xlSigned, 32, 0});

persistent counter_buf,
counter_buf = xl_state(0,{xlSigned, 10, 0});

if y
    if max1 > max
        count_out = 2047; %1023
    end
    tru = tru + 1;
    if count_out < 1024 %512
        count_out2 = count_out;
    else
        count_out2 = count_out - 2048; %1024
    end
    if tru == 2
        buffer = buffer + count_out2;
        counter_buf = counter_buf + 1;
        %count_pinc = ((count_out2)/1024)/4;
        %r(counter_buf) = count_out2;
        if counter_buf == 256
            count_pinc = (((buffer)/256)/2048)/4;
            buffer_sum = (buffer)/256;
            counter_buf = 0;
            buffer = 0;
        end
        tru = 1;
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
Bufe_sr = xfix({xlSigned, 12, 0},buffer_sum);
