#A first nlmixr2 model-----# #Build a PK model. Use ordinary R function with two blocks -#
#Build a base PK model. Use ordinary R function with two blocks -#
pheno <- function() {
  ini({
    tcl <- log(0.008)   # log typical clearance (L/h)
    tv  <- log(0.6)     # log typical volume (L)
    eta.cl ~ 1          # between-infant variability on clearance
    eta.v  ~ 1          # between-infant variability on volume
    prop.sd <- 0.1      # proportional residual error
  })
  model({
    cl <- exp(tcl + eta.cl)
    v  <- exp(tv  + eta.v)
    d/dt(central) <- -(cl / v) * central
    cp <- central / v
    cp ~ prop(prop.sd)
  })
}
# we hold initial estimates with "ini", "<-" declares fixed estimates
# while "~" declares random effects with initial variance. As for the model drug leaves central compartment
#at a proportional rate of what's there. Dosing doesnt appear here. It's driven by the date (AMT/EVID). 

#"cp" declares that observed conc is the predicted cp. with proportional residual error#FIT the Model
fit1 <- nlmixr2(pheno, pheno_sd, est = "saem",
control = saemControl(print = 0, seed =42),
table = tableControl(cwres = TRUE, npde = TRUE))
#print predicition results
names(fit1$parFixedDf)
head(fit1$parFixed) 


