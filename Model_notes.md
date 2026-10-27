# Phenobarbital Pharmacokinetic Modelling Notes

## Project objective

Reproduce and understand the population pharmacokinetic modelling workflow described in the Posit pharmacometrics tutorial, using `nlmixr2` in R.

The current focus is evaluating whether body weight explains some of the between-subject variability (BSV) observed in the base model.

## Model 1: Base model

Model 1 is the baseline against which subsequent models will be compared.

The initial fit estimated:

| Parameter | Estimate | BSV (CV%) | Shrinkage |
|---|---:|---:|---:|
| Typical clearance | 0.00557 L/h | 38.9% | 36.2% |
| Typical volume of distribution | 1.42 L | 46.7% | 2.24% |

The clearance and volume estimates are back-transformed from the logarithmic parameter scale.

These estimates are preliminary model results, not yet a conclusion about biological plausibility or model adequacy.

### Initial interpretation

- **Clearance BSV:** The estimated variability suggests differences between infants that the base model does not explain.
- **Clearance shrinkage:** The relatively high shrinkage suggests limited information for estimating individual clearance values reliably. Sparse concentration sampling may contribute.
- **Volume BSV:** The model also estimates substantial variability in volume of distribution.
- **Volume shrinkage:** The low shrinkage indicates less shrinkage in the individual volume estimates than in clearance estimates, but does not by itself establish model validity.

Potential explanations for high BSV include genuine biological variability, body-size differences, other patient covariates, measurement error, and model misspecification.

## Model 2: Allometric weight scaling

### Pharmacological rationale

Body weight is a biologically plausible covariate in paediatric pharmacokinetics. Differences in body size can affect drug distribution and elimination.

Allometric scaling represents these relationships using power functions of body weight. The conventional starting assumptions used in this modelling approach are:

- Clearance scales with body weight to the power 0.75.
- Volume of distribution scales with body weight to the power 1.

These exponents are assumptions for the model, not values established by the current dataset.

### Model structure

Using WT as body weight in kilograms and 1.3 kg as the reference weight:

- CL = CLtyp × (WT / 1.3)^0.75 × exp(eta_CL)
- V = Vtyp × (WT / 1.3)^1 × exp(eta_V)

The reference weight is used to define the interpretation of the typical parameters. At the reference weight, the allometric weight ratios equal one.

The individual random effects remain in the model. Therefore, weight scaling does not assume that body weight explains all differences between infants.

### Questions to evaluate

1. Does weight scaling reduce estimated BSV in clearance and volume?
2. How does clearance shrinkage change?
3. Does the model fit improve when evaluated using appropriate model comparison criteria?
4. Are the parameter estimates stable and biologically plausible?
5. Do prediction and residual diagnostic plots support the revised model?

### Interpretation cautions

A reduction in BSV is not sufficient evidence that a model is better. Model comparison should consider the objective function, information criteria where comparable, diagnostic plots, parameter precision, and scientific plausibility.

High shrinkage should be interpreted in the context of the number and timing of observations per infant. Individual estimates should not be treated as equally reliable across all infants.

The suitability of weight scaling also depends on the actual model specification, dosing data, time units, concentration units, and available covariates.

## Reproducibility

- Preserve the base model as a reference.
- Store each model in a separate, clearly named script.
- Record model assumptions and any changes from the tutorial.
- Record estimation settings and random seeds.
- Do not commit identifiable patient data or other sensitive data to a public repository.
- Record the R and package versions used for each analysis.

## Reference

https://posit.co/blog/pharmacometrics-in-r-posit
