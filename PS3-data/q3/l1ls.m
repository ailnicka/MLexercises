function theta = l1ls(X,y,lambda)
%%% cooridinate ascent for l1 regularisation least squares

%%% get the size of sample X, n is no of features, m is size of training set
[m,n] = size(X);
theta = zeros(n,1);
theta_old = ones(n,1);
while norm(theta - theta_old) > 0.00001
  theta_old = theta;
  for i = 1:n
    xi = X(:,i);
    theta(i) = 0;
    theta_plus = max(0, (-xi'*(X*theta - y) - lambda)/(xi'*xi));
    theta_minus = min(0, (-xi'*(X*theta - y) + lambda)/(xi'*xi)); 
    theta(i) = theta_plus;
    Jplus = 0.5 * norm(X*theta - y)^2 + lambda * norm(theta,1);
    theta(i) = theta_minus;
    Jminus = 0.5 * norm(X*theta - y)^2 + lambda * norm(theta,1);
    if (Jplus < Jminus) 
      theta(i) = theta_plus;
    endif
  endfor
endwhile
