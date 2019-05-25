function y = lwlr(X_train, y_train, x, tau)

%% Locally weighted logistic regression
% the vaule of parameter lambda given in exerscise
lam = 0.0001;
%% m the sample size
m = length(y_train);
%% Update of Theta in Newton's method Th := Th + l'(Th)/l''(Th)
%% Initialise Th as a zero vector:
Th = [0;0];
Grad = [1;1];

%% to avoid too many iterations
iter = 0;
%% building vector of weights for the training set
weights = exp(-sum((X_train - repmat(x', m, 1)).^2, 2) / (2 * tau^2));

while (norm(Grad) > 0.0001 && iter < 10000) 
  iter = iter+1;
%% vector of h_Theta from X
  h = 1.0 ./ (1.0 + exp(-sum(X_train .* Th',2)));
  
%%  auxiliary variables z and D for gradient and hessian calculation
  z = weights .* (y_train - h);
  D = diag(- weights .* (1.0 - h) .* h);

  %% Hessian expression H = XT DX − λI
  Hess = X_train' * D * X_train - lam * eye(2);
  %% Grad expression ∇θl(θ) = XT z − λθ
  Grad = X_train' * z - lam * Th;
  %% Update of Theta in Newton's method Th := Th + l'(Th)/l''(Th) 
  Th = Th - Hess \ Grad;
endwhile
%% make prediction for y
if (1.0 / (1.0 + exp(-x' * Th)) > 0.5)
  y = 1;
else
  y = 0;
endif
