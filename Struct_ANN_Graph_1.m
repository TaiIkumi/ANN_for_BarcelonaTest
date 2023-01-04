function  []=Struct_ANN_Graph_1(matriz_R2,numero_neuronas,matriz_MSE,k_max)
% R2 para cada iteraci�n
        figure
        hold on
        title('R2 en funci�n del n� neuronas para cada iteraci�n')
        xlabel('N� de neuronas')
        ylabel('R2')
        for i = 1:k_max
            plot(matriz_R2(:,1),matriz_R2(:,i+1),'-o')
        end
         set(gca, 'XTick', numero_neuronas)
        % MSE para cada iteraci�n
        figure
        hold on
        title('MSE en funci�n del n� neuronas para cada iteraci�n')
        xlabel('N� de neuronas')
        ylabel('MSE')
        for i = 1:k_max
            plot(matriz_MSE(:,1),matriz_MSE(:,i+1),'-o')
        end
         set(gca, 'XTick', numero_neuronas)
         
end