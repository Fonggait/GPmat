function model = ivm(X, y, kernelType, noiseType, selectionCriterion, d)

% IVM Initialise an IVM model.

% IVM

model.terminate = 0;

model.d = d;

model.X = X;
model.y = y;

model.m = [];
model.beta = [];

model.nu = zeros(size(y));
model.g = zeros(size(y));

model.kern = kernCreate(X, kernelType);
  
model.varSigma = zeros(size(y));
model.mu = zeros(size(y));

model.I = [];
model.J = [];

model.noise = noiseCreate(noiseType, y); 

if model.noise.spherical
  model.Sigma.M = [];
  model.Sigma.L = [];
  model.Sigma.robust = 0;
else
  for i = 1:size(y, 2)
    model.Sigma(i).M = [];
    model.Sigma(i).L = [];
    model.Sigma(i).robust = 0;
  end
end
model.selectionCriterion = selectionCriterion;


switch selectionCriterion
 case 'none'
  numData = size(X, 1);
  model.I = (1:numData);
 otherwise
  
end