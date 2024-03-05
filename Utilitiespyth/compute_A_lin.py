def compute_A_lin(sys_params, mu):
    alpha = sys_params['alpha']
    omega_bar = sys_params['omega_bar']
    A = [[alpha * mu, -omega_bar],
         [omega_bar, alpha * mu]]
    return A
