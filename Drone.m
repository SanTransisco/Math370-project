classdef Drone
    %DRONE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Current_Location
        Current_Target
        Drone_Path
        Target_Path
    end
    
    methods
        function obj = Drone(camp, camt)
            obj.Current_Location = camp;
            obj.Current_Target = camt;
            obj.Drone_Path = [];
            obj.Target_Path = [];
        end
        
        function view(obj)
            ax = gca;
            ax.CameraViewAngle = 15;
            zoom(2.5)
            view()
        end
        
        function obj = fly_to(obj,dest,speed)
            X1 = obj.Current_Location;
            X2 = dest;
            [m,b] = get_line(X1,X2);
            T = linspace(0,1,100);
            for n = 1:length(T)
                V = m*T(n) + b;
                camposm(V(1),V(2),V(3));
                view();
                pause(1/speed);
                
            end
            obj.Current_Location = X2;
        end
        
        function obj = change_target(obj,dest,speed)
            X1 = obj.Current_Target;
            X2 = dest;
            [m,b] = get_line(X1,X2);
            T = linspace(0,1,100);
            for n = 1:length(T)
                V = m*T(n) + b;
                camtargm(V(1),V(2),V(3));
                view();
                pause(1/speed);
            end
            obj.Current_Target = X2;
        end
        
        function V = fly_vector(obj,dest)
            X1 = obj.Current_Location;
            X2 = dest;
            [m,b] = get_line(X1,X2);
            T = linspace(0,1,100);
            for n = 1:length(T)
                V(n,:) = m*T(n) + b;
            end
        end
        
        function V = target_vector(obj,dest)
            X1 = obj.Current_Target;
            X2 = dest;
            [m,b] = get_line(X1,X2);
            T = linspace(0,1,100);
            for n = 1:length(T)
                V(n,:) = m*T(n) + b;
            end
        end
        
        function obj = Fly_Drone(obj,d_dest, t_dest, t_speed)
            T = linspace(0,1,100);
            FV = obj.fly_vector(d_dest)
            TV = obj.target_vector(t_dest)
            for n = 1:length(T)
                obj.view();
                camposm(FV(n,1),FV(n,2),FV(n,3));
                camtarm(TV(n,1),TV(n,2),TV(n,3));
                pause(1/t_speed);
            end
            obj.Current_Location = FV(length(T),:)
            obj.Current_Target = TV(length(T),:)
        end     

    end
end

function [M,B] = get_linear_approx(X)
    M = zeroes(length(X)-1);
    B = M;
    for i = 1:length(X)-1
       [m,b] = get_line(X(i), X(i-1));
       M(i) = m;
       B(i) = b;
   end
end

function mag = magnitude(X)
   mag = sqrt(X.*X);
end

function [m,b] = get_line(x1,x2)
   m = x2-x1;
   b = x1;
end

