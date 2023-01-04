function []=Sensitivity_Analysis(InputsANN,TargetsANN,NUM_neuronas)

% 1. GENERAMOS DIFERENTES FICHEROS DE INPUTS QUITANDO VARIABLES

    % 1.1. Inputs sin tipo de fibra
        Inputs_NO_tipo_fibra = InputsANN;     
        for i = 1:2
            Inputs_NO_tipo_fibra(5,:)=[];
        end
        
    % 1.2. Inputs sin tipo de probeta
        Inputs_NO_tipo_probeta = InputsANN;     
        for i = 1:2
            Inputs_NO_tipo_probeta(7,:)=[];
        end
                
    % 1.3. Inputs sin altura de probeta
        Inputs_NO_altura_probeta = InputsANN;     
        for i = 1:2
            Inputs_NO_altura_probeta(9,:)=[];
        end
                
    % 1.4. Inputs sin fck
        Inputs_NO_fck = InputsANN;     
        Inputs_NO_fck(1,:)=[];
                
    % 1.5. Inputs sin longitud de fibra
        Inputs_NO_longitud_fibra = InputsANN;     
        Inputs_NO_longitud_fibra(2,:)=[];
                
    % 1.6. Inputs sin diametro de fibra
        Inputs_NO_diametro_fibra = InputsANN;     
        Inputs_NO_diametro_fibra(3,:)=[];
                
    % 1.7. Inputs sin forma de fibra
        Inputs_NO_forma_fibra = InputsANN;     
        for i = 1:5
            Inputs_NO_forma_fibra(11,:)=[];
        end
                
    % 1.8. Inputs sin tipo de extremo de fibra
        Inputs_NO_tipo_extremo = InputsANN;     
        for i = 1:3
            Inputs_NO_tipo_extremo(16,:)=[];
        end
                 
    % 1.9. Inputs sin cuantia de fibra
        Inputs_NO_cuantia_fibra = InputsANN;     
        Inputs_NO_cuantia_fibra(4,:)=[];       
        
 % 2. CALIBRAMOS LAS REDES NEURONALES CON LOS INPUTS MODIFICADOS
  
    % 2.0. Outputs    
        outputs = TargetsANN;
    
    % 2.1. Red neuronal con Inputs sin tipo de fibra
        rng(0) 
        RedNeuronal_f2m_NO_tipo_fibra = fitnet(NUM_neuronas,'trainbr');  %sintaxis: = fitnet(hiddenSizes,trainFcn)
        RedNeuronal_f2m_NO_tipo_fibra.layers{1}.transferFcn = 'tansig'; %'tansig' or 'logsig'
        RedNeuronal_f2m_NO_tipo_fibra.trainParam.epochs = 2000;   
        RedNeuronal_f2m_NO_tipo_fibra.trainParam.min_grad = 1e-10;         
        RedNeuronal_f2m_NO_tipo_fibra.divideFcn = 'dividerand';
        RedNeuronal_f2m_NO_tipo_fibra.divideParam.trainRatio = 0.999;
        RedNeuronal_f2m_NO_tipo_fibra.divideParam.valRatio = 0.0005;
        RedNeuronal_f2m_NO_tipo_fibra.divideParam.testRatio = 0.0005;            
        RedNeuronal_f2m_NO_tipo_fibra = train(RedNeuronal_f2m_NO_tipo_fibra,Inputs_NO_tipo_fibra,outputs);
        
        
    % 2.2. Red neuronal con Inputs sin tipo de probeta
        rng(0) 
        RedNeuronal_f2m_NO_tipo_probeta = fitnet(NUM_neuronas,'trainbr');  %sintaxis: = fitnet(hiddenSizes,trainFcn)
        RedNeuronal_f2m_NO_tipo_probeta.layers{1}.transferFcn = 'tansig'; %'tansig' or 'logsig'
        RedNeuronal_f2m_NO_tipo_probeta.trainParam.epochs = 2000;   
        RedNeuronal_f2m_NO_tipo_probeta.trainParam.min_grad = 1e-10;         
        RedNeuronal_f2m_NO_tipo_probeta.divideFcn = 'dividerand';
        RedNeuronal_f2m_NO_tipo_probeta.divideParam.trainRatio = 0.999;
        RedNeuronal_f2m_NO_tipo_probeta.divideParam.valRatio = 0.0005;
        RedNeuronal_f2m_NO_tipo_probeta.divideParam.testRatio = 0.0005;            
        RedNeuronal_f2m_NO_tipo_probeta = train(RedNeuronal_f2m_NO_tipo_probeta,Inputs_NO_tipo_probeta,outputs);
        
    % 2.3. Red neuronal con Inputs sin altura de probeta
        rng(0) 
        RedNeuronal_f2m_NO_altura_probeta = fitnet(NUM_neuronas,'trainbr');  %sintaxis: = fitnet(hiddenSizes,trainFcn)
        RedNeuronal_f2m_NO_altura_probeta.layers{1}.transferFcn = 'tansig'; %'tansig' or 'logsig'
        RedNeuronal_f2m_NO_altura_probeta.trainParam.epochs = 2000;   
        RedNeuronal_f2m_NO_altura_probeta.trainParam.min_grad = 1e-10;         
        RedNeuronal_f2m_NO_altura_probeta.divideFcn = 'dividerand';
        RedNeuronal_f2m_NO_altura_probeta.divideParam.trainRatio = 0.999;
        RedNeuronal_f2m_NO_altura_probeta.divideParam.valRatio = 0.0005;
        RedNeuronal_f2m_NO_altura_probeta.divideParam.testRatio = 0.0005;            
        RedNeuronal_f2m_NO_altura_probeta = train(RedNeuronal_f2m_NO_altura_probeta,Inputs_NO_altura_probeta,outputs);
               
    % 2.4. Red neuronal con Inputs sin fck
        rng(0) 
        RedNeuronal_f2m_NO_fck = fitnet(NUM_neuronas,'trainbr');  %sintaxis: = fitnet(hiddenSizes,trainFcn)
        RedNeuronal_f2m_NO_fck.layers{1}.transferFcn = 'tansig'; %'tansig' or 'logsig'
        RedNeuronal_f2m_NO_fck.trainParam.epochs = 2000;   
        RedNeuronal_f2m_NO_fck.trainParam.min_grad = 1e-10;         
        RedNeuronal_f2m_NO_fck.divideFcn = 'dividerand';
        RedNeuronal_f2m_NO_fck.divideParam.trainRatio = 0.999;
        RedNeuronal_f2m_NO_fck.divideParam.valRatio = 0.0005;
        RedNeuronal_f2m_NO_fck.divideParam.testRatio = 0.0005;            
        RedNeuronal_f2m_NO_fck = train(RedNeuronal_f2m_NO_fck,Inputs_NO_fck,outputs); 
                    
    % 2.5. Red neuronal con Inputs sin longitud de fibra
        rng(0) 
        RedNeuronal_f2m_NO_longitud_fibra = fitnet(NUM_neuronas,'trainbr');  %sintaxis: = fitnet(hiddenSizes,trainFcn)
        RedNeuronal_f2m_NO_longitud_fibra.layers{1}.transferFcn = 'tansig'; %'tansig' or 'logsig'
        RedNeuronal_f2m_NO_longitud_fibra.trainParam.epochs = 2000;   
        RedNeuronal_f2m_NO_longitud_fibra.trainParam.min_grad = 1e-10;         
        RedNeuronal_f2m_NO_longitud_fibra.divideFcn = 'dividerand';
        RedNeuronal_f2m_NO_longitud_fibra.divideParam.trainRatio = 0.999;
        RedNeuronal_f2m_NO_longitud_fibra.divideParam.valRatio = 0.0005;
        RedNeuronal_f2m_NO_longitud_fibra.divideParam.testRatio = 0.0005;            
        RedNeuronal_f2m_NO_longitud_fibra = train(RedNeuronal_f2m_NO_longitud_fibra,Inputs_NO_longitud_fibra,outputs);
                
    % 2.6. Red neuronal con Inputs sin diametro de fibra
        rng(0) 
        RedNeuronal_f2m_NO_diametro_fibra = fitnet(NUM_neuronas,'trainbr');  %sintaxis: = fitnet(hiddenSizes,trainFcn)
        RedNeuronal_f2m_NO_diametro_fibra.layers{1}.transferFcn = 'tansig'; %'tansig' or 'logsig'
        RedNeuronal_f2m_NO_diametro_fibra.trainParam.epochs = 2000;   
        RedNeuronal_f2m_NO_diametro_fibra.trainParam.min_grad = 1e-10;         
        RedNeuronal_f2m_NO_diametro_fibra.divideFcn = 'dividerand';
        RedNeuronal_f2m_NO_diametro_fibra.divideParam.trainRatio = 0.999;
        RedNeuronal_f2m_NO_diametro_fibra.divideParam.valRatio = 0.0005;
        RedNeuronal_f2m_NO_diametro_fibra.divideParam.testRatio = 0.0005;            
        RedNeuronal_f2m_NO_diametro_fibra = train(RedNeuronal_f2m_NO_diametro_fibra,Inputs_NO_diametro_fibra,outputs);
             
    % 2.7. Red neuronal con Inputs sin forma de fibra
        rng(0) 
        RedNeuronal_f2m_NO_forma_fibra = fitnet(NUM_neuronas,'trainbr');  %sintaxis: = fitnet(hiddenSizes,trainFcn)
        RedNeuronal_f2m_NO_forma_fibra.layers{1}.transferFcn = 'tansig'; %'tansig' or 'logsig'
        RedNeuronal_f2m_NO_forma_fibra.trainParam.epochs = 2000;   
        RedNeuronal_f2m_NO_forma_fibra.trainParam.min_grad = 1e-10;         
        RedNeuronal_f2m_NO_forma_fibra.divideFcn = 'dividerand';
        RedNeuronal_f2m_NO_forma_fibra.divideParam.trainRatio = 0.999;
        RedNeuronal_f2m_NO_forma_fibra.divideParam.valRatio = 0.0005;
        RedNeuronal_f2m_NO_forma_fibra.divideParam.testRatio = 0.0005;            
        RedNeuronal_f2m_NO_forma_fibra = train(RedNeuronal_f2m_NO_forma_fibra,Inputs_NO_forma_fibra,outputs);
	             
    % 2.8. Red neuronal con Inputs sin tipo de extremo de fibra
        rng(0) 
        RedNeuronal_f2m_NO_tipo_extremo = fitnet(NUM_neuronas,'trainbr');  %sintaxis: = fitnet(hiddenSizes,trainFcn)
        RedNeuronal_f2m_NO_tipo_extremo.layers{1}.transferFcn = 'tansig'; %'tansig' or 'logsig'
        RedNeuronal_f2m_NO_tipo_extremo.trainParam.epochs = 2000;   
        RedNeuronal_f2m_NO_tipo_extremo.trainParam.min_grad = 1e-10;         
        RedNeuronal_f2m_NO_tipo_extremo.divideFcn = 'dividerand';
        RedNeuronal_f2m_NO_tipo_extremo.divideParam.trainRatio = 0.999;
        RedNeuronal_f2m_NO_tipo_extremo.divideParam.valRatio = 0.0005;
        RedNeuronal_f2m_NO_tipo_extremo.divideParam.testRatio = 0.0005;            
        RedNeuronal_f2m_NO_tipo_extremo = train(RedNeuronal_f2m_NO_tipo_extremo,Inputs_NO_tipo_extremo,outputs);
                
    % 2.9. Red neuronal con Inputs sin cuantia de fibra
        rng(0) 
        RedNeuronal_f2m_NO_cuantia_fibra = fitnet(NUM_neuronas,'trainbr');  %sintaxis: = fitnet(hiddenSizes,trainFcn)
        RedNeuronal_f2m_NO_cuantia_fibra.layers{1}.transferFcn = 'tansig'; %'tansig' or 'logsig'
        RedNeuronal_f2m_NO_cuantia_fibra.trainParam.epochs = 2000;   
        RedNeuronal_f2m_NO_cuantia_fibra.trainParam.min_grad = 1e-10;         
        RedNeuronal_f2m_NO_cuantia_fibra.divideFcn = 'dividerand';
        RedNeuronal_f2m_NO_cuantia_fibra.divideParam.trainRatio = 0.999;
        RedNeuronal_f2m_NO_cuantia_fibra.divideParam.valRatio = 0.0005;
        RedNeuronal_f2m_NO_cuantia_fibra.divideParam.testRatio = 0.0005;            
        RedNeuronal_f2m_NO_cuantia_fibra = train( RedNeuronal_f2m_NO_cuantia_fibra,Inputs_NO_cuantia_fibra,outputs);      
        
% 3. CÁLCULO DE LOS R2 EN CADA CASO

    % 3.1. Inputs sin tipo de fibra
        targets_NO_tipo_fibra = RedNeuronal_f2m_NO_tipo_fibra(Inputs_NO_tipo_fibra);     
        coeficiente_R2_NO_tipo_fibra=funcion_coeficiente_R2(targets_NO_tipo_fibra,outputs);
        
    % 3.2. Inputs sin tipo de probeta
        targets_NO_tipo_probeta = RedNeuronal_f2m_NO_tipo_probeta(Inputs_NO_tipo_probeta);     
        coeficiente_R2_NO_tipo_probeta=funcion_coeficiente_R2(targets_NO_tipo_probeta,outputs);
                
    % 3.3. Inputs sin altura de probeta
        targets_NO_altura_probeta = RedNeuronal_f2m_NO_altura_probeta(Inputs_NO_altura_probeta);     
        coeficiente_R2_NO_altura_probeta=funcion_coeficiente_R2(targets_NO_altura_probeta,outputs);
                
    % 3.4. Inputs sin fck
        targets_NO_fck = RedNeuronal_f2m_NO_fck(Inputs_NO_fck);     
        coeficiente_R2_NO_fck=funcion_coeficiente_R2(targets_NO_fck,outputs);
                
    % 3.5. Inputs sin longitud de fibra
        targets_NO_longitud_fibra = RedNeuronal_f2m_NO_longitud_fibra(Inputs_NO_longitud_fibra);     
        coeficiente_R2_NO_longitud_fibra=funcion_coeficiente_R2(targets_NO_longitud_fibra,outputs);
                
    % 3.6. Inputs sin diametro de fibra
        targets_NO_diametro_fibra = RedNeuronal_f2m_NO_diametro_fibra(Inputs_NO_diametro_fibra);     
        coeficiente_R2_NO_diametro_fibra=funcion_coeficiente_R2(targets_NO_diametro_fibra,outputs);
                
    % 3.7. Inputs sin forma de fibra
        targets_NO_forma_fibra = RedNeuronal_f2m_NO_forma_fibra(Inputs_NO_forma_fibra);     
        coeficiente_R2_NO_forma_fibra=funcion_coeficiente_R2(targets_NO_forma_fibra,outputs);
                
    % 3.8. Inputs sin tipo de extremo de fibra
        targets_NO_tipo_extremo = RedNeuronal_f2m_NO_tipo_extremo(Inputs_NO_tipo_extremo);     
        coeficiente_R2_NO_tipo_extremo=funcion_coeficiente_R2(targets_NO_tipo_extremo,outputs);
                 
    % 3.9. Inputs sin cuantia de fibra
        targets_NO_cuantia_fibra = RedNeuronal_f2m_NO_cuantia_fibra(Inputs_NO_cuantia_fibra);     
        coeficiente_R2_NO_cuantia_fibra=funcion_coeficiente_R2(targets_NO_cuantia_fibra,outputs);    
   
% Gráficos análisis sensibilidad
   
    figure
    hold on
    c = categorical({'Tipo fibra','Tipo probeta','H probeta','fck','L fibra','D fibra','Forma fibra','Extremo fibra','Cuantía fibra'});
    models = [coeficiente_R2_NO_tipo_fibra coeficiente_R2_NO_tipo_probeta coeficiente_R2_NO_altura_probeta coeficiente_R2_NO_fck coeficiente_R2_NO_longitud_fibra coeficiente_R2_NO_diametro_fibra coeficiente_R2_NO_forma_fibra coeficiente_R2_NO_tipo_extremo coeficiente_R2_NO_cuantia_fibra];
    bar(c,models)
    title('Influencia variable en R2')
    ylabel('R2')
    
end