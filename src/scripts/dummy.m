%% Dummy
% Script Just to test different spiral geometries (to make figures)

addpath('../functions')
figure();
hold on;
%All dimensions are in [m]
%A = round_spiral(10, 5, 0.5, 0, 1000, 0, 0, 0, 0, 0, 0, true);
%A = solenoid_spiral(10,5,1,3*pi/2,0,1000,0,0,0,0,0,0,true);
%A = helix_spiral(10,5,1,0,1000,0,0,0,0,0,0, true);
%A = square_spiral(10,10,10,0.5,0,0,0,0,0,0, true);
%A=circular_planar_inductor(20,20,10,1,0,500,1,0,0,0,0,0,0,true);
A=rectangular_planar_inductor(4,10e-3,20e-3,5e-3,5e-3,1e-3,1.8e-3,0,0,0,0,0,0,true);

