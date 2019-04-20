%% Optimization of Inductors for different prohibition sizes
% Iterates different turns and prohibition zones for the coils

addpath('../functions')
N1=3*4;
r1=5e-3; d1=2*0.5e-3; h=1.6e-3;

%Create the coil structs compatible with FastHenry2
freq=6.79e6;			%Frequency
w1=1e-3; h1=0.0347e-3; %Conductor dimensions 1OZ
rh=2; rw=2; 		%Relation between discretization filaments
mu0=4*pi*1e-7; 		%Permeability
sigma=5.96e7; 		%Conductivity
delta=sqrt(2*(1/5.8e7)/(2*pi*freq*mu0)); %Skin effect

figure();
range=N1;
f=waitbar(0,'Initialization');
i=1;
r1_len=length(5e-3:1e-3:20e-3);
for r1=5e-3:1e-3:20e-3	
	j=1;
	for N1=1:1:r1/(d1)
		text = sprintf('N1: %i', N1);
		waitbar(i/r1_len,f,text);
		clf('reset') 
		X = rectangular_planar_inductor(N1,2*r1,2*r1,0,0,d1,h,0,0, 0,0,0,0,true);
		[nhinc,nwinc]=optimize_discr(w1,h1,rh,rw,delta);
		primary=generate_coil('primary',X,sigma,w1,h1,nhinc,nwinc,rh,rw);
		coils={primary};
		[L,R,Frequency]=fasthenry_runner(fasthenry_creator('SurpriseMotherFucker',coils,freq),'',false);
		Rs=squeeze((R(1,:,:)));
		Ls=squeeze((L(1,:,:)));
		R1(i,j)=Rs(1,1);
		L1(i,j)=Ls(1,1);
		Q1(i,j)=2*pi*freq*Ls(1,1)/Rs(1,1);
		j=j+1;
	end
	i=i+1;
end
waitbar(1,f,'Simulation ended');
save('../../data/opt_A0_ind.mat')%Save all the Variables in the Workspace

delete(f)

