% PA 4 - Laplace Equation Iterations 
% Jinseng Vanderkloot 1010131534

clc;
clear all;
close all;

%Inital Simlation constants 
%Heat flow along x axis 
nx = 100; %long width 
ny = 50; %short length 
NumIt = 3000; %number itterations
V = zeros(nx,ny); %Matrix 

%Thermal/Charged wall 
tWall = 2; %(2) both (1) charged right side, (0) charge left side
%Top and Bottom Boundary Condition 
BC=0; %(0) heat sink, (1) insulating 


%Boundary Conditions 
if tWall == 1
    left = 0; 
    right = 1;
elseif tWall == 2
    left = 1; 
    right = 1;    
else 
    left = 1; 
    right = 0;
end 

for it = 1:NumIt
    for m = 1:nx
        for n = 1:ny 

            %Different cases for each node 
            if n==1 %left wall
                V(m,n)= left;
            elseif n == ny %right wall 
                V(m,n)= right;
            elseif BC==1 && m==1 %bottom
                V(m,n)=(V(m+1,n)+V(m,n+1)+V(m,n-1))/3;
            elseif BC==1 && m==nx %top
                V(m,n)=(V(m-1,n)+V(m,n+1)+V(m,n-1))/3;
            elseif m == 1 %bottom
                V(m,n)=0;
            elseif m == nx %top
                V(m,n)=0;

            %need Elseif to avoid boundary and since "Index must not exceed
            %50" in the loop 
            elseif (n>1 && n<ny && m > 1 && m<nx)
                V(m,n)=(V(m-1,n)+V(m+1,n)+V(m,n+1)+V(m,n-1))/4;
            end 
        end 
    end 
    %The expected solution is that it finds an equilibirum where the
    %change from node to node becomes insignificant. Use Figure instead of
    %subplots to see them itterate within the loop.

    %Plot
    figure(1)
    if mod(it,50) == 0
        surf(V);
    end

    %get vectors of each node (gradient and change to show increasing)
    figure(2)
    %imboxfilt(V,3); need tool box
    if mod(it,50) == 0
        [Ex,Ey] = gradient(V);
        quiver(-Ex,-Ey,1)
    end
    pause(0.01)
end 


    
