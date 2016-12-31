function [ D ] = MahalanobisTest( TestData, M, C )
%MAHALANOBIS Computes the Mahalnobis distance for a data versus a given M
%and C.

    T = TestData - M;
        
    D2 = T * C * T';
    
    D = sqrt(D2);
    
end