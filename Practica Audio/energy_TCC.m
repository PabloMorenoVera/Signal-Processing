function [E,TCC] = energy_TCC(s)

E = sum(s.^2);
TCC= sum((0.5/length(s))*(abs(sign(s(2:end))-sign(s(1:end-1)))));


