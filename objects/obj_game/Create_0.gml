/// @description Initialize Variables

// Constants

#macro TILE 16
#macro WIDTH 7
#macro HEIGHT 11

#macro ENERGY 5
#macro STRONG 4
#macro WEAK 2
#macro HITS 3

// Entity Pool

global.entities = array_create(0);
transition = 1;

// Player

energy = ENERGY;
player = new str_entity(spr_player, WIDTH / 2, HEIGHT / 2);
array_push(global.entities, player);

// Entity Queue

turn = 1;
queue = [];
queue_pos = 0;
var pos = 5;

array_push(queue, new str_spawner(pos, enemy.missile, -2)); pos += 10;
array_push(queue, new str_spawner(pos, enemy.missile, 2)); pos += 10;
array_push(queue, new str_spawner(pos, enemy.gunner, 0)); pos += 15;
array_push(queue, new str_spawner(pos, enemy.missile, -2)); pos += 0;
array_push(queue, new str_spawner(pos, enemy.missile, 2)); pos += 15;
array_push(queue, new str_spawner(pos, enemy.glider, -1)); pos += 20;
array_push(queue, new str_spawner(pos, enemy.gunner, 2)); pos += 1;
array_push(queue, new str_spawner(pos, enemy.gunner, 0)); pos += 1;
array_push(queue, new str_spawner(pos, enemy.gunner, -2)); pos += 30;
array_push(queue, new str_spawner(pos, enemy.glider, 2)); pos += 5;
array_push(queue, new str_spawner(pos, enemy.glider, -2)); pos += 15;
array_push(queue, new str_spawner(pos, enemy.missile, -2)); pos += 2;
array_push(queue, new str_spawner(pos, enemy.missile, 0)); pos += 2;
array_push(queue, new str_spawner(pos, enemy.missile, 2)); pos += 10;
array_push(queue, new str_spawner(pos, enemy.saucer, 0)); pos += 20;

array_push(queue, new str_spawner(pos, enemy.glider, -2)); pos += 5;
array_push(queue, new str_spawner(pos, enemy.glider, 2)); pos += 15;
array_push(queue, new str_spawner(pos, enemy.gunner, -3)); pos += 3;
array_push(queue, new str_spawner(pos, enemy.gunner, -1)); pos += 3;
array_push(queue, new str_spawner(pos, enemy.gunner, 1)); pos += 3;
array_push(queue, new str_spawner(pos, enemy.gunner, 3)); pos += 20;
array_push(queue, new str_spawner(pos, enemy.rammer, -2)); pos += 5;
array_push(queue, new str_spawner(pos, enemy.rammer, 2)); pos += 15;
array_push(queue, new str_spawner(pos, enemy.glider, -2)); pos += 5;
array_push(queue, new str_spawner(pos, enemy.glider, 0)); pos += 5;
array_push(queue, new str_spawner(pos, enemy.glider, 2)); pos += 15;
array_push(queue, new str_spawner(pos, enemy.saucer, -2)); pos += 10;
array_push(queue, new str_spawner(pos, enemy.saucer, 2)); pos += 25;

array_push(queue, new str_spawner(pos, enemy.glider, 2)); pos += 5;
array_push(queue, new str_spawner(pos, enemy.rammer, 0)); pos += 5;
array_push(queue, new str_spawner(pos, enemy.glider, -2)); pos += 20;
array_push(queue, new str_spawner(pos, enemy.gunner, 2)); pos += 0;
array_push(queue, new str_spawner(pos, enemy.gunner, 0)); pos += 0;
array_push(queue, new str_spawner(pos, enemy.gunner, -2)); pos += 5;
array_push(queue, new str_spawner(pos, enemy.missile, -3)); pos += 0;
array_push(queue, new str_spawner(pos, enemy.missile, -1)); pos += 0;
array_push(queue, new str_spawner(pos, enemy.missile, 1)); pos += 0;
array_push(queue, new str_spawner(pos, enemy.missile, 3)); pos += 20;
array_push(queue, new str_spawner(pos, enemy.glider, -2)); pos += 1;
array_push(queue, new str_spawner(pos, enemy.glider, 0)); pos += 1;
array_push(queue, new str_spawner(pos, enemy.glider, 2)); pos += 10;
array_push(queue, new str_spawner(pos, enemy.saucer, 0)); pos += 25;

array_push(queue, new str_spawner(pos, enemy.mothership, 0));

// Visual

global.effects = array_create(0);
frame = 0;

// Interface

intro = false; // true
window_transition = 1; // 0
winner = false;