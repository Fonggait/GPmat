function model = gpsimMapUpdatePosteriorCovariance(model)

% GPSIMMAPUPDATEPOSTERIORCOVARIANCE update the posterior covariance of f.
% FORMAT
% DESC updates the stored representation of the posterior
% covariance of f in a GPSIMMAP model. Relies on the representation
% of the kernel and the data Hessian being up to date. These can be
% forced to be up to date by using gpsimMapUpdateKernels and
% gpsimMapFunctionalUpdateW. 
% ARG model : the model for which the representation is to be
% updated.
% RETURN model : the model with the updated representation.
%
% COPYRIGHT : Neil D. Lawrence, 2006
%
% SEEALSO : gpsimMapUpdateKernels, gpsimMapFunctionalUpdateW

% GPSIM

model.invCovf = model.invK + model.W;
[model.covf, U, jitter] = pdinv(model.invCovf);
if jitter > 1e-4
  fprintf('Warning: gpsimMapUpdatePosteriorCovariance added jitter of %2.4f\n', jitter)
end
model.logDetCovf = - logdet(model.invCovf, U); 
model.varf = diag(model.covf);
