function [rs_out] = my_RS_Dec(m_rs,rx_m_rs)

%calculating # of symbol errors for each code
num_symb_err=[0 0 0 0]; %initialize
for i=1:63
    for j=1:4
        num_symb_err(j) = num_symb_err(j) + (1 - isequal(m_rs(i,6*(j-1)+1:6*j) , rx_m_rs(i,6*(j-1)+1:6*j)));
    end
end

%RS decoding; if number of symbol erros is <= to 5 then replace the
%recieved symbol with the transmitted one.
rs_out=rx_m_rs;
for i=1:4
    if num_symb_err(i) <= 5
        for j=1:63
            rs_out(j,6*(i-1)+1:6*i)=m_rs(j,6*(i-1)+1:6*i);
        end
    end
end