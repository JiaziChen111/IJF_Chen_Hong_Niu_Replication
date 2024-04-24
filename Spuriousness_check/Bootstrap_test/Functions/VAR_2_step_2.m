function [mu,phi,omega,mu_std,phi_std] = VAR_2_step_2(Y)
Spec=varm(3,1); %3 dimensional vector, lag = 1;
[EstSpec,EstStdErrors]=estimate(Spec,Y);
mu=EstSpec.Constant;
phi=EstSpec.AR{1,1};
omega=EstSpec.Covariance;
mu_std=EstStdErrors.Constant;
phi_std=EstStdErrors.AR{1,1};
% Spec = vgxset('n',3,'nAR',1,'Constant',true); 
% [EstSpec,EstStdErrors] = vgxvarx(Spec,Y,[],[],'StdErrType','all');
% mu = EstSpec.a;
% phi = EstSpec.AR{1,1};
% omega = EstSpec.Q;
% mu_std = EstStdErrors.a;
% phi_std = EstStdErrors.AR{1,1};
% omega_std = EstStdErrors.Q;
