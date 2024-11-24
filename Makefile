NAME = cub3D

CC = gcc
CFLAGS = -Wall -Werror -Wextra
CSANITIZE = -g -fsanitize=address

RM = rm -f


# LIBFT_DIR = ./libft
# LIBFT = $(LIBFT_DIR)/libft.a


UNAME := $(shell uname)
ifeq ($(UNAME), Linux)
	MINILIBX_DIR = ./minilibx-linux
	MINILIBX = $(MINILIBX_DIR)/libmlx.a
    LIBS = -lmlx -lXext -lX11 -lm
else
	MINILIBX_DIR = ./minilibx_opengl_20191021
	MINILIBX = $(MINILIBX_DIR)/libmlx.a
    LIBS = -lm -lmlx -framework OpenGL -framework AppKit
endif

INCLUDES = -I$(MINILIBX_DIR) -I$(LIBFT_DIR)
LDFLAGS = -L$(MINILIBX_DIR) -L$(LIBFT_DIR)

SRCDIR = ./srcs
SRCS = ${wildcard $(SRCDIR)/*.c}

OBJS = $(SRCS:.c=.o)

all:$(NAME)

$(NAME): $(OBJS) $(MINILIBX) $(LIBFT)
	$(CC) $(OBJS) $(LDFLAGS) $(LIBS) -o $(NAME)

%.o:%.c
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

$(MINILIBX):
	$(MAKE) -C $(MINILIBX_DIR)

# $(LIBFT)
# 	$(MAKE) -C $(LIBFT_DIR)

clean:
	$(MAKE) -C $(LIBFT_DIR) clean
	$(MAKE) -C $(MINILIBX_DIR) clean
	$(RM) $(OBJS)

fclean: clean
	$(MAKE) fclean -C $(LIBFT_DIR)
	$(RM) $(NAME) $(MINILIBX_DIR)/$(MINILIBX)

re: fclean all