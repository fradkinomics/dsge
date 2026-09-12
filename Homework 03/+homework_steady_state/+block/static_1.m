function [y, T, residual, g1] = static_1(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T)
residual=NaN(5, 1);
  T(1)=params(2)*y(3)^params(3);
  T(2)=y(2)^(1-params(3));
  residual(1)=(y(4))-(T(1)*T(2));
  residual(2)=(params(1)*y(1)/(1-y(2)))-(y(4)*(1-params(3))/y(2));
  residual(3)=(1/y(1))-(1/y(1)*params(4)*(y(4)*params(3)/y(3)+1-params(5)));
  residual(4)=(y(3))-(y(3)*(1-params(5))+y(5));
  residual(5)=(y(4))-(y(1)+y(5));
if nargout > 3
    g1_v = NaN(14, 1);
g1_v(1)=1;
g1_v(2)=(-((1-params(3))/y(2)));
g1_v(3)=(-(1/y(1)*params(4)*params(3)/y(3)));
g1_v(4)=1;
g1_v(5)=(-(T(1)*getPowerDeriv(y(2),1-params(3),1)));
g1_v(6)=params(1)*y(1)/((1-y(2))*(1-y(2)))-(-(y(4)*(1-params(3))))/(y(2)*y(2));
g1_v(7)=(-(T(2)*params(2)*getPowerDeriv(y(3),params(3),1)));
g1_v(8)=(-(1/y(1)*params(4)*(-(y(4)*params(3)))/(y(3)*y(3))));
g1_v(9)=1-(1-params(5));
g1_v(10)=(-1);
g1_v(11)=(-1);
g1_v(12)=params(1)/(1-y(2));
g1_v(13)=(-1)/(y(1)*y(1))-(y(4)*params(3)/y(3)+1-params(5))*params(4)*(-1)/(y(1)*y(1));
g1_v(14)=(-1);
    g1 = sparse(sparse_rowval, sparse_colval, g1_v, 5, 5);
end
end
