function [param, names] = gpTimeDynamicsExtractParam(model)

% GPTIMEDYNAMICSEXTRACTPARAM Extract parameters from the GP time dynamics model.
% FORMAT
% DESC extracts the model parameters from a structure containing
% the information about a Gaussian process dynamics model.
% ARG model : the model structure containing the information about
% the model.
% RETURN params : a vector of parameters from the model.
%
% DESC does the same as above, but also returns parameter names.
% ARG model : the model structure containing the information about
% the model.
% RETURN params : a vector of parameters from the model.
% RETURN names : cell array of parameter names.
%
% SEEALSO : gpExtractParam, gpTimeDynamicsCreate, gpTimeDynamicsExpandParam, modelExtractParam
%
% COPYRIGHT : Neil D. Lawrence, 2006, 2009

% SHEFFIELDML

if nargout > 1
  returnNames = true;
else
  returnNames = false;
end  

if returnNames
  [param, names] = gpExtractParam(model);
else
  param = gpExtractParam(model);
end

if ~model.learn 
  % If we aren't learning model parameters extract only X_u;
  if ~model.learnScales
    if isfield(model, 'fixInducing') & model.fixInducing
      param = [];
      names = {};
    else
      ind = 1:model.k*model.q;
      param = param(ind);
      if returnNames
        names = names(ind);
      end
    end
  else
    % learning scales but not parameters
    switch model.approx
     case 'ftc'
      param =  param(end-model.d + 1:end);
      if returnNames
        names = names(end-model.d + 1:end);
      end
     case {'dtc', 'dtcvar', 'fitc', 'pitc'}
      if isfield(model, 'fixInducing') & model.fixInducing
        param =  param(end-model.d:end-1);
        if returnNames
          names = names(end-model.d:end-1);
        end
      else
        param =  [param(1:model.k*model.q) param(end-model.d:end-1)];
        if returnNames
          names = names([1:model.k*model.q end-model.d:end-1]);
        end
      end
    end
  end
end