function y = lwlr(X_train, y_train, x, tau)

%% Locally weighted logistic regression
% the vaule of parameter lambda given in exerscise
lam = 0.0001;
%% sample size m
m = length(y_train);
%% Update of Theta in Newton's method Th := Th + l'(Th)/l''(Th)
%% Initialise Th as a zero vector:
Th = [0;0];
Th_old = [1;1];

%% to avoid too many iterations
iter = 0;
  dist = (X_train(i,:) - repmat(x,m) )*(X_train(i,:) - repmat(x,m))';
% function calculating weights for the training point i
w = exp(- dist/(2*tau^2));
for i=1:m
  weights(i) = weight(X_train, i, x', tau);
end

while (norm(Grad) > 0.0001 && iter < 10000) 
  %% Create vector z
  iter = iter+1;
  %(Th_old - Th)'*(Th_old - Th)
  %% Create D matrix of all zeros and fill on diagonal
  D = zeros(m);
  for i=1:m
    h = h_Th(X_train(i,:), Th);
    z(i) = weights(i) * (y_train(i) - h);
    D(i,i) = - weights(i) * (1.0 - h) * h;
  end

  %% Hessian expression H = XT DX − λI
  Hess = X_train' * D * X_train - lam * eye(2);
  %% Grad expression ∇θl(θ) = XT z − λθ
  Grad = X_train' * z' - lam * Th;
  %% Update of Theta in Newton's method Th := Th + l'(Th)/l''(Th) 
  Th_old = Th;
  Th = Th - Hess \ Grad;
endwhile

if ( h_Th(x',Th) > 0.5 )
  y=1;
else
  y=0;
endif
