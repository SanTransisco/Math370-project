classdef Drone
    %DRONE 
    %This object will essentially be the interface for the drone camera
    %controls
    %In order to simulate flight we made linear approximations and iterated
    %Through the linear approxmiations so that flight looks smooth, and
    %camera pans looks like they are simulating a real camera.
    
    properties
        Current_Location
        Current_Target
        Drone_Path
        Target_Path
    end
    
    methods
        function obj = Drone(camp, camt)
            %Used to store and save the current camera target and camera
            %position.
            obj.Current_Location = camp;
            obj.Current_Target = camt;
            %These following two attributes are not used.
            %These were intended for use for when we wanted to plot out 
            %A course thought the terrain and store it all in one vector.
            obj.Drone_Path = [];
            obj.Target_Path = [];
        end
        %Change the Camera settings likethe viewing angle so that it looks
        %and behaves like we are looking from the persepctive of the drone
        function view(obj)
            ax = gca;
            ax.CameraViewAngle = 15;
            zoom(2.5)
            view()
        end
        
        %Use the linear approximation function to create a linear equation
        %on which we will iterate over to create the illussion of movement
        %obj - the object on which we are trying to fly
        %dest- a vector in R3 that will represent the destination that we
        %want to fly to
        %speed - a scalar that will determine the speed of the drone.
        %The higher it is the faster it is.
        %The lower it is the slower it will travel
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
        %Use the linear approximation function to create a linear equation
        %on which we will iterate over to create the illussion of camera
        %paning.
        %obj - the object on which we are trying to fly
        %dest- a vector in R3 that will represent the destination that we
        %want to eventually point the camera lens towards
        %speed - a scalar that will determine the speed of the drone.
        %The higher it is the faster it is.
        %The lower it is the slower it will travel
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
        %Use the linear approximation function to create a linear equation
        %on which we will iterate over to create the illussion of movement
        %obj - the object on which we are trying to fly
        %dest- a vector in R3 that will represent the destination that we
        %want to fly to
        %This function will return a vector that will represent the
        %locations the drone will be at. This was part of our attempted solution to
        %try to get the drone to fly and pan the camera at the same time
        function V = fly_vector(obj,dest)
            X1 = obj.Current_Location;
            X2 = dest;
            [m,b] = get_line(X1,X2);
            T = linspace(0,1,100);
            for n = 1:length(T)
                V(n,:) = m*T(n) + b;
            end
        end
        %Use the linear approximation function to create a linear equation
        %on which we will iterate over to create the illussion of movement
        %obj - the object on which we are trying to fly
        %dest- a vector in R3 that will represent the destination that we
        %want to point the camera towards
        %This function will return a vector that will represent the
        %locations the drone will be pointing towardsat. 
        %This was part of our attempted solution to
        %try to get the drone to fly and pan the camera at the same time
        function V = target_vector(obj,dest)
            X1 = obj.Current_Target;
            X2 = dest;
            [m,b] = get_line(X1,X2);
            T = linspace(0,1,100);
            for n = 1:length(T)
                V(n,:) = m*T(n) + b;
            end
        end
        
        %
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
%Used to get MANY linear approximations and store the coefficients/vectors
%into another vector (making it a matrix) of values that represent the many
%linear approximations.
%Not used, but if we had more time we can try to use it to plot a continous
%path
function [M,B] = get_linear_approx(X)
    M = zeroes(length(X)-1);
    B = M;
    for i = 1:length(X)-1
       [m,b] = get_line(X(i), X(i-1));
       M(i) = m;
       B(i) = b;
   end
end
%Our Linear approximation function.
function [m,b] = get_line(x1,x2)
   m = x2-x1;
   b = x1;
end

