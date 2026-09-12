function [T_order, T] = dynamic_g1_tt(y, x, params, steady_state, T_order, T)
if T_order >= 1
    return
end
[T_order, T] = homework_steady_state.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
T_order = 1;
if size(T, 1) < 6
    T = [T; NaN(6 - size(T, 1), 1)];
end
T(5) = getPowerDeriv(y(7),1-params(3),1);
T(6) = params(2)*getPowerDeriv(y(3),params(3),1);
end
