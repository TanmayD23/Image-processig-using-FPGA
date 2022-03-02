I=imread("Raw Image.jpeg");
[R,G,B]=imsplit(I);
[ra,rh,rv,rd] = haart2(R,1);
[ga,gh,gv,gd] = haart2(G,1);
[ba,bh,bv,bd] = haart2(B,1);

rmax = max(max(R)); %max value of red component
gmax = max(max(G)); %max value of green component
bmax = max(max(B)); %max value blue component

rmin = min(min(R)); %min value of red component
gmin = min(min(G)); %min value of green component
bmin = min(min(B)); %min value of blue component


R = (R-0)*((255-0)/(206-0)); %contrast enhancement of red component
G = (G-54)*((255-54)/(255-54)); %contrast enhancement of green component
B = (B-54)*((255-54)/(255-54)); %contrast enhancement of blue component

ravg = mean(R,"all"); % avg value of the red component
gavg = mean(G,"all"); % avg value of the green component
bavg = mean(B,"all"); % avg value of the blue component

i = rgb2ycbcr(I);% converting rgb into Y, Cb, Cr components
Y = i(:,:,1); % isolating the Y component
ymax = max(max(Y)); % max value of Y
ymx = ymax;
yavg = mean(Y,"all"); % avg value of Y


Rm = 222/206; % maximum white scale factor for red component
Gm = 222/255; % maximum white scale factor for green component 
Bm = 222/255; % maximum white scale factor for blue component

Ra = yavg/ravg; % mean white scale factor for red component
Ga = yavg/gavg; % mean white scale factor for green component
Ba = yavg/bavg; % mean white scale factor fro blue component

if (Ra>Ga) && (Ra>Ba) % calculating colour casting factor
    CCF = 0.5*((Gm/Rm)+(Bm/Rm));
elseif (Ga>Ra) && (Ga>Ba)
    CCF = 0.5*((Rm/Gm)+(Bm/Gm));
elseif (Ba>Ra) && (Ba>Ga)
    CCF = 0.5*((Rm/Bm)+(Gm/Bm));
end

R0 = CCF*Ra*Rm; % adjusting the image pixels
ra = R0*ra;
G0 = CCF*Ga*Gm; % adjusting the image pixels
ga = G0*ga;
B0 = CCF*Ba*Bm; % adjusting the image pixels
ba = B0*ba;

R_new = ihaart2(ra,rh,rv,rd);
G_new = ihaart2(ga,gh,gv,gd);
B_new = ihaart2(ba,bh,bv,bd);

final_image = cat(3,R_new,G_new,B_new);
imshow(final_image);









