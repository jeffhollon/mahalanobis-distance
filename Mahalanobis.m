function [ D, M, C, Z ] = Mahalanobis( Data )
%MAHALANOBIS Computes the Mahalnobis distance for a dataset
%Data should be in column order.  Equal data sizes per col.

    C = inv(cov(Data));
    
    n = size(Data,1);
    
    M = mean(Data);
    
    for i=1:n
        
        T = Data(i,:) - M;
        
        D2(i) = T * C * T';
        
    end
    
    D = sqrt(D2);
    
    m = size(Data,2);
    
    A = [min(Data(:,1)), max(Data(:,1)),min(Data(:,2)), max(Data(:,2)) ];  %size of data axes 
        
        if m==1
            figure
            scatter(Data(:,1),D,'filled','CData',D);c=colorbar;
            xlabel('x');ylabel('Standard Deviations');
            ylabel(c,'Standard Deviations')
            grid on
        end
        if m==2
            figure
            scatter(Data(:,1),Data(:,2),'filled','CData',D);c=colorbar;
            xlabel('x');ylabel('y');
            ylabel(c,'Standard Deviations')
            grid on
            axis=A;
        end
        if m==3
            figure
            scatter3(Data(:,1),Data(:,2),Data(:,3),'filled','CData',D);c=colorbar;
            xlabel('x');ylabel('y');zlabel('z');
            ylabel(c,'Standard Deviations')
            grid on
        end
  
        
    %get the ellipse plot
        if m==2
            figure
            
           
            X = linspace(A(1),A(2));
            Y = linspace(A(3),A(4));
            
            for i=1:max(size(X))
                for j=1:max(size(Y))
                    Grid(i,j) = MahalanobisTest([X(i) Y(j)],M,C); 
                end
            end
            
            tol=0.05;
            Loc1 = find( abs(Grid-1) < tol )
            Loc2 = find( abs(Grid-2) < tol )
            Loc3 = find( abs(Grid-3) < tol )
            Loc4 = find( abs(Grid-4) < tol )

            GridTemp = zeros(size(Grid));

            GridTemp(Loc1) = 1;
            GridTemp(Loc2) = 2;
            GridTemp(Loc3) = 3;
            GridTemp(Loc4) = 4;

            Grid = GridTemp;

            surf(X,Y,Grid);c=colorbar;axis=A;
            xlabel('x');ylabel('y');
            ylabel(c,'Standard Deviations')
            grid on
            axis=A;
            
%Get just the ellipses
            count = 1;
            for i=1:max(size(X))
                for j=1:max(size(Y))
                    if Grid(i,j) > 0
                        Z(count,:) = [ X(i) Y(j) Grid(i,j) ];
                        count = count + 1;
                    end
                end
            end

            
            figure
                scatter3(Data(:,1),Data(:,2),D,'.');
            hold on
                scatter3(Z(:,1),Z(:,2),Z(:,3),'o');
            hold off
            xlabel('x');ylabel('y');
            grid on
            axis=A;

        end
        
        if m~=2
            Z=[];
        end

end