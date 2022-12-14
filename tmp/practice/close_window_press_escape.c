#include <mlx.h>
#include <stdio.h>
#include <stdlib.h>


typedef struct	s_vars
{
	void	*mlx;
	void	*win;
}	t_vars;

# define KEY_ESCAPE_MAC 27
# define KEY_ESCAPE_LINUX 65307
int	close_window(int keycode, t_vars *vars)
{
	if (keycode == KEY_ESCAPE_MAC || keycode == KEY_ESCAPE_LINUX)
	{
		mlx_loop_end(vars->mlx);
	}
	return (0);
}

// void	mlx_hook(mlx_win_list_t *win_ptr, int x_event
// , int x_mask, int (*f)(), void *param);
int	main(void)
{
	t_vars	vars;

	vars.mlx = mlx_init();
	vars.win = mlx_new_window(vars.mlx, 640, 480, "Close escape");
	
	mlx_hook(vars.win, 2, 1L<<0, close_window, &vars);
	mlx_loop(vars.mlx);
	
	mlx_destroy_window(vars.mlx, vars.win);
	mlx_destroy_display(vars.mlx);
	free(vars.mlx);
	return (0);
}
