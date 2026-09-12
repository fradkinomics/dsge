function [y, T, residual, g1] = dynamic_1(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
residual=NaN(5, 1);
  T(1)=params(2)*y(3)^params(3);
  T(2)=y(7)^(1-params(3));
  residual(1)=(y(9))-(T(1)*T(2));
  residual(2)=(y(8))-(y(3)*(1-params(5))+y(10));
  residual(3)=(1/y(6))-(params(4)*1/y(11)*(params(3)*y(14)/y(8)+1-params(5)));
  residual(4)=(params(1)*y(6)/(1-y(7)))-(y(9)*(1-params(3))/y(7));
  residual(5)=(y(9))-(y(6)+y(10));
if nargout > 3
    g1_v = NaN(16, 1);
g1_v(1)=(-(T(2)*params(2)*getPowerDeriv(y(3),params(3),1)));
g1_v(2)=(-(1-params(5)));
g1_v(3)=(-(T(1)*getPowerDeriv(y(7),1-params(3),1)));
g1_v(4)=params(1)*y(6)/((1-y(7))*(1-y(7)))-(-(y(9)*(1-params(3))))/(y(7)*y(7));
g1_v(5)=(-1);
g1_v(6)=(-1);
g1_v(7)=1;
g1_v(8)=(-(params(4)*1/y(11)*(-(params(3)*y(14)))/(y(8)*y(8))));
g1_v(9)=1;
g1_v(10)=(-((1-params(3))/y(7)));
g1_v(11)=1;
g1_v(12)=(-1)/(y(6)*y(6));
g1_v(13)=params(1)/(1-y(7));
g1_v(14)=(-1);
g1_v(15)=(-(params(4)*1/y(11)*params(3)/y(8)));
g1_v(16)=(-((params(3)*y(14)/y(8)+1-params(5))*params(4)*(-1)/(y(11)*y(11))));
    g1 = sparse(sparse_rowval, sparse_colval, g1_v, 5, 15);
end
end
