# Assignment 1.5: Escape the wumpus cave 

This repository contains a solution to the Escape the Wumpus Cave assignment, focusing on planning using the Planning Domain Definition Language (PDDL). The task involves devising a strategy for an agent to escape from a Wumpus-infested cave using PDDL planners. The agent must navigate through various obstacles such as walls, crates, pits, and the formidable Wumpus itself to find its way out of the cave.

## Table of Contents

- [Introduction](#introduction)
  - Approach
- [Setup](#setup)
  - Repository content
  - How to run the code
  - Used libraries
- [Code Structure](#code-structure)
- [Self Evaluation and Design Decisions](#design-decision)
- [Output Format](#output-format)

## Introduction

In the Wumpus world, the agent is confined to a grid-like environment where each cell can have different properties. These properties include walls (X), Wumpuses (W), crates (C), half-crates (H), pits (P), and items such as fireworks sets (F) and arrows (A). The agent's objective is to reach a designated exit point, maneuvering through the obstacles while utilizing available resources such as arrows and fireworks sets to overcome challenges.

### Approach 
We adopted a planning approach using the fast-downward planner with the lama-first alias for solving the Escape the Wumpus Cave assignment. Fast-downward is a highly optimized planner known for its efficiency and success in international planning competitions. The lama-first alias prioritizes finding a solution quickly over optimizing for minimal cost or the number of actions.
- **Fast-Downward Planner:** 
Fast-downward is a state-of-the-art planner that provides efficient solutions to planning problems specified in PDDL. It employs various heuristic search techniques, including landmark-based heuristics, to guide the search for a solution. The planner supports different search modes, including lama-first, which is suitable for quickly finding feasible plans without necessarily guaranteeing optimality.
- **Lama-First Search Mode:** 
The lama-first search mode in fast-downward prioritizes finding a feasible plan efficiently without focusing on finding the optimal solution. This mode is suitable for scenarios where finding any valid plan within a reasonable time frame is more important than finding the shortest or most optimal plan. It trades optimality for speed, making it suitable for solving the Escape the Wumpus Cave assignment where the primary objective is to escape the cave rather than minimizing the number of actions or resources used.

Additionally, we utilized Docker for running fast-downward, ensuring portability and ease of deployment across different environments. Using fast-downward with the lama-first mode allowed us to efficiently generate plans for navigating the agent through the Wumpus world, ensuring that the agent successfully escapes from the cave while adhering to the constraints and dynamics of the environment.

## Setup
### This repository contains:
 1) **`escape.py`**: This Python script is designed to automate the generation and solving of Wumpus World problems using PDDL (Planning Domain Definition Language) and a planner. It parses map files to insert content into PDDL files, executes a planner for each PDDL file, and generates solution text files by mapping actions from the planner's output.
 2) **`wumpus.pddl`**: This domain file specifies the actions available to the agent and the conditions under which these actions can be executed. We defined actions such as walking, pushing objects, shooting arrows, and scaring the Wumpus. These actions are parameterized based on the direction in which they are performed (north, east, south, west) and the presence of certain objects in neighboring cells.
 3) **`map.pddl`**: This file describes the specific layout of the map, including the initial state of the environment and the agent's starting position. Each map corresponds to a different problem instance, and the problem file outlines the initial configuration of walls, crates, pits, arrows, fireworks sets, and the Wumpus.
 4) **`file-pddl`**: The folder contains the "mapXYZ.pddl" files, each augmented with the initial state specific to every corresponding "mapXYZ.txt" instance.
 5) **`file-pddl-sol`**: the folder contains the planner solutions for each corresponding "mapXYZ.pddl" instance.
 6) **`file-txt`**: the folder contains the mapping of the planner output to the requested output format for each "mapXYZ.pddl" instance.

### How to run the code: 
1. import os, import shutil, import subprocess.
2. **`map.pddl`** and **`wumpus.pddl`** must both be placed with the **`escape.py`** file in the main folder.
- Please note that you can change the main folder location in the "Path Configuration Variable" **`BASE_DIR`** in **`escape.py`**.
3. Docker must be running 
4. Run **`escape.py`**.

### Used libraries:
**_os:_** 
Description: module in Python provides a way to interact with the operating system. It allows you to perform tasks such as navigating directories, creating and deleting files, and executing system commands.

**_shutil:_** 
Description: module is used for high-level file operations. It provides functions for copying, moving, and deleting files and directories, as well as archiving and extracting files.

**_subprocess:_** 
Description: module enables you to spawn new processes, connect to their input/output/error pipes, and obtain their return codes. It allows you to run external commands and interact with them programmatically from within Python.

## Code Structure
◆ **_wumpus.pddl_**
-

**1) :TYPES**
```python
(:types
    location
    agent pit pushable pickable wumpus wall - physob
    fireworks arrow - pickable
    crate halfcrate - pushable
  )
```
Defines the types of objects that exist in the domain.

**2) :PREDICATES**

```python
  (:predicates
    (at ?o - physob ?l - location)
    
    (adjacent_north ?l1 - location ?l2 - location)  
    (adjacent_south ?l1 - location ?l2 - location)  
    (adjacent_east ?l1 - location ?l2 - location)  
    (adjacent_west ?l1 - location ?l2 - location)  
    
    (empty ?l - location)
    (emptyPit ?l - location)
    (halfPit ?l - location)
    (filledPit ?l - location)
    (blockedByWall ?l - wall)  
    
    (hasArrows ?s - agent ?a - arrow)
    (hasFireworks ?s - agent ?f - fireworks)

    (exit_points ?l - location)
    (exit_map)
)
```
Define the properties or relationships between objects in the domain. They represent the state of the world and the conditions under which actions can be performed. In this domain.

**3) :ACTIONS** <br />
▣ **walk**

```python
  (:action walk ;;East/West/North/South
    ...
  )
```
This action allows the agent to move from one location to an adjacent location in any cardinal direction (north, south, east, or west) under specific conditions. The move is allowed if the destination is either empty or contains certain objects (like an arrow or fireworks) but not others (like a crate or half-crate), and there are no dangerous entities present. After the move, the agent's location is updated, the previous location is marked as empty, and if there was an arrow in the new location, the agent acquires it and it is removed from the location.

▣ **pushCrate**
```python
  (:action pushCrate ;;East/West/North/South
    ...
  )
```
This action allows the agent to push an object to an adjacent location in any cardinal direction. The outcomes vary based on the type of destination: 
- **Empty Square:** the agent can push the object to the new location, leaving the previous location empty.
![Screenshot 2024-08-27 191554](https://github.com/user-attachments/assets/4faece0a-1b7e-4610-ac33-7b5d32abc8a5)


- **Empty Pit:** the object may either disappear (if it's a crate) creating an empty square out of the pit or partially fill the pit (if it's a half-crate), with the agent moving into the original object's position.
<img src="image-6.png" alt="alt text" width="500" height="200">

- **Half-Pit:** pushing a crate will block the location, or if it's a half-crate, the half-pit becomes an empty square, and the agent moves as before.
<img src="image-7.png" alt="alt text" width="500" height="200">

▣ **shoot**
```python
  (:action shoot ;;East/West/North/South
    ...
  )
```
This action allows the agent to shoot an arrow in any cardinal direction towards a location where a Wumpus is present. The action can occur if the agent has an arrow and is adjacent to the Wumpus in the specified direction. When the action is performed, the Wumpus is eliminated from the target location, making that location an empty square for the agent to move in, and the agent loses the arrow used for the shot. 

▣ **scare**
```python
  (:action scare ;;East/West/North/South
    ...
  )
```
This action allows the agent to scare a Wumpus in any cardinal direction using fireworks. The action can occur if the Wumpus is in an adjacent location and the agent has fireworks. The Wumpus will move from its current location to the next adjacent location in the same direction, provided that the new location is either empty or contains fireworks or an arrow. If the Wumpus successfully moves, the previous location becomes empty. If fireworks or an arrow were present at the initial location, they remain there after the Wumpus moves. The agent loses the fireworks used in the action.

▣ **pushHalfCrate**
```python
  (:action pushHalfCrate ;;East/West/North/South
    ...
  )
```
This code defines an action where an agent can push a half-crate in any cardinal direction. The action requires that the agent, the first half-crate, and the second half-crate are in consecutive adjacent locations, and the final destination is either empty, contains an arrow or fireworks, or is a pit. The outcomes depend on the destination type:

- **Empty Square:** The agent moves to the location of the first half-crate, pushing the first half-crate to the location of the second half-crate, and the second half-crate to the final location, which is now occupied by that half-crate.<br />
<img src="image-8.png" alt="alt text" width="500" height="200">


- **Empty Pit:** The agent and the first half-crate move similarly, but the second half-crate falls into the pit, transforming it into a "half-pit."
<img src="image-9.png" alt="alt text" width="500" height="200">

- **Half-Pit:** The agent and the first half-crate move as before, but the second half-crate fully covers the half-pit, leaving the final location empty.
<img src="image-10.png" alt="alt text" width="500" height="200">

```python
  (:action exit_map
    ...
  )
```
This action defines a scenario where an agent can exit the map. The action can only occur if the agent is at a location that is designated as an exit point. When the conditions are met, the agent successfully exits the map


◆ **_map.pddl_**
-
1) **:objects**
```python
  (:objects   
    
    s - agent
    w - wumpus
    p - pit
    c - crate
    h - halfcrate
    f - fireworks
    a - arrow

    cell0_0 cell0_1 cell0_2 cell0_3 cell0_4 cell0_5 cell0_6 cell0_7 cell0_8 cell0_9 cell0_10 cell0_11 - location
    .
    .
    cell7_0 cell7_1 cell7_2 cell7_3 cell7_4 cell7_5 cell7_6 cell7_7 cell7_8 cell7_9 cell7_10 cell7_11 - location
  )
```
This section defines the elements present in the problem domain, such as the agent, wumpus, pits, crates, and other objects. Each object is assigned a unique identifier and a type within the domain of the problem. These objects represent the elements that the agent interacts with or navigates through in the environment described by the problem domain.

2) **:init**

This section serves to specify the initial state of the problem domain.
mainly by defining three main relations: 

- **Map content:** For each mapXYZ its initial states are scanned by the escape.py script and embedded in this section.
- **Exit cells:** Stating the exit locations in the map.
- **Adjacencies:** Stating the adjacencies between each cell and all the surrounding adjacent cells to it from the four cardinal direction (north, south, east, or west)

This results in generating a mapXYZ.pddl file containing all the required information for every single map.

3) **:goal**

The final goal is for the agent to reach one of the squares marked as Exit cells.

## Self Evaluation and Design Decisions

### _wumpus.pddl file_

- We encountered issues with the latest version of PDDL extension (v2.28.1), where the `wumpus.pddl` file was not processed correctly. However, after reverting to an earlier version (v1.0.0), the file was read and executed without any problems.

- Initially, we implemented nested "when" conditions in our PDDL model. However, we discovered that nested conditional effects are not permitted according to the BNF definition of PDDL 3.1. As a result, we adjusted our approach to handle action conditions using a single "when" condition instead of nesting them.

- Regarding the actions, our initial goal was to enable the agent to pick up either Arrow objects (?a) or Firework objects (?f) within the "walk" action. However, while this approach worked for the Arrow objects, we encountered issues with the Firework objects. To address this, we created a separate action called `pickUpFireworks` specifically for collecting Firework objects, this adjustment allowed us to effectively resolve the issue of being unable to correctly collect and use Firework objects.

- For the "Push Crate" and "Push Half-Crate" actions, we needed to create two separate actions to address the following scenarios:

  - Pushing a single object, whether it's a "Crate" or a "Half-Crate," to a new position. This was managed by the `push(East/West/North/South)` actions.
  <img src="image-3.png" alt="alt text" width="500" height="200">
  - Pushing two "Half-Crates" together to a new position, which was handled by the `pushHalfCrate(East/West/North/South)` actions.
  <img src="image-4.png" alt="alt text" width="500" height="200">

- We encountered an issue where the agent was pushing objects or scaring the Wumpus outside the map boundaries, despite having defined all map cells and every location from "cell0_0" to "cell7_11". To resolve this, we added an additional condition to ensure that the current location of either the object to be moved or the Wumpus to be scared is not already defined as an "exit_point." This extra check helped prevent the agent from inadvertently moving elements outside the intended map boundaries.

 
## Output Format 

As for the output each required type of files are generated in diffrent folder: 
- **file-pdd:** contains the "mapXYZ.pddl" files.
- **file-pddl-sol:** ontains the planner solutions for each corresponding "mapXYZ.pddl" instance.
- **file-txt:** contains mapping of the planner output to the requested output format.

When passing both the `wumpus.pddl` and `map.pddl` to the server and running the script on the example problems and verifying the solution by using 

![alt text](image-2.png)

we get: 

![alt text](image.png)
