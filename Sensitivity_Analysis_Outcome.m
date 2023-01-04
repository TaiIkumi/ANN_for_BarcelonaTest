function []=Sensitivity_Analysis_Outcome(InputsANN,TargetsANN,NUM_neuronas)

%% Cargamos el archivo con todos los datos y lo guardamos como la tabla "EnsayosBarcelona_todos"
%EnsayosBarcelona_todos=readtable('DatosEnsayosBarcelona.csv','ReadVariableNames',false);
AnalisisParam=readtable('Parametric Analysis.xlsx');
EnsayosBarcelona_todos.n_Probeta=[]; %Elimina la columna de num de probeta
[n,~]=size(EnsayosBarcelona_todos);


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
        
 % 2. EVALUAMOS LA CONFIGURACIÓN   

        targets_NO_tipo_fibra = RedNeuronal_f2m_NO_tipo_fibra(Inputs_NO_tipo_fibra);     
        
% Gráficos análisis sensibilidad
   
    figure
    hold on
    c = categorical({'Tipo fibra','Tipo probeta','H probeta','fck','L fibra','D fibra','Forma fibra','Extremo fibra','Cuantía fibra'});
    models = [coeficiente_R2_NO_tipo_fibra coeficiente_R2_NO_tipo_probeta coeficiente_R2_NO_altura_probeta coeficiente_R2_NO_fck coeficiente_R2_NO_longitud_fibra coeficiente_R2_NO_diametro_fibra coeficiente_R2_NO_forma_fibra coeficiente_R2_NO_tipo_extremo coeficiente_R2_NO_cuantia_fibra];
    bar(c,models)
    title('Influencia variable en R2')
    ylabel('R2')
    
end