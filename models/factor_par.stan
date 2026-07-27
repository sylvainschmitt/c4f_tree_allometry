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
  int<lower=1> grainsize;
}
transformed data {
  array[P] real log_agb = log(to_array_1d(agb));
  vector[N] wd_dbh2 = wd .* dbh .* dbh;
  array[P] int end_p1;
  for (p in 1:P) end_p1[p] = end[p] + 1;
}
parameters {
  real<lower=1, upper=60> alpha; // asymptotic height
  real<lower=0.1> sigma_a;
  vector<lower=1, upper=60> [F] alpha_f;
  real<lower=1,upper=80> beta; // growth speed
  real<lower=0.1> sigma_b;
  vector<lower=1,upper=80> [F] beta_f;
  vector[S] epsilon_s; // species random effect
  real <lower=0.1> sigma_s;
  real<lower=0.1> sigma;
}
transformed parameters {
  vector[P] mu;
  {
    vector[S] gamma_s = exp(epsilon_s*sigma_s);
    vector[N+1] ccontrib0;
    ccontrib0[1] = 0;
    ccontrib0[2:N+1] = cumulative_sum(gamma_s[species] .*(0.0673 * pow(wd_dbh2 .* (alpha_f[factor] .* dbh) ./ (beta_f[factor] + dbh), 0.976)));
    mu = ccontrib0[end_p1] - ccontrib0[start];    
  }
}
model {
  log_agb ~ normal(log(mu), sigma);
  epsilon_s ~ std_normal();
  alpha_f ~ normal(alpha, sigma_a);
  beta_f ~ normal(beta, sigma_b);
  alpha ~ normal(40, 10);
  sigma   ~ normal(0, 1);
  sigma_a ~ normal(0, 20);
  sigma_b ~ normal(0, 20);
  sigma_s ~ normal(0, 1);
}
generated quantities {
  vector[P] pred_ha = mu ./ 10^3 ./ area;
}
