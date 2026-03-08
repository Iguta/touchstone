# Temple Escape – Godot 4 Prototype

A small interactive prototype built in Godot 4 to explore the engine’s node-based architecture, scripting workflow, and event-driven gameplay mechanics.

This project demonstrates core Godot concepts including scene composition, player movement, interaction systems, collision detection, and UI updates.

---

## Overview

Temple Escape is a simple top-down exploration game where the player navigates a temple environment while collecting items and avoiding enemies.

The goal is to:

1. Collect all coins in the level
2. Retrieve a key hidden in the map
3. Unlock the temple door
4. Reach the exit before time runs out

The project was created as a learning exercise to understand Godot’s architecture and workflow while implementing a small but complete gameplay loop.

---

## Features

- Player movement using WASD or arrow keys
- Sprint mechanic
- Collectible coins
- Key and locked door interaction
- Patrol enemy and chasing enemy
- Player health system
- Medkit pickup
- Countdown timer
- HUD interface showing score, health, and status
- Win / lose conditions
- Restart system

---

## Controls

Move: WASD / Arrow Keys  
Sprint: Shift  
Interact (door): E  
Restart: R

---

## Project Structure

godot_touchstone_redux/

project.godot  
scenes/  
    world.tscn  

scripts/  
    player.gd  
    enemy_patrol.gd  
    enemy_chaser.gd  
    coin.gd  
    world.gd  

assets/

---

## Scenes

world.tscn

Main level scene containing the environment, player, enemies, collectibles, and UI.

---

## Scripts

player.gd  
Handles player input, movement, sprinting, and interactions.

coin.gd  
Implements collectible logic and score updates.

enemy_patrol.gd  
Controls enemy movement along a fixed patrol path.

enemy_chaser.gd  
Implements basic chase behavior toward the player.

world.gd  
Acts as the main coordinator for the game:
- tracks coins collected
- manages player health
- updates the HUD
- determines win/lose conditions

---

## Concepts Demonstrated

This project demonstrates several core Godot engine concepts:

- Scene tree architecture
- Node composition
- Event-driven signals
- Collision detection
- Physics-based movement
- Game state management
- UI with CanvasLayer
- Basic AI movement logic

---

## Running the Project

1. Download or clone the repository
2. Open Godot 4.x
3. Click Import
4. Select the project.godot file
5. Run the project

---

## Purpose

This project was created to explore how visual game engines structure interactive systems using scene graphs and event-driven scripting.

It serves as a small prototype demonstrating how gameplay elements can be composed through nodes, scenes, and scripts in Godot.

---

## Future Improvements

Potential improvements include:

- Tilemap-based level design
- Pathfinding for enemy AI
- Sound effects and music
- Animated sprites
- Menu and pause system
- Save/load mechanics

---

## License

This project is provided for educational and demonstration purposes.
