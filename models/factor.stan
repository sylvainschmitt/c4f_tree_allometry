data {
  int<lower=1> N; // # obs
  int<lower=1> P; // # plots
  int <lower=1> S; // # species
  int <lower=1> F;  // # factors
  array[N] int<lower=1, upper=P> plot;
  array[N] int<lower=1, upper=S> species;
  array[N] int<lower=1, upper=F> factor;
  vector <lower=0> [P] agb;
  vector <lower=0> [P] agb_ha;
  vector <lower=0> [P] area;
  vector <lower=0> [N] dbh;
  vector <lower=0> [N] wd;
  array[P] int<lower=1, upper=N> start;
  array[P] int<lower=1, upper=N> end;
}
parameters {
  real<lower=0, upper=60> alpha; // asymptotic height
  vector<lower=0, upper=60> [F] alpha_f;
  real<lower=0> sigma_a;
  real<lower=0,upper=80> beta; // growth speed
  vector<lower=0,upper=80> [F] beta_f;
  real<lower=0> sigma_b;
  vector[S] epsilon_s; // species random effect
  real <lower=0> sigma_s;
  real<lower=0> sigma;
}
transformed parameters {
  vector[P] mu = rep_vector(0, P);
  vector[S] gamma_s = exp(epsilon_s*sigma_s);
  for(p in 1:P)
     for(i in start[p]:end[p])
        mu[p] = mu[p] +
                gamma_s[species[i]]*0.0673*
                (wd[i]*dbh[i]^2*
                  (alpha_f[factor[i]]*dbh[i])/(beta_f[factor[i]]+dbh[i])
                )^0.976;
}
model {
  log(agb) ~ normal(log(mu), sigma);
  epsilon_s ~ std_normal();
  alpha_f ~ normal(alpha, sigma_a);
  beta_f ~ normal(beta, sigma_b);
  alpha ~ normal(40, 10);
}
generated quantities {
  vector[P] pred = rep_vector(0, P);
  vector[P] pred_ha;
  for(p in 1:P)
     for(i in start[p]:end[p])
        pred[p] = pred[p] + 0.0673*(wd[i]*dbh[i]^2*((alpha_f[factor[i]]*dbh[i])/(beta_f[factor[i]]+dbh[i])))^0.976;
  pred_ha = pred ./ 10^3 ./ area;
}
