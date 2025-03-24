data {
  int<lower=1> N; // # obs
  int<lower=1> P; // # plots
  int<lower=1> S; // # species
  array[N] int<lower=1, upper=P> plot;
  array[N] int<lower=1, upper=S> species;
  vector<lower=0> [N] h;
  vector<lower=0> [N] dbh;
}
parameters {
  real<lower=20,upper=60> alpha_0; // asymptotic hieght
  real<lower=0,upper=80> beta_0; // growth speed
  vector [P] gamma_p; // plot random effect
  real<lower=0> sigma_p;
  vector [S] gamma_s; // species random effect
  real<lower=0> sigma_s;
  real<lower=0> sigma;
}
model {
  log(h) ~ normal(gamma_s[species] +
                  gamma_p[plot] +
                  log((alpha_0 .* dbh) ./ (beta_0+dbh)), 
                  sigma);
  gamma_s ~ normal(0, sigma_s);
  gamma_p ~ normal(0, sigma_p);
}
generated quantities{
  vector <lower=0> [N] y_p = (alpha_0 .* dbh) ./ (beta_0+dbh);
}
