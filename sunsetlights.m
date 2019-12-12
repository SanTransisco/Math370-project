% Trenton Jansen
% This function takes an input of a light and changes the color of the
% light based on the elevation angle of the light.
% The color is black when the elevation is negative, at elevation degree 
% = 0 it will be the color listed in the variables redsunset, yellowsunset,
% bluesunset and from elevation listed in the variable elevation degree 
% of sunsetanglechange or greater the color will change to the color listed
% in the variables redsun, yellowsun, bluesun. For the angles between 0 and 
% sunsetanglechange the color will change into the color between those two
% listed colors based on the degree.  For example, 1/5 of sunsetanglechange
% the color will be the color 1/5 between sunset and sun.
function sunsetlights(h)
% Variables
% This is the variable RGB of sunset 
redsunset=253;
yellowsunset=94;
bluesunset=83;
% This is the variable RGB of the sun above head
redsun=253;
yellowsun=184;
bluesun=19;
% This is the variable degree in which the color will stay at the sun above 
% head color
sunsetanglechange=20;
% function
% This part finds the degree of elevation of the light given in input
p=h.Position;
r=sqrt(p(1)^2+p(2)^2);
angle=atan(p(3)/r);
sunsetanglechange=sunsetanglechange*pi/180
% This is the part that changes the color based on the light's 
% degree of elevation and the variables listed above.
% [0 0 0] when angle <0, sunset at angle = 0, slowly to sun at angle =
% sunsetanglechange, stay at sun with angle > sunsetanglechange.
red=(angle>=0)*(((redsun-redsunset)>=0)*(min(redsunset+(redsun-redsunset)*angle/(sunsetanglechange),redsun))+(redsun-redsunset<0)*(max(redsunset+(redsun-redsunset)*angle/(sunsetanglechange),redsun)));
yellow=(angle>=0)*(((yellowsun-yellowsunset)>=0)*(min(yellowsunset+(yellowsun-yellowsunset)*angle/(sunsetanglechange),yellowsun))+(yellowsun-yellowsunset<0)*(max(yellowsunset+(yellowsun-yellowsunset)*angle/(sunsetanglechange),yellowsun)));
blue=(angle>=0)*(((bluesun-bluesunset)>=0)*(min(bluesunset+(bluesun-bluesunset)*angle/(sunsetanglechange),bluesun))+(bluesun-bluesunset<0)*(max(bluesunset+(bluesun-bluesunset)*angle/(sunsetanglechange),bluesun)));
h.Color=[red/255 yellow/255 blue/255 ]
end