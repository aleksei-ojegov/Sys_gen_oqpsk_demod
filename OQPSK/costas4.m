function [im_out,qm_out] = costas4(im,qm)

persistent ims,
ims = xl_state(0,{xlSigned, 2, 0});

persistent qms,
qms = xl_state(0,{xlSigned, 2, 0});

persistent error,
error = xl_state(0,{xlSigned, 46, 22});

persistent kp,
kp = xl_state(0,{xlSigned, 46, 42});

persistent ki,
ki = xl_state(0.00000000010448,{xlSigned, 46, 42});

persistent k,
k = xl_state(0,{xlSigned, 46, 22});

persistent k_old,
k_old = xl_state(0,{xlSigned, 46, 22});

persistent offset_buf,
offset_buf = xl_state(0,{xlSigned, 24, 22});

 
    if im >0
        ims = 1;
    else
        ims = -1;
    end
    
    if qm >0
        qms = 1;
    else
        qms = -1;
    end
    
    error = im*qms - qm*ims;
    k = k_old - ki*error;
    k_old = k;
    offset_buf = k + kp;

    im_out = ims;
    qm_out = qms;
