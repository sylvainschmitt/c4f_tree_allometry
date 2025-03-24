data {
  int<lower=1> N; // # obs
  int<lower=1> P; // # plots
  int <lower=1> S; // # species
  int <lower=1> F;  // # factors
  array[N] int<lower=1, upper=P> plot;
  array[N] int<lower=1, upper=S> species;
  array[N] int<lower=1, upper=F> factor;
  vector <lower=0> [N] h;
  vector <lower=0> [N] dbh;
}
parameters {
  vector<lower=20,upper=60> [F] alpha_f; // asymptotic hieght
  vector<lower=0,upper=80> [F] beta_f; // growth speed
  vector [P] gamma_p; // plot random effect
  real<lower=0> sigma_p;
  vector [S] gamma_s; // species random effect
  real <lower=0> sigma_s;
  real<lower=0> sigma;
}
transformed parameters {
  vector[N] h_p = (alpha_f[factor] .* dbh) ./ (beta_f[factor]+dbh);
}
model {
  log(h) ~ normal(gamma_s[species] + gamma_p[plot] + log(h_p), sigma);
  gamma_s ~ normal(0, sigma_s);
  gamma_p ~ normal(0, sigma_p);
}
