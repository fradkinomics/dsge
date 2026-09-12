function [g1, T_order, T] = static_g1(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T_order, T)
if nargin < 8
    T_order = -1;
    T = NaN(2, 1);
end
[T_order, T] = homework_steady_state.static_g1_tt(y, x, params, T_order, T);
g1_v = NaN(14, 1);
g1_v(1)=params(1)/(1-y(2));
g1_v(2)=(-1)/(y(1)*y(1))-(y(4)*params(3)/y(3)+1-params(5))*params(4)*(-1)/(y(1)*y(1));
g1_v(3)=(-1);
g1_v(4)=(-(T(1)*getPowerDeriv(y(2),1-params(3),1)));
g1_v(5)=params(1)*y(1)/((1-y(2))*(1-y(2)))-(-(y(4)*(1-params(3))))/(y(2)*y(2));
g1_v(6)=(-(T(2)*params(2)*getPowerDeriv(y(3),params(3),1)));
g1_v(7)=(-(1/y(1)*params(4)*(-(y(4)*params(3)))/(y(3)*y(3))));
g1_v(8)=1-(1-params(5));
g1_v(9)=1;
g1_v(10)=(-((1-params(3))/y(2)));
g1_v(11)=(-(1/y(1)*params(4)*params(3)/y(3)));
g1_v(12)=1;
g1_v(13)=(-1);
g1_v(14)=(-1);
g1 = sparse(sparse_rowval, sparse_colval, g1_v, 5, 5);
end
