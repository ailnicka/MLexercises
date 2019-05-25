function w = weight(X_train, i, x, tau)  dist = (X_train(i,:)-x)*(X_train(i,:)-x)';% function calculating weights for the training point i
w = exp(- dist/(2*tau^2));  