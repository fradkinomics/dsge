function [g2_v, T_order, T] = dynamic_g2(y, x, params, steady_state, T_order, T)
if nargin < 6
    T_order = -1;
    T = NaN(6, 1);
end
[T_order, T] = homework_steady_state.dynamic_g2_tt(y, x, params, steady_state, T_order, T);
g2_v = NaN(12, 1);
g2_v(1)=(-(T(1)*getPowerDeriv(y(7),1-params(3),2)));
g2_v(2)=(-(T(5)*T(6)));
g2_v(3)=(-(T(2)*params(2)*getPowerDeriv(y(3),params(3),2)));
g2_v(4)=params(1)/((1-y(7))*(1-y(7)));
g2_v(5)=(-(params(1)*y(6)*((-(1-y(7)))-(1-y(7)))))/((1-y(7))*(1-y(7))*(1-y(7))*(1-y(7)))-(-((-(y(9)*(1-params(3))))*(y(7)+y(7))))/(y(7)*y(7)*y(7)*y(7));
g2_v(6)=(-((-(1-params(3)))/(y(7)*y(7))));
g2_v(7)=(y(6)+y(6))/(y(6)*y(6)*y(6)*y(6));
g2_v(8)=(-(T(4)*params(4)*(y(11)+y(11))/(y(11)*y(11)*y(11)*y(11))));
g2_v(9)=(-(params(4)*(-1)/(y(11)*y(11))*(-(params(3)*y(14)))/(y(8)*y(8))));
g2_v(10)=(-(params(4)*(-1)/(y(11)*y(11))*params(3)/y(8)));
g2_v(11)=(-(T(3)*(-((-(params(3)*y(14)))*(y(8)+y(8))))/(y(8)*y(8)*y(8)*y(8))));
g2_v(12)=(-(T(3)*(-params(3))/(y(8)*y(8))));
end
