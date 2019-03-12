addpath('../functions')
i=1;
L1=zeros(1,16);
L2=zeros(1,16);
M=zeros(1,16);
R1=zeros(1,16);
R2=zeros(1,16);;
k=zeros(1,16);
for y=0:25:75
	for x=0:25:75
		X = square_spiral(15, 580,420,6.24, 0, 0, 0, 0, 0, 0);
		Y = square_spiral(17,280, 280,3.88, x, y, 150, 0, 0, 0);
		primary=generate_coil	('primary'	,X,5.8e4,0.1,0.1,2,2,2.0,2.0);
		secundary=generate_coil	('secundary',Y,5.8e4,0.1,0.1,2,2,2.0,2.0);
		coils={primary,secundary};
		freq=85e3; 
		[L,R,Frequency]=fasthenry_runner(fasthenry_creator('SurpriseMotherFucker',coils,freq),'',true);
		R=squeeze((R(1,:,:)));
		L=squeeze((L(1,:,:)));	
		L1(i)=L(1,1);
		L2(i)=L(2,2);
		M(i)=L(1,2);
		R1(i)=R(1,1)/630;
		R2(i)=R(2,2)/630;
		k(i)=M(i)/sqrt(L1(i)*L2(i));
		i=i+1;
	end
end

L1test=0.00026866*ones(1,16);
L2test=0.00021768*ones(1,16);
R1test=0.440295*ones(1,16);
R2test=0.152504*ones(1,16);
Mtest=[3.54e-5,3.47e-5,3.21e-5,2.81e-5,3.55e-5,3.43e-5,3.1e-5,2.76e-5,3.47e-5,3.28e-5,3.05e-5,2.67e-5,3.25e-5,3.17e-5,2.9e-5,2.63e-5];
ktest=[0.1464,0.14349,0.13270882,0.11598,0.14658815,0.14196,0.1281,0.1139086,0.14348063,0.1358035,0.12629,0.1105,0.134263,0.13097747,0.11993,0.1085];
L1error=100*abs(L1test-L1)./L1test;
L2error=100*abs(L2test-L2)./L2test;
R1error=100*abs(R1test-R1)./R1test;
R2error=100*abs(R2test-R2)./R2test;
Merror=100*abs(Mtest-M)./Mtest;
kerror=100*abs(ktest-k)./ktest;


figure(); hold on;
plot(L1); plot(L1test);
plot(L2); plot(L2test);
figure(); hold on;
plot(M); plot(Mtest);
figure(); hold on;
plot(R1); plot(R1test);
plot(R2); plot(R2test);
figure(); hold on;
plot(k); plot(ktest);