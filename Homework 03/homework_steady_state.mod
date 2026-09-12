// ============================================================
//  Macroeconomics II - Class 3 - Homework
//  Steady state of the competitive economy (RC with labor choice)
//
//  u(c,1-h) = log(c) + A*log(1-h)
//  f(K,H)   = gamma * K^theta * H^(1-theta)
//
//  Steady state computed by direct evaluation of the closed-form
//  formulas derived in Step 1 (steady_state_model block).
// ============================================================

// ---------- Variables ----------
var C H K Y I;        // consumption, labor, capital, output, investment

// ---------- Parameters ----------
parameters A gamma theta beta delta;

A     = 1.72;
gamma = 3;
theta = 0.56;
beta  = 0.98;
delta = 0.06;

// ---------- Model ----------
model;
  // Production
  Y = gamma * K(-1)^theta * H^(1-theta);

  // Labor-leisure (intratemporal):  u_h/u_c = f_h
  //   u_h/u_c = A*C/(1-H) ;  f_h = (1-theta)*Y/H
  A*C/(1-H) = (1-theta)*Y/H;

  // Euler equation (intertemporal):  u_c(t) = beta*u_c(t+1)*[f_k(t+1)+(1-delta)]
  //   u_c = 1/C ;  f_k = theta*Y/K
  (1/C) = beta*(1/C(+1))*( theta*Y(+1)/K + (1-delta) );

  // Capital accumulation
  K = (1-delta)*K(-1) + I;

  // Resource constraint
  Y = C + I;
end;

// ---------- Steady state: closed-form (Step 1) ----------
// Dynare evaluates these expressions directly, no iteration required.
steady_state_model;
  kappa = ( (1/beta - 1 + delta) / (theta*gamma) )^(1/(theta-1));   // K/H
  H = (1-theta)*gamma*kappa^theta
      / ( A*(gamma*kappa^theta - delta*kappa) + (1-theta)*gamma*kappa^theta );
  K = kappa*H;
  Y = gamma*kappa^theta*H;
  C = (gamma*kappa^theta - delta*kappa)*H;
  I = delta*K;
end;

// ---------- Compute and report the steady state ----------
steady;
