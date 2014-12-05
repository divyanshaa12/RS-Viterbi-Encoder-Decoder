clear; clc; close all;

m=[1 0 1 1 1 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 0 0];

%%
%Encoding

%Encoder:
%	   ------------------------------------------------------- c1
%	   |
%	   |        --------+----------+----------+----------+---- c2
%	   |        |       |          |          |          |
%	   | m_tmp  |       |          |          |          |
%	m-----+-------| D |----| D^2 |----| D^3 |----| D^4 |--
%	      |______________________________________________|    

for i=1:length(m)
    c1(i) = m(i); % Since the first one is just the message bit.
    
    if i==1
        in_mem = [0 0 0 0]; %initializing conv encoder's SR's to zero.
    end
    
    m_tmp = mod(in_mem(4) + m(i),2);
    c2(i) = mod(mod(mod(m_tmp + in_mem(1),2) + mod(in_mem(2) + in_mem(3),2),2) + in_mem(4),2);
    
    in_mem = [m_tmp in_mem(1:3)]; % update your encoder's memory
end