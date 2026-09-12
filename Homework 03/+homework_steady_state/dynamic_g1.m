function [g1, T_order, T] = dynamic_g1(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T_order, T)
if nargin < 9
    T_order = -1;
    T = NaN(6, 1);
end
[T_order, T] = homework_steady_state.dynamic_g1_tt(y, x, params, steady_state, T_order, T);
g1_v = NaN(16, 1);
g1_v(1)=(-(T(2)*T(6)));
g1_v(2)=(-(1-params(5)));
g1_v(3)=params(1)/(1-y(7));
g1_v(4)=(-1)/(y(6)*y(6));
g1_v(5)=(-1);
g1_v(6)=(-(T(1)*T(5)));
g1_v(7)=params(1)*y(6)/((1-y(7))*(1-y(7)))-(-(y(9)*(1-params(3))))/(y(7)*y(7));
g1_v(8)=(-(T(3)*(-(params(3)*y(14)))/(y(8)*y(8))));
g1_v(9)=1;
g1_v(10)=1;
g1_v(11)=(-((1-params(3))/y(7)));
g1_v(12)=1;
g1_v(13)=(-1);
g1_v(14)=(-1);
g1_v(15)=(-(T(4)*params(4)*(-1)/(y(11)*y(11))));
g1_v(16)=(-(T(3)*params(3)/y(8)));
g1 = sparse(sparse_rowval, sparse_colval, g1_v, 5, 15);
end
