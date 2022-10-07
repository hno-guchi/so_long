NAME = so_long

CC = cc
CFLAGS = -Wall -Wextra -Werror

SRCS = main.c

INCLUDES_DIR = ./includes
SRCS_DIR = ./srcs
OBJS_DIR = ./objs

INCLUDE = $(addprefix -I, $(INCLUDES_DIR))
OBJS = $(addprefix $(OBJS_DIR)/, $(SRCS:%.c=%.o))

MLX_NAME = libmlx_linux.a
MLX_DIR = ./mlx_linux
MLX_LIB = -lmlx_Linux -lXext -lX11
MLX_INCLUDE = $(addprefix -I, $(MLX_DIR))

LIBFT_NAME = libft.a
LIBFT_DIR = libft
LIBFT_LIB = -lft
LIBFT_INCLUDE = $(addprefix -I, $(LIBFT_DIR)/includes)

.PHONY: all clean fclean bonus re test_leaks test_overflow

all: $(OBJS_DIR) $(MLX_NAME) $(LIBFT_NAME) $(NAME)

$(NAME): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ -L$(MLX_DIR) $(MLX_LIB) -L$(LIBFT_DIR) $(LIBFT_LIB)

$(OBJS_DIR):
	mkdir -p $@

$(MLX_NAME): $(MLX_DIR)
	make -C $^

$(LIBFT_NAME): $(LIBFT_DIR)
	make -C $^

$(OBJS_DIR)/%.o: $(SRCS_DIR)/%.c
	$(CC) $(CFLAGS) -c $(INCLUDE) $(MLX_INCLUDE) $(LIBFT_INCLUDE) $< -o $@

clean: $(OBJS_DIR)
	$(RM) -r $^
	make clean -C $(LIBFT_DIR)

fclean: clean
	$(RM) $(NAME)
	make clean -C $(MLX_DIR)
	make fclean -C $(LIBFT_DIR)

bonus: all

re: fclean all

test_leaks: $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ -L$(MLX_DIR) $(MLX_LIB) -L$(LIBFT_DIR) $(LIBFT_LIB)
	valgrind --leak-check=full --leak-resolution=high --show-reachable=no ./$@

test_overflow: $(OBJS)
	$(CC) -g -fsanitize=address -o $@ $^ -L$(MLX_DIR) $(MLX_LIB) -L$(LIBFT_DIR) $(LIBFT_LIB)
