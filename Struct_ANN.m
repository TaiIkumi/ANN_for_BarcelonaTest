function  [matriz_R2_mean,matriz_R2_f2,matriz_R2_f3,matriz_R2_f4,matriz_MSE] = Struct_ANN(k_max,InputsANN,TargetsANN,numero_probetas,numero_columnas_inputs,numero_columnas_targets)

Comb=readtable('Comb.xlsx');
[n,m]=size(Comb);


for k = 49:k_max            % https://es.wikipedia.org/wiki/Validación_cruzada      
it_total=0;
% CARGAMOS LOS INPUTS Y OUTPUTS ORDENADOS ORIGINALMENTE

inputs_originales = InputsANN;
outputs_originales = TargetsANN;

% CAMBIAMOS EL ORDEN DE LOS INPUTS Y OUTPUTS ALEATORIAMENTE

rng(k) %rng('default')  Poniendo rng(k) quiere decir q al repetir la iteración se repiten los números aleatorios
indices_aleatorios = randperm(numero_probetas);
inputs=zeros(numero_columnas_inputs,numero_probetas);
% modificado por Rubén:  
outputs=zeros(numero_columnas_targets,numero_probetas);
for j=1:numero_probetas
    for i = 1:numero_columnas_inputs
        inputs(i,j) = inputs_originales(i,indices_aleatorios(j));
    end
    for i=1:numero_columnas_targets
    outputs(i,j) = outputs_originales(i,indices_aleatorios(j));
    end
end
        
   % Feature selection
        
     for d=1:n
     [n,m]=size(Comb);
     d
     k
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
         
         m
    
       
        % DEFINIMOS nº NEURONAS H. LAYER 1
         for j=1:m
        
             % DEFINIMOS nº NEURONAS H. LAYER 2 Y ENTRENAMOS LA RED
        
            for i = 0:j
            
                it_total=it_total+1;
                rng(0) %rng('default')              

            
                metodo_training = 'trainbr';  % https://es.mathworks.com/help/deeplearning/ref/fitnet.html

                % Tipo de red neuronal (fitnet = Function fitting neural network)
                if i==0
                    RedNeuronal_f2m = fitnet(j,metodo_training);    
                else
                    RedNeuronal_f2m = fitnet([j,i],metodo_training);  %sintaxis: = fitnet(hiddenSizes,trainFcn)
                end
                % Configuración red
                
                RedNeuronal_f2m.trainParam.showWindow = false;
%                 RedNeuronal_f2m.layers{1}.transferFcn = 'tansig'; %'tansig' or 'logsig'
                RedNeuronal_f2m.trainParam.epochs = 500;   
                % RedNeuronal_f2m.trainParam.mu_max = 1e15
                % RedNeuronal_f2m.trainParam.goal = 0    
                % RedNeuronal_f2m.trainParam.lr = 1e-6
                % RedNeuronal_f2m.trainParam.lr_inc = 1.1
                % RedNeuronal_f2m.trainParam.lr_dec = 0.8
                % RedNeuronal_f2m.trainParam.max_fail = 20  
                RedNeuronal_f2m.trainParam.min_grad = 1e-10;

                % Método y parámetros de separación de datos (training, validation y test)   
                
    %             RedNeuronal_f2m.divideFcn = 'dividerand';
                RedNeuronal_f2m.divideParam.trainRatio = 0.8;%0.999
                RedNeuronal_f2m.divideParam.valRatio = 0;%0.0005
                RedNeuronal_f2m.divideParam.testRatio = 0.2;%0.0005
                RedNeuronal_f2m.performParam.normalization = 'standard';
               [RedNeuronal_f2m,tr] = train(RedNeuronal_f2m,inputs_d,outputs);
    %             plotperform(tr)
    %             A(i,:)=tr.trainInd;
    %             B(k,:)=tr.valInd;
    %             C(i,:)=tr.testInd;
                % Personalizar opciones network training
                %RedNeuronal_f2m.performFcn = 'mse';
                         
                % Evaluamos targets set de test con la red entrenada 
                targets = RedNeuronal_f2m(inputs_d(:,tr.testInd)); 
            
                % MSE entre los targets y el output real
                MSE = perform(RedNeuronal_f2m,outputs(:,tr.testInd),targets);  % Por defecto es "MSE"
%                 MSE_iteracion(i-min_neuronas+1)=MSE;

                % Medimos el R2 entre los targets y el output real
%                 coeficiente_R2(i-min_neuronas+1)=funcion_coeficiente_R2(targets,outputs(:,tr.testInd));
                 [coeficiente_R2_mean,coeficiente_R2_f2,coeficiente_R2_f3,coeficiente_R2_f4]=funcion_coeficiente_R2(targets,outputs(:,tr.testInd));
                 
                 
                matriz_R2_mean(it_total,1)=d';
                matriz_R2_mean(it_total,2)=j';
                matriz_R2_mean(it_total,3)=i';
                matriz_R2_mean(it_total,3+k)=coeficiente_R2_mean';
                matriz_R2_f2(it_total,1)=d';
                matriz_R2_f2(it_total,2)=j';
                matriz_R2_f2(it_total,3)=i';
                matriz_R2_f2(it_total,3+k)=coeficiente_R2_f2';
                matriz_R2_f3(it_total,1)=d';
                matriz_R2_f3(it_total,2)=j';
                matriz_R2_f3(it_total,3)=i';
                matriz_R2_f3(it_total,3+k)=coeficiente_R2_f3';
                matriz_R2_f4(it_total,1)=d';
                matriz_R2_f4(it_total,2)=j';
                matriz_R2_f4(it_total,3)=i';
                matriz_R2_f4(it_total,3+k)=coeficiente_R2_f4';
                
                matriz_MSE(it_total,1)=d';
                matriz_MSE(it_total,2)=j';
                matriz_MSE(it_total,3)=i';
                matriz_MSE(it_total,3+k)=MSE';
            end       
         end
    end
end
    
%     % Cálculo de R2 y MSE promedio
%     
%      for i = 1:(max_neuronas-min_neuronas+1)        
%         R2_medio(i) = 0;
%         for j = 1:k_max
%             R2_medio(i) = R2_medio(i)+ matriz_R2(i,j+1);
%         end
%         R2_medio(i) = R2_medio(i)/k_max;
%     end
%     R2_medio=R2_medio'; 
%     
%     for i = 1:(max_neuronas-min_neuronas+1)        
%         MSE_medio(i) = 0;
%         for j = 1:k_max
%             MSE_medio(i) = MSE_medio(i)+ matriz_MSE(i,j+1);
%         end
%         MSE_medio(i) = MSE_medio(i)/k_max;
%     end
%     MSE_medio=MSE_medio';
%     
%     [M,I] = min(MSE_medio);
%     NUM_neuronas=numero_neuronas(I);