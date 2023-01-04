function  []=Struct_ANN_Graph_2(matriz_R2,numero_neuronas,R2_medio,MSE_medio)

 %R2 promedio
             
        figure
        hold on
        title('Gráfico de R2 medio en función del nº neuronas')
        xlabel('Nº de neuronas')
        ylabel('R2 medio')
        plot(matriz_R2(:,1),R2_medio,'-o')
        set(gca, 'XTick', numero_neuronas)
    
        %MSE promedio
           
        figure
        hold on
        title('Gráfico de MSE medio en función del nº neuronas')
        xlabel('Nº de neuronas')
        ylabel('MSE medio')
        plot(matriz_R2(:,1),MSE_medio,'-o')
        set(gca, 'XTick', numero_neuronas)
        
end