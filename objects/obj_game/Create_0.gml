/// @description Initialize Variables

// Constants

#macro TILE 16
#macro WIDTH 7
#macro HEIGHT 11

// Entity Pool

global.entities = array_create(0);
transition = 1;

player = new str_entity(spr_player, WIDTH / 2, HEIGHT / 2);
array_push(global.entities, player);

// Entity Queue

turn = 1;
queue = [];
queue_pos = 0;
array_push(queue, new str_spawner(5, enemy.glider, 0));
array_push(queue, new str_spawner(15, enemy.glider, 2));
array_push(queue, new str_spawner(15, enemy.glider, 0));
array_push(queue, new str_spawner(15, enemy.glider, -2));
array_push(queue, new str_spawner(30, enemy.glider, -3));
array_push(queue, new str_spawner(31, enemy.glider, -2));
array_push(queue, new str_spawner(32, enemy.glider, -1));
array_push(queue, new str_spawner(33, enemy.glider, 0));
array_push(queue, new str_spawner(34, enemy.glider, 1));
array_push(queue, new str_spawner(35, enemy.glider, 2));
array_push(queue, new str_spawner(36, enemy.glider, 3));