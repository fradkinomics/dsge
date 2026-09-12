function [T_order, T] = dynamic_resid_tt(y, x, params, steady_state, T_order, T)
if T_order >= 0
    return
end
T_order = 0;
if size(T, 1) < 4
    T = [T; NaN(4 - size(T, 1), 1)];
end
T(1) = params(2)*y(3)^params(3);
T(2) = y(7)^(1-params(3));
T(3) = params(4)*1/y(11);
T(4) = params(3)*y(14)/y(8)+1-params(5);
end
