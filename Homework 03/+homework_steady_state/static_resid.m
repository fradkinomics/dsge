function [residual, T_order, T] = static_resid(y, x, params, T_order, T)
if nargin < 5
    T_order = -1;
    T = NaN(2, 1);
end
[T_order, T] = homework_steady_state.static_resid_tt(y, x, params, T_order, T);
residual = NaN(5, 1);
    residual(1) = (y(4)) - (T(1)*T(2));
    residual(2) = (params(1)*y(1)/(1-y(2))) - (y(4)*(1-params(3))/y(2));
    residual(3) = (1/y(1)) - (1/y(1)*params(4)*(y(4)*params(3)/y(3)+1-params(5)));
    residual(4) = (y(3)) - (y(3)*(1-params(5))+y(5));
    residual(5) = (y(4)) - (y(1)+y(5));
end
