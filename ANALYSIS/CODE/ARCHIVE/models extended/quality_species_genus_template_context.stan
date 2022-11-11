// Parrot mimicry
// Simeon Q. Smeele
// Started: 15-09-2022
// Last modified: 15-09-2022
// Description: Simple model explaining mimicry quality with species, genus, template and context. 

data{
  int<lower=0> N_obs;
  int<lower=0> N_species;
  int<lower=0> N_genera;
  int quality[N_obs];
  int species[N_obs];
  int genus[N_obs];
  int temp[N_obs];
  int context[N_obs];
  vector[3] alpha;
}
parameters{
  ordered[2] kappa;
  real a_bar;
  vector[N_species] z_species;
  real<lower=0> sigma_species;
  vector[N_genera] z_genus;
  real<lower=0> sigma_genus;
  vector[2] z_temp;
  real<lower=0> sigma_temp;
  vector[2] z_cont;
  real<lower=0> sigma_cont;
}
model{
  vector[N_obs] phi;
  kappa ~ normal( 0 , 1.5 );
  a_bar ~ normal(2, 2);
  sigma_species ~ exponential(0.5);
  z_species ~ normal(0, 1);
  sigma_genus ~ exponential(0.5);
  z_genus ~ normal(0, 1);
  sigma_temp ~ exponential(0.5);
  z_temp ~ normal(0, 1);
  sigma_cont ~ exponential(0.5);
  z_cont ~ normal(0, 1);
  for(i in 1:N_obs) phi[i] = a_bar + 
  z_species[species[i]] * sigma_species +
  z_genus[genus[i]] * sigma_genus + 
  z_temp[temp[i]] * sigma_temp +
  z_cont[context[i]] * sigma_cont;
  for(i in 1:N_obs) quality[i] ~ ordered_logistic(phi[i], kappa);
}
generated quantities{
  vector[2] a_temp;
  vector[2] a_cont;
  a_temp = z_temp * sigma_temp;
  a_cont = z_cont * sigma_cont;
}