% ==============================================================
%  Hansen economy with CES utility and seigniorage
%  Final Exam - Dynamic Stochastic Models (Prof. McCandless)
%  CES curvature eta = 1.5 (inelastic: elasticity 1/eta = 0.667)
%  Solves the log-linear model (Uhlig's method) and gives P,Q,R,S
% ==============================================================
clear
clc
close all

% ---------- 1. Calibration (book Sec. 8.9, with eta = 1.5) ----------
theta  = 0.36;      % capital share
beta   = 0.99;      % discount factor (quarterly)
delta  = 0.025;     % depreciation rate
gamma  = 0.95;      % persistence of the technology shock
pie    = 0.48;      % persistence of the deficit (money) shock
varphi = 1.3180;    % steady-state gross money growth rate (phi bar)
eta    = 1.5;       % CES curvature; elasticity 1/eta = 0.667 (inelastic)
BB     = -2.5805;   % indivisible-labor coefficient (named BB, not B, to avoid
                    % clashing with the canonical matrix B below)

% ---------- 2. Stationary state ----------
rbar   = 1/beta - 1 + delta;                          % capital FOC
KoverH = (theta/rbar)^(1/(1-theta));                  % capital-labor ratio
wbar   = (1-theta)*(theta/rbar)^(theta/(1-theta));    % wage
pbar   = (-BB/(wbar*beta))^(1/eta)*varphi^(1/eta-1);  % normalized price (money FOC)
Cbar   = 1/(pbar*varphi);                             % consumption (CIA)
gbar   = (1 - 1/varphi)/pbar;                         % government spending
Hbar   = (1/pbar)/(wbar + (rbar-delta)*KoverH);       % hours (resource constraint)
Kbar   = KoverH*Hbar;                                 % capital
Ybar   = Kbar^theta * Hbar^(1-theta);                 % output
mbar   = 1;                                           % normalized money

fprintf('\n===== Stationary state (eta = %.2f) =====\n', eta);
fprintf('rbar   = %10.6f\n', rbar);
fprintf('KoverH = %10.6f\n', KoverH);
fprintf('wbar   = %10.6f\n', wbar);
fprintf('pbar   = %10.6f\n', pbar);
fprintf('Cbar   = %10.6f\n', Cbar);
fprintf('gbar   = %10.6f\n', gbar);
fprintf('Hbar   = %10.6f\n', Hbar);
fprintf('Kbar   = %10.6f\n', Kbar);
fprintf('Ybar   = %10.6f\n', Ybar);

% ---------- 3. Canonical-form matrices ----------
% States  x = [K(t+1); phi(t)]
% Jumps   y = [r; w; p; H]
% Shocks  z = [lambda; g]
A = [ 0            -1/varphi
      Kbar          0
      0             0
      0             0 ];

B = [ 0                       0
     -(rbar+1-delta)*Kbar     0
      1-theta                 0
     -theta                   0 ];

C = [ 0           0           pbar*gbar    0
     -rbar*Kbar  -wbar*Hbar  -1/pbar      -wbar*Hbar
      1           0           0           -(1-theta)
      0           1           0            theta ];

D = [ 0    pbar*gbar
      0    0
     -1    0
     -1    0 ];

F = [ 0    0
      0    eta-1 ];

G = zeros(2,2);
H = zeros(2,2);

J = [ beta*rbar  -1    0       0
      0           0    eta-1   0 ];

K = [ 0  1  0  0
      0  1  1  0 ];

L = zeros(2,2);
M = zeros(2,2);

N = [ gamma  0
      0      pie ];

% ---------- 4. Solve (Uhlig's method, course routine) ----------
% unitr = 0 : keep only strictly stable roots (|eigenvalue| < 1)
[P,Q,R,S] = llinsolve(A,B,C,D,F,G,H,J,K,L,M,N,0);

fprintf('\n===== Solution matrices =====\n');
fprintf('P ='); disp(P)
fprintf('Q ='); disp(Q)
fprintf('R ='); disp(R)
fprintf('S ='); disp(S)





% ---------- 5. Impulse responses to the money-growth shock ----------
runlgth = 60;          % length of the impulse response
shock   = 2;           % 2 = deficit / money-growth shock (2nd column of N)

% impres returns z = [x ; y] with rows [K(t+1); phi; r; w; p; H]
z = impres(P,Q,R,S,N,1:6,shock,runlgth);
close(gcf);            % close the raw figure that impres draws automatically

Ktil   = z(1,:);           % capital       K(t+1)
phitil = z(2,:);           % money growth  phi
rtil   = z(3,:);           % rental rate   r
wtil   = z(4,:);           % wage          w
ptil   = z(5,:);           % norm. price   p
Htil   = z(6,:);           % hours         H
Ctil   = -phitil - ptil;   % consumption from log-linear CIA:  p + C = -phi

t = 1:runlgth;

% color palette (same as HW08)
palette = [0.00 0.32 0.60;    % blue
           0.85 0.33 0.10;    % orange
           0.47 0.67 0.19;    % green
           0.49 0.18 0.56];   % purple

% ----- Figure 1: nominal block (money growth, price, consumption) -----
figure(1)
set(gcf,'Color','white','ToolBar','none','MenuBar','none')
hold on
plot(t, 100*phitil, 'Color',palette(1,:), 'LineWidth',1.8)
plot(t, 100*ptil,   'Color',palette(2,:), 'LineWidth',1.8)
plot(t, 100*Ctil,   'Color',palette(3,:), 'LineWidth',1.8)
plot([t(1) t(end)],[0 0],'Color',[0.6 0.6 0.6],'LineWidth',0.8)   % zero line
hold off
ax = gca;
set(ax,'Color','white','FontName','Helvetica','FontSize',11,'Box','off')
grid on; grid minor
ytickformat('%.0f%%')
xlabel('Periods')
ylabel('Deviation from steady state')
legend('\phi (money growth)','p (price)','C (consumption)', ...
       'Location','best','Box','off')
title('Money-growth shock: nominal block','FontWeight','bold','FontSize',13)
exportgraphics(gcf,'irf_nominal.pdf','ContentType','vector')

% ----- Figure 2: real allocation (capital, hours, rental, wage) -----
figure(2)
set(gcf,'Color','white','ToolBar','none','MenuBar','none')
hold on
plot(t, 100*Ktil, 'Color',palette(1,:), 'LineWidth',1.8)
plot(t, 100*Htil, 'Color',palette(2,:), 'LineWidth',1.8)
plot(t, 100*rtil, 'Color',palette(3,:), 'LineWidth',1.8)
plot(t, 100*wtil, 'Color',palette(4,:), 'LineWidth',1.8)
plot([t(1) t(end)],[0 0],'Color',[0.6 0.6 0.6],'LineWidth',0.8)   % zero line
hold off
ax = gca;
set(ax,'Color','white','FontName','Helvetica','FontSize',11,'Box','off')
grid on; grid minor
ytickformat('%.1f%%')
xlabel('Periods')
ylabel('Deviation from steady state')
legend('K_{t+1} (capital)','H (hours)','r (rental)','w (wage)', ...
       'Location','best','Box','off')
title('Money-growth shock: real allocation','FontWeight','bold','FontSize',13)
exportgraphics(gcf,'irf_real.pdf','ContentType','vector')