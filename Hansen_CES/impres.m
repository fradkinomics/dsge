function z=impres(P,Q,R,S,N,vecvar,shock,runlgth)
%this function generates impulse response functions from the output of
%llinsolve and the N matrix from the model
%"vecvar" is the vector of variables whose responses are to be shown.  The
%are ordered as the state variables first and then the jump variables.
%"shock" is the number of the shock to be applied as the impulse
%"runlgth" is the number of periods of the response to be shown
%an example that shows the responses of variables 1 and 5 to 9 to an 
%impulse in the second shock for 25 periods is
%
%  z=impres(P,Q,R,S,N,[1 5:9],2,25);
%
[aq,numshocks]=size(Q);
[numjump,numstate]=size(R);
e=zeros(numshocks,runlgth);
%an error will appear here if shock is not <= numshocks
e(shock,2)=1;
xold=zeros(numstate,1);
shockold=zeros(numshocks,1);
for i=1:runlgth
    shocknew=N*shockold+e(:,i);
    x(:,i)=P*xold+Q*shocknew;
    y(:,i)=R*xold+S*shocknew;
    xold=x(:,i);
    shockold=shocknew;
end
z= [x
    y];
z=z(vecvar,:);
plot(z')
