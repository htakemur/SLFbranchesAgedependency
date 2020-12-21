function yhat = evalPoissonCurve(coefs,x)
% Evaluates a Poisson curve at specified points
%
% yhat = evalPoissonCurve(coefs,x)
%
% Copyright Jason D. Yeatman, August 2014. Code released with:
% Yeatman JD, Wandell BA & Mezer AM (2014). Lifespan maturation 
% and degeneration of human brain white matter. Nature Communications.
% Github repository hosting the original version of the code: https://github.com/jyeatman/lifespan

pfun = @(p,x) p(1).*x.*exp(-p(2)*x)+p(3);
yhat = feval(pfun,coefs,x);
