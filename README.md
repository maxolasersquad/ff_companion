# ff_companion
This is a lua script for fceux that provides and object-oriented view into the Final Fantasy game.

## Requirements
This script requires both FCEUX and a Final Fantasy rom. 

## The Interface
A GTK interface exposes some information about the game. The current interface is primarily for debugging only and will look drastically different when complete.

## Goals
The following goals are in order of precedence.

1. Create classes for the most relevant objects in the game. e.g. Characters, armor, weapons, magic, enemies, etc.
2. Create a screen that shows information about all characters, the current game state, etc.
3. Provide an alternate interface that can essentially replace the actual interface, but looks better, and provides a better UX.
