function [sk k e m v] = features(Y)
m = mean2(Y);
v = var(Y(:));
e  = entropy(Y);
[sk k] = GetSkewAndKurtosis(Y);
end