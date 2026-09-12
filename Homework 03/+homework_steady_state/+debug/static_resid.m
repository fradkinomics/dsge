function [lhs, rhs] = static_resid(y, x, params)
T = NaN(2, 1);
lhs = NaN(5, 1);
rhs = NaN(5, 1);
T(1) = params(2)*y(3)^params(3);
T(2) = y(2)^(1-params(3));
lhs(1) = y(4);
rhs(1) = T(1)*T(2);
lhs(2) = params(1)*y(1)/(1-y(2));
rhs(2) = y(4)*(1-params(3))/y(2);
lhs(3) = 1/y(1);
rhs(3) = 1/y(1)*params(4)*(y(4)*params(3)/y(3)+1-params(5));
lhs(4) = y(3);
rhs(4) = y(3)*(1-params(5))+y(5);
lhs(5) = y(4);
rhs(5) = y(1)+y(5);
end
