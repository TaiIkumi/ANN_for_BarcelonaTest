function [coeficiente_R2_mean,coeficiente_R2_f2,coeficiente_R2_f3,coeficiente_R2_f4] = funcion_coeficiente_R2(targets,outputs)
% yav = mean(targets);
% s1 = sum((targets-yav).^2);
% s2 = sum((targets-outputs).^2);
% coeficiente_R2 = 1 - s2/s1;

yav = mean(outputs,2);
s1 = sum((outputs-yav).^2,2);
s2 = sum((outputs-targets).^2,2);
coeficiente_R2 = (1 - s2./s1);
coeficiente_R2_f2 = coeficiente_R2(1);
coeficiente_R2_f3 = coeficiente_R2(2);
coeficiente_R2_f4 = coeficiente_R2(3);
coeficiente_R2_mean = mean(coeficiente_R2);
end

