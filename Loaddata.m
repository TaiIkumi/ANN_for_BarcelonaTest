function [InputsANN,TargetsANN,n,numero_columnas_inputs,numero_columnas_targets] = Loaddata()

%% Macro para cargar archivo .CSV con todos los datos de los ensayos Barcelona y generar inputs y targets


%% Cargamos el archivo con todos los datos y lo guardamos como la tabla "EnsayosBarcelona_todos"
%EnsayosBarcelona_todos=readtable('DatosEnsayosBarcelona.csv','ReadVariableNames',false);
EnsayosBarcelona_todos=readtable('TODAS_SIN_PVA.csv');
EnsayosBarcelona_todos.n_Probeta=[]; %Elimina la columna de num de probeta
[n,~]=size(EnsayosBarcelona_todos);


%% Creamos la matriz TARGETS correspondiente a los resultados de tensiones f_2mm (MPa),f_3mm (MPa),f_4mm (MPa) y f_4mm/f_2mm

TargetsANN = EnsayosBarcelona_todos(:,[10 11 12]);
[~,numero_columnas_targets]=size(TargetsANN);
TargetsANN = table2array(TargetsANN)';
    
%% Creamos la matriz INPUTS 

  % CONVERTIMOS LOS "STRINGS" DE CLASES A VECTORES 
    
        InputsANN = EnsayosBarcelona_todos(:,[1:9]);     
        InputsANN.TipoFibra = categorical(InputsANN.TipoFibra);
        TipoFibra = dummyvar(InputsANN.TipoFibra);
        TipoFibra = array2table(TipoFibra);
        InputsANN=[InputsANN,TipoFibra];
        InputsANN.TipoFibra=[];

        InputsANN.TipoProbeta = categorical(InputsANN.TipoProbeta);
        TipoProbeta = dummyvar(InputsANN.TipoProbeta);
        TipoProbeta = array2table(TipoProbeta);
        InputsANN=[InputsANN,TipoProbeta];
        InputsANN.TipoProbeta=[];

        InputsANN.HProbeta_mm_ = categorical(InputsANN.HProbeta_mm_);
        HProbeta_mm_ = dummyvar(InputsANN.HProbeta_mm_);
        HProbeta_mm_ = array2table(HProbeta_mm_);
        InputsANN=[InputsANN,HProbeta_mm_];
        InputsANN.HProbeta_mm_=[];

        InputsANN.FormaFibra = categorical(InputsANN.FormaFibra);
        FormaFibra = dummyvar(InputsANN.FormaFibra);
        FormaFibra = array2table(FormaFibra);
        InputsANN=[InputsANN,FormaFibra];
        InputsANN.FormaFibra=[];

%         InputsANN.Extremos = categorical(InputsANN.Extremos);
%         Extremos = dummyvar(InputsANN.Extremos);
%         Extremos = array2table(Extremos);
%         InputsANN=[InputsANN,Extremos];
%         InputsANN.Extremos=[];
        
        [~,numero_columnas_inputs]=size(InputsANN);
        InputsANN = table2array(InputsANN)';

    
    
end
    