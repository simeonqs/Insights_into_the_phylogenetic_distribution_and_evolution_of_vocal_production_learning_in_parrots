// Parrot mimicry
// Simeon Q. Smeele
// Started: 10-11-2022
// Last modified: 09-12-2022
// Description: Model to estimate the body size. 

data{
  // Dimensions
  int N_obs;
  int N_species;
  int N_genera;
  // One data point per species
  int genus[N_species];
  int habitat[N_species];
  // Multiple data points per species
  int quality[N_obs];
  int species[N_obs];
  // Alpha
  vector[3] alpha;
}
parameters{
  // Main model
  ordered[2] kappa;
  real a_bar;
  vector[N_species] z_species;
  real<lower=0> sigma_species;
  vector[N_genera] z_genus;
  real<lower=0> sigma_genus;
  vector[3] z_hab;
  real<lower=0> sigma_hab;
}
model{
  // Declare
  vector[N_obs] phi;
  // Main model
  a_bar ~ normal(2, 2);
  sigma_species ~ exponential(2);
  z_species ~ normal(0, 1);
  sigma_genus ~ exponential(2);
  z_genus ~ normal(0, 1);
  z_hab ~ normal(0, 1);
  sigma_hab ~ exponential(2);
  for(i in 1:N_obs) phi[i] = a_bar + 
    z_species[species[i]] * sigma_species +
    z_genus[genus[species[i]]] * sigma_genus + 
    z_hab[habitat[species[i]]] * sigma_hab;
  for(i in 1:N_obs) quality[i] ~ ordered_logistic(phi[i], kappa);
}
generated quantities{
  vector[3] a_hab;
  a_hab = a_bar + z_hab * sigma_hab;
}
