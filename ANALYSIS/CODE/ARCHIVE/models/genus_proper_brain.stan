// Parrot mimicry
// Simeon Q. Smeele
// Started: 03-09-2022
// Last modified: 03-09-2022
// Description: Simple model explaining mimicry with genus, longevity and relative brain size. 

data {
  int<lower=0> N_species;
  int<lower=0> N_genus;
  int mimic[N_species];
  int genus[N_species];
  real stand_brain[N_species];
  real stand_body[N_species];
}

parameters {
  real a_bar;
  real a_brain;
  real b_brain;
  real b_body_brain;
  vector[N_genus] z;
  real<lower=0> sigma_genus;
  real<lower=0> sigma_brain;
}

model {
  // Declare
  vector[N_species] mu_brain;
  vector[N_species] p;
  // Brain model
  a_brain ~ normal(0, 0.5);
  b_body_brain ~ normal(0, 0.5);
  sigma_brain ~ exponential(1);
  for(n in 1:N_species) mu_brain[n] = a_brain + b_body_brain * stand_body[n];
  stand_brain ~ normal(mu_brain, sigma_brain);
  // Mimicry model
  a_bar ~ normal(0, 1);
  b_brain ~ normal(0, 0.5);
  sigma_genus ~ exponential(1);
  z ~ normal(0, 1);
  for(n in 1:N_species){
    p[n] = a_bar + z[genus[n]] * sigma_genus + 
    b_brain * (stand_brain[n] - mu_brain[n]);
    p[n] = inv_logit(p[n]);
  } 
  mimic ~ binomial(1, p);
}



