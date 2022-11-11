// Parrot mimicry
// Simeon Q. Smeele
// Started: 14-09-2022
// Last modified: 14-09-2022
// Description: Simple model explaining mimicry quality with some variables. 

data{
  // Dimensions
  int<lower=0> N_obs;
  int<lower=0> N_species;
  int<lower=0> N_genera;
  // Brain model - one data point per species
  vector[N_species] stand_body_short;
  vector[N_species] stand_brain_short;
  int genus_short[N_species];
  // Main model - multiple data points per species
  int quality[N_obs];
  int species[N_obs];
  int genus[N_obs];
  // Alpha
  vector[3] alpha;
}
parameters{
  // Brain model
  real a_brain;
  real b_body_brain;
  vector[N_genera] z_genus_brain;
  real<lower=0> sigma_genus_brain;
  real<lower=0> sigma_brain;
  // Main model
  ordered[2] kappa;
  real a_bar;
  vector[N_species] z_species;
  real<lower=0> sigma_species;
  vector[N_genera] z_genus;
  real<lower=0> sigma_genus;
  real b_brain;
}
model{
  // Declare
  vector[N_obs] phi;
  vector[N_species] mu_brain;
  // Brain model - creates a mu_brain per species
  a_brain ~ normal(0, 0.5);
  b_body_brain ~ normal(0, 0.5);
  sigma_brain ~ exponential(1);
  z_genus_brain ~ normal(0, 1);
  sigma_genus_brain ~ exponential(1);
  for(i in 1:N_species) mu_brain[i] = a_brain + 
  z_genus_brain[genus_short[i]] * sigma_genus_brain +
  b_body_brain * stand_body_short[i];
  stand_brain_short ~ normal(mu_brain, sigma_brain);
  // Main model
  kappa ~ normal(0, 1.5);
  a_bar ~ normal(0, 2);
  sigma_species ~ exponential(1);
  z_species ~ normal(0, 1);
  sigma_genus ~ exponential(1);
  z_genus ~ normal(0, 1);
  b_brain ~ normal(0, 1);
  for(i in 1:N_obs) phi[i] = a_bar + 
  z_species[species[i]] * sigma_species +
  z_genus[genus[i]] * sigma_genus + 
  b_brain * (stand_brain_short[species[i]] - mu_brain[species[i]]); // need the species bit to match size;
  for(i in 1:N_obs) quality[i] ~ ordered_logistic(phi[i], kappa);
}