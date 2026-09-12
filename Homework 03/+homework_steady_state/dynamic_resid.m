function [residual, T_order, T] = dynamic_resid(y, x, params, steady_state, T_order, T)
if nargin < 6
    T_order = -1;
    T = NaN(4, 1);
end
[T_order, T] = homework_steady_state.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
residual = NaN(5, 1);
    residual(1) = (y(9)) - (T(1)*T(2));
    residual(2) = (params(1)*y(6)/(1-y(7))) - (y(9)*(1-params(3))/y(7));
    residual(3) = (1/y(6)) - (T(3)*T(4));
    residual(4) = (y(8)) - (y(3)*(1-params(5))+y(10));
    residual(5) = (y(9)) - (y(6)+y(10));
end
