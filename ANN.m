function [coeficiente_R2_final,coeficiente_R2_f2_final,coeficiente_R2_f3_final,coeficiente_R2_f4_final] = ANN(InputsANN,TargetsANN,NUM_neuronas_capa_1,NUM_neuronas_capa_2,d)
    
Comb=readtable('Comb.xlsx');

% CARGAMOS LOS INPUTS Y OUTPUTS ORDENADOS ORIGINALMENTE

inputs = InputsANN;
outputs = TargetsANN;

rng(0) %rng('default')  

% Feature selection
        
[n,m]=size(Comb);

inputs_d=inputs;
     
         
if Comb.FormaFibra(d)==0
    inputs_d(12:16,:)=[];
    m=m-1;
else
end
if Comb.HProbeta(d)==0
    inputs_d(10:11,:)=[];
    m=m-1;
else
end
if Comb.TipoProbeta(d)==0
    inputs_d(8:9,:)=[];
    m=m-1;
else
end
if Comb.TipoFibra(d)==0
    inputs_d(6:7,:)=[];
    m=m-1;
else
end
if Comb.Cuantia(d)==0
    inputs_d(5,:)=[];
    m=m-1;
else
end
if Comb.Fy(d)==0
    inputs_d(4,:)=[];
    m=m-1;
else
end
if Comb.DFibra(d)==0
    inputs_d(3,:)=[];
    m=m-1;
else
end
if Comb.LFibra(d)==0
    inputs_d(2,:)=[];
    m=m-1;
else
end
if Comb.Fck(d)==0
    inputs_d(1,:)=[];
    m=m-1;
else
end                  
            

metodo_training = 'trainbr';
RedNeuronal_final = fitnet([NUM_neuronas_capa_1,NUM_neuronas_capa_2],metodo_training);  %sintaxis: = fitnet(hiddenSizes,trainFcn)

% Función de transferencia
RedNeuronal_final.layers{1}.transferFcn = 'tansig'; %'tansig' or 'logsig'

% Parámetros de entrenamiento
RedNeuronal_final.trainParam.showWindow = false;
RedNeuronal_final.trainParam.epochs = 500;   
RedNeuronal_final.trainParam.min_grad = 1e-10;

% Método y parámetros de separación de datos (training, validation y test)            
%RedNeuronal_final.divideFcn = 'dividerand';
RedNeuronal_final.divideParam.trainRatio = 0.999;%0.999
RedNeuronal_final.divideParam.valRatio = 0.0005;%0.0005
RedNeuronal_final.divideParam.testRatio = 0.0005;%0.0005
    
RedNeuronal_final.plotFcns = {'plotperform','plottrainstate', 'ploterrhist', ...
    'plotregression', 'plotresponse', 'ploterrcorr', 'plotinerrcorr'};
%         [trainInd,valInd,testInd] = dividetrain(350,1,0,0) 
RedNeuronal_final.performParam.normalization = 'standard';
[RedNeuronal_final ,tr] = train( RedNeuronal_final,inputs_d,outputs);
%     plotperform(tr)
%      A=tr.trainInd;
%      B=tr.valInd;
%      C=tr.testInd;
%[ RedNeuronal_f2m indices_valores y_real error ] = train(RedNeuronal_f2m, inputs,outputs);
%RedNeuronal_f2m.performFcn = 'mse';
%RedNeuronal_f2m = train(RedNeuronal_f2m,inputs,outputs);
%  indices_valores = indices_valores; % The training record will reveal the training information
%  indices_valores_cell = struct2cell(indices_valores);
%  indices_datos_training=indices_valores_cell{9};
%  indices_datos_validation=indices_valores_cell{10};
%  indices_datos_test=indices_valores_cell{11};
    
% GUARDAMOS LA RED NEURONAL

save RedNeuronal_final

% MEDIMOS Y GRAFICAMOS SU PRECISIÓN
    
% targets_final = RedNeuronal_final(inputs); 
% coeficiente_R2 = funcion_coeficiente_R2(targets_final,outputs);

targets_final_train = RedNeuronal_final(inputs_d(:,tr.trainInd)); 
[coeficiente_R2_final,coeficiente_R2_f2_final,coeficiente_R2_f3_final,coeficiente_R2_f4_final]=funcion_coeficiente_R2(targets_final_train,outputs(:,tr.trainInd));


figure
hold on
title('fr reales Vs fr estimados train')
xlabel('fr reales (MPa)')
ylabel('fr estimados (MPa)')
scatter(outputs(1,tr.trainInd),targets_final_train(1,:)) 
scatter(outputs(2,tr.trainInd),targets_final_train(2,:)) 
scatter(outputs(3,tr.trainInd),targets_final_train(3,:))
% axis([0 0.9 0 0.9])


end