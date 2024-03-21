
# # WORKING CODE FOR ONE FILE
# def parse_map_file(map_file):
#     map_state = []
#     with open(map_file, 'r') as f:
#         lines = f.readlines()
#     for row, line in enumerate(lines):
#         for col, char in enumerate(line):
#             cell = f'cell{row}_{col}'
#             # Agent
#             if char == 'S':
#                 map_state.append(f'(at s {cell})')
#             # empty Space
#             elif char == " ":
#                 map_state.append(f'(empty {cell})')
#             # Wumpus
#             elif char == 'W':
#                 map_state.append(f'(at w {cell})')
#             # Arrow
#             elif char == 'A':
#                 map_state.append(f'(at a {cell})')
#             # Fireworks
#             elif char == 'F':
#                 map_state.append(f'(at f {cell})')
#             # Crate
#             elif char == 'C':
#                 map_state.append(f'(at c {cell})')
#             # Half Crate
#             elif char == 'H':
#                 map_state.append(f'(at h {cell})')
#             # Pit
#             elif char == 'P':
#                 map_state.append(f'(at p {cell})')
#     return map_state

# # Input file paths
# map_txt_file_path = r'E:\Collage\Semester-4\AI-SysProject\Problem_5\project\assignment\example-maps\map000.txt'
# map_pddl_file_path = r'E:\Collage\Semester-4\AI-SysProject\Problem_5\project\assignment\my-example-solution\map000.pddl'

# # Parse the map file to extract content
# map_content = parse_map_file(map_txt_file_path)

# # Read the existing content of the map pddl file
# with open(map_pddl_file_path, 'r') as f:
#     pddl_content = f.readlines()

# # Find the index of the line containing the '(:init' tag
# init_index = None
# for index, line in enumerate(pddl_content):
#     if line.strip().lower().startswith('(:init'):
#         init_index = index
#         break

# if init_index is None:
#     print("Error: '(:init' tag not found in the PDDL file.")
#     exit()

# # Insert the extracted content from map.txt right after the '(:init' tag in the pddl file
# for item in map_content:
#     pddl_content.insert(init_index + 2, '\t' '\t' + item + '\n')
#     init_index += 1

# # Write the modified content back to the map pddl file
# with open(map_pddl_file_path, 'w') as f:
#     f.writelines(pddl_content)

# print("Content inserted successfully!")





# # Example usage:
# maps = r'E:\Collage\Semester-4\AI-SysProject\Problem_5\project\assignment\example-maps\map000.txt'
# initial_state = parse_map_file(maps)
# print(initial_state)

# stats = ""
# for i, line in enumerate (maps): 
#     for j, char in enumerate(line): 
#         if char == " ":
#             stats += "(empty cell{i}_{j})\n" 
#         elif char == "S":
#             stats += f" (at s cell{i}_{j})\n" 
#         elif char == "C":
#             stats += f"(at c cell{i}_{j})\n"
#         elif char == "H":
#             stats += f" (at h cell{i}_{j})\n" 
#         elif char == "W":
#             stats += f" (at w cell{i}_{j})\n" 
#         elif char == "A":
#             stats += f" (at a cell{i}_{j})\n" 
#             stats += f" (empty cell{i}_{j})\n" 
#         elif char == "F":
#             stats += f" (at f cell{i}_{j})\n" 
#             stats += f"(empty cell{i}_{j})\n" 
#         elif char == "p":
#             stats += f" (at p cell{i}_{j})\n"
#             stats += f"(emptyPit cell{i}_{j})\n"