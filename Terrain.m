classdef Terrain
    %TERRAIN Summary of this class goes here
    %   This class will handle and streamline the process of 
    
    properties
        filename
        latlim
        lonlim
        lat
        lon
        Z
        header
        profile
        OrthoImage
        curr_cam_loc
        curr_cam_tar
    end
    
    methods
        function obj = Terrain(filename)
            %%Load in the data from the 7.5deg DEM file
            [obj.lat,obj.lon,obj.Z,obj.header,obj.profile] = usgs24kdem(filename);
            obj.Z(obj.Z==0) = -1;
            obj.latlim = [min(obj.lat(:)) max(obj.lat(:))];
            obj.lonlim = [min(obj.lon(:)) max(obj.lon(:))];
            %% This is going to be another perspective of the elevation data
            numberOfAttempts = 5;
            attempt = 0;
            info = [];
            serverURL = 'http://basemap.nationalmap.gov/ArcGIS/services/USGSImageryOnly/MapServer/WMSServer?';
            while(isempty(info))
                try
                    info = wmsinfo(serverURL);
                    orthoLayer = info.Layer(1);
                catch e 

                    attempt = attempt + 1;
                    if attempt > numberOfAttempts
                        throw(e);
                    else
                        fprintf('Attempting to connect to server:\n"%s"\n', serverURL)
                    end        
                end
            end
            imageLength = 2048;
            %After this line we should have received the image from the WMS
            [obj.OrthoImage,R] = wmsread(orthoLayer,'Latlim',obj.latlim, ...
                                       'Lonlim',obj.lonlim, ...
                                       'ImageHeight',imageLength, ...
                                       'ImageWidth',imageLength);
            x = obj.latlim(1);
            y = obj.lonlim(2);
            z = max(max(obj.Z));
            obj.curr_cam_loc = [x,y,z];
            obj.curr_cam_tar = [mean(obj.latlim) , mean(obj.lonlim), z];
            %Though this function processes and get all the data necessary
            %for create and displaying the terrain, we dont actually
            %display it yet
        end
        %%get_cam
        %This function will return the current camera_position and target
        %This is mostly used for drone object initialization
        function [camp, camt] = get_cam(obj)
            camp = obj.curr_cam_loc; 
            camt = obj.curr_cam_tar;
        end
        %This function will take the current figure, and display the
        %surface of the terrain in 3-space
        function Display(obj)
            %Get the current window and maximize it
            f= gcf;
            f.WindowState = 'maximized';
            
            %Initialize the space using usa map
            usamap(obj.latlim, obj.lonlim);
            %Use the vectors gotten from the DEM file and the orthoimage to
            %project the terrain with the 
            geoshow(obj.lat, obj.lon, obj.Z, 'DisplayType','surface','CData', obj.OrthoImage, 'Clipping', 'off');
            zoom(2)
            %Some camera manipulation so that we can display it in a
            %far-out perspective
            daspectm('m',1);
            x = obj.latlim(1);
            y = obj.lonlim(2);
            z = max(max(obj.Z));
            camproj('orthographic')
            camposm(x , y ,z+1000);
            camtargm(mean(obj.latlim) , mean(obj.lonlim), z);
            %Turn off the labels and axis so they dont appear on the
            %surface
            plabel off
            mlabel off
            axis off
        end
        
        function Line(obj)
            obj.Display();
            [xm,ym,z]=camposm(min(obj.latlim),min(obj.lonlim),10000)
            [xM,yM,z]=camposm(max(obj.latlim),max(obj.lonlim),10000);
            l=linspace(xm,xM,100);L=linspace(ym,yM,100);zoom(1.25);
                for i=1:100
            	camva(10)
                campos([l(i) L(i) 9000]) % Here the camera position goes down the x and y components, creating a diagonal line
                camtarget([l(i) L(i) max(max(obj.Z))]) % The camera target takes the same path as the camera position
                drawnow
                pause(.05)
                end
        end
        function LookCircle(obj)            
            obj.Display();
            [xm,ym,z]=camposm(min(obj.latlim),min(obj.lonlim),10000)
            [xM,yM,z]=camposm(max(obj.latlim),max(obj.lonlim),10000);
            l=linspace(xm,xM,50);L=linspace(ym,yM,50);zoom(1.5)
            camproj('perspective');
           k=0;
                for i=1:99
                    k=k+1
                    camva(90)
                    campos([mean(l) mean(L) max(max(obj.Z))+100]) %This is to set the camera position to the center of the terrain data, but can be changed to any location
                    if k<50
                    camtarget([l(1) L(k) max(max(obj.Z))]) % This is to have the camera target go down the y axis
                    end
                    if k>=50
                    camtarget([l(k-49) L(50) max(max(obj.Z))]) % Now the camera target goes down the x axis
                    end
                    pause(0.1)
                    drawnow
                end
                k=0;
                for i=1:99
                    k=k+1
                    if k<50
                    camtarget([l(50) L(50-k) max(max(obj.Z))]) % Here the camera target goes back down the y axis
                    end
                    if k>=50
                    camtarget([l(100-k) L(1) max(max(obj.Z))]) % And finally the camera target goes back down the x axis to the starting target
                    end
                    pause(.1)
                    drawnow
                end
        end
        function Circle(obj)
            obj.Display();
            [xm,ym,z]=camposm(min(obj.latlim),min(obj.lonlim),10000)
            [xM,yM,z]=camposm(max(obj.latlim),max(obj.lonlim),10000);
            l=linspace(xm,xM,50);L=linspace(ym,yM,50);camproj('perspective');
            for i=linspace(0,2*pi,30)
                camva(45)
                % This is to move the camera position in a circle using the cartesian coordinates
                campos([mean(l)+cos(i) mean(L)+sin(i) max(max(obj.Z))+1000]) 
                 % This is to set the camera target to the center of the terrain, which is also where the camera position is centered around
                camtarget([mean(l) mean(L) max(max(obj.Z))])
                pause(.5)
                drawnow
            end
        end
    end
end

