%%%%%%%%%%%%%%% data file specifications
%%% ------------------------------------
%%% data U_exact, xs, lhs, true_nz_weights will be added from 
%%% [data_dr,pde_names{pde_num}] 

data_dr = 'datasets_OL/';
pde_names = {
    'KS_largetime.mat',...              %1
    'wave2DVCspeedu3.mat',...           %2    
    'wave3D_13-Feb-2022_1.mat'...,      %3
};
pde_num = 1;

%%%%%%%%%%%%%%% coarsen data
%%% ------------------------
%%% each row k is a triple [L s R] corresponding to subsampling in
%%% coordinate k: xs{k} <- xs{k}(L:s:R)

coarse_data_pattern = [[0 1 1];[0 1 1];[0 1 1]]; 

%%%%%%%%%%%%%%% add noise to data
%%% -----------------------------
%%% sigma_NR=||ep||/||U_exact||, ep is the noise, U_exact is noise-free data
%%% comment out rng('shuffle') to reproduce results
%%% noise_dist chooses Gaussian (0) or uniform (1) noise
%%% noise_alg chooses additive (0) or multiplicative (1) noise

sigma_NR = 0.1;
rng('shuffle');
noise_dist = 0;
noise_alg = 0;

%%%%%%%%%%%%%%% number of time snapshots allowed in memory
%%% ------------------------------------------------------

Kmem = 19;

%%%%%%%%%%%%%%% number of online iterations 
%%% ---------------------------------------
%%% (use inf to run on entire dataset)

maxOLits = inf;

%%%%%%%%%%%%%%% method of computing initial guess
%%% ---------------------------------------------
%%% options: 'LS' for least squares, 'zeros' for all zeros, 'randn' for standard Gaussian entries

ICmeth = 'zeros';

%%%%%%%%%%%%%%% Tikhonov regularization 
%%% -----------------------------------
%%% adds 0.5*gamma*||w||^2 to cost functions

gamma = 0;

%%%%%%%%%%%%%%% gradient descent stepsize
%%% -------------------------------------
%%% either aa_fac/||G*G_S|| or astep0 (see get_astep.m for details) 

aa_fac = 1;
astep0 = 0;

%%%%%%%%%%%%%%% iterative sparse regression method
%%% ----------------------------------------------
%%% 'IVHT', 'IHTs', 'LASSO' (see get_sparse_update.m for details)

SRmeth = 'IVHT';
lambda_init = 0.0001;
lambda_step = 0.1;
lambda_max = 0.1;

%%%%%%%%%%%%%%% PDE library
%%% -----------------------

max_dx = 4; % use spatial derivatives up to this order
max_dt = 1; % use temporal derivatives up to this order
polys = [0:4]; % use polynomials of state variables 
trigs = [];  % use trig functions of state variables
use_all_dt =  0; % use all temporal derivatives 
use_cross_dx = 0; % use all cross derivatives
custom_add = []; % add custom terms to the library [poly_tag derivative_tag]
custom_remove = {}; % remove terms using conditions {@(mat) mat(1,:)==0} will remove terms that depend on first state variable  

%%%%%%%%%%%%%%% weak discretization
%%% -------------------------------

max_rows = 5000; % maximum allowed rows in matrix, sets Query points, s_x
phi_class = {1,1}; % 1=piecewise polynomial, 2=Gaussian, {space,time}

use_cornerpt = 0; % use cornerpoint algorithm applied to first Kmem snapshots
tauhat_x = 2; tau_x = 10^-10;
tauhat_t = 2; tau_t = 10^-6;

m_x = 21; % values chosen if use_cornerpt = 0
p_x = 11;
m_t = floor((Kmem-1)/2);
p_t = 9;

%%%%%%%%%%%%%%% Display results during online iterations
%%% ----------------------------------------------------

print_loc = 1;
toggle_OL_print=1;

%%%%%%%%%%%%%%% Plot results during online iterations
%%% -------------------------------------------------

toggle_plot_basis_fcn = 0;
toggle_plot_sol =  0;
toggle_plot_fft = 0;