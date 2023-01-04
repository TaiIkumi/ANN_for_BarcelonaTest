%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%# 
%#                              Workflow for Neural Network Design                           %%
%#   https://es.mathworks.com/help/deeplearning/ug/workflow-for-neural-network-design.html   %%
%#
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
 
% https://es.mathworks.com/help/deeplearning/ug/choose-a-multilayer-neural-network-training-function.html
% https://es.mathworks.com/help/deeplearning/ref/fitnet.html

close all
clc
clear all

%% PANEL DE CONTROL
    
    filename = 'Todas_sin_PVA.mat';
    Cargar_Datos=1;                     % [1,0]: Activar/Desactivar la carga y pretratamiento de datos
    CrossValidation=1;        % [1,0]: Activar/Desactivar el análisis para determinar el nº de neuronas de la ANN
    
        k_max = 100;                       % Número de iteraciones por cada configuración (REPEATED RANDOM SUB-SAMPLING CROSS VALIDATION)
        
    Graf_CrossValidation=0;   % [1,0]: Activar/Desactivar la generación de gráficos referentes a la determinación del nº de neuronas
    
        Grafs_R2_MSE_medio=0;           % [1,0]: Activar/Desactivar gráficos medios de R2 y MSE 
        Grafs_R2_MSE_todos=0;           % [1,0]: Activar/Desactivar gráficos específicos de R2 y MSE 
                
    ANN_Final=0;                        % [1,0]: Activar/Desactivar el análisis ANN con el nº de neuronas más óptimo
    
        d=511;
        NUM_neuronas_capa_1=15;                % Solo definir en caso de no tener activado el Determinacion_Estruct_ANN
        NUM_neuronas_capa_2=15;                % Solo definir en caso de no tener activado el Determinacion_Estruct_ANN
    
    Analisis_Sensibilidad=0;            % [1,0]: Activar/Desactivar el análisis de sensibilidad de los INPUTS  
    Analisis_Param=0;                   % [1,0]: Activar/Desactivar el análisis de los parametros de los INPUTS 
    
%% PRETRATAMIENTO BASE DE DATOS 
       
        if Cargar_Datos==1 
            [InputsANN,TargetsANN,numero_probetas,numero_columnas_inputs,numero_columnas_targets] = Loaddata();
        else
        end
        
%         if Normalizar_Datos==1
%             [InputsANN] = Normalizacion_INPUTS(InputsANN,numero_probetas);
%         
%             [TargetsANN] = Normalizacion_OUTPUTS(TargetsANN,numero_probetas);
%         else
%         end  
  
%% DETERMINACIÓN DE LA ESTRUCTURA DE LA RED NEURONAL (Nº DE NEURONAS)
    
if CrossValidation==1      
    [matriz_R2_mean,matriz_R2_f2,matriz_R2_f3,matriz_R2_f4,matriz_MSE] = Struct_ANN(k_max,InputsANN,TargetsANN,numero_probetas,numero_columnas_inputs,numero_columnas_targets);            
else
end

%% DIBUJAMOS MSE Y R2 EN FUNCIÓN DEL NÚMERO DE NEURONAS

 if Graf_CrossValidation==1
     if Grafs_R2_MSE_todos==1        
         Struct_ANN_Graph_1(matriz_R2,numero_neuronas,matriz_MSE,k_max);        
     else
     end
     
     if Grafs_R2_MSE_medio==1        
          Struct_ANN_Graph_2(matriz_R2,numero_neuronas,R2_medio,MSE_medio);        
     else
     end
 else 
 end   
 
%% ENTRENAMIENTO ANN_Final

if ANN_Final==1                
    [coeficiente_R2_final,coeficiente_R2_f2_final,coeficiente_R2_f3_final,coeficiente_R2_f4_final]=ANN(InputsANN,TargetsANN,NUM_neuronas_capa_1,NUM_neuronas_capa_2,d); 
else
end

%% ANÁLISIS DE SENSIBILIDAD DE CADA VARIABLE 
%# VAMOS MIDIENDO COMO INFLUYE EL CONSIDERAR CADA VARIABLE EN EL R2
%# Más info: https://stats.stackexchange.com/questions/409105/sensitivity-analysis-with-categorical-predictive-variables-in-r

if Analisis_Sensibilidad==1     
    Sensitivity_Analysis(InputsANN,TargetsANN,NUM_neuronas_capa_1,NUM_neuronas_capa_2); 
else
end

if Analisis_Param==1    
    AnalisisParam=readtable('Parametric Analysis.xlsx','Sheet','Sheet2');
    AnalisisParam.Var1=[]; %Elimina la columna de num de probeta
    AnalisisParam.Var2=[]; %Elimina la columna de num de probeta
    [n,m]=size(AnalisisParam);
    AnalisisParam=table2array(AnalisisParam);
    
    load('RedNeuronal_final')
    Eval_AnalisisParam = RedNeuronal_final(AnalisisParam);  
    
else
end

save(filename)