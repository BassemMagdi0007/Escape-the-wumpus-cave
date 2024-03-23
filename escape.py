import os
import shutil
import subprocess

# Function to parse the map file and extract content
def parse_map_file(map_file):
    map_state = []
    with open(map_file, 'r') as f:
        lines = f.readlines()
    for row, line in enumerate(lines):
        for col, char in enumerate(line):
            cell = f'cell{row}_{col}'
            # Agent
            if char == 'S':
                map_state.append(f'(at s {cell})')
            # empty Space
            elif char == " ":
                map_state.append(f'(empty {cell})')
            # Wumpus
            elif char == 'W':
                map_state.append(f'(at w {cell})')
            # Arrow
            elif char == 'A':
                map_state.append(f'(at a {cell})')
            # Fireworks
            elif char == 'F':
                map_state.append(f'(at f {cell})')
            # Crate
            elif char == 'C':
                map_state.append(f'(at c {cell})')
            # Half Crate
            elif char == 'H':
                map_state.append(f'(at h {cell})')
            # Pit
            elif char == 'P':
                map_state.append(f'(at p {cell})')
    return map_state

# Directory containing example problem files
example_map = r'E:\Collage\Semester-4\AI-SysProject\Problem_5\project\assignment\example-maps'

# Directory containing map.pddl file
original_map = r'E:\Collage\Semester-4\AI-SysProject\Problem_5\project\assignment'

# Destination directory for copied mapXYZ.pddl files
example_pddl = r'E:\Collage\Semester-4\AI-SysProject\Problem_5\project\assignment\example-pddl'

# Directory containing wumpus.pddl file
domain_map = r'E:\Collage\Semester-4\AI-SysProject\Problem_5\project\assignment'

# Directory for planner output
planner_output = r'E:\Collage\Semester-4\AI-SysProject\Problem_5\project\assignment\planner-output'


# List to store PDDL file paths
pddl_files = []

# Count of PDDL files to generate
max_files = 10
count = 0

# Iterate over each example problem file
for example_problem_file in os.listdir(example_map):
    if example_problem_file.endswith('.txt'):
        # Extract the example problem number from the file name
        problem_number = example_problem_file.split('.')[0]
        
        # Paths for input and output files
        map_txt_file_path = os.path.join(example_map, example_problem_file)
        map_pddl_file_path = os.path.join(original_map, f'{problem_number}.pddl')
        
        # Parse the map file to extract content
        map_content = parse_map_file(map_txt_file_path)
        
        # Copy the original map.pddl file to the output folder
        destination_map_pddl_path = os.path.join(example_pddl, f'{problem_number}.pddl')
        shutil.copy(os.path.join(original_map, 'map.pddl'), destination_map_pddl_path)
        
        # Read the existing content of the map pddl file
        with open(destination_map_pddl_path, 'r') as f:
            pddl_content = f.readlines()
        
        # Update the problem name in the PDDL file
        for index, line in enumerate(pddl_content):
            if line.strip().startswith('(define (problem map)'):
                pddl_content[index] = f'(define (problem {problem_number})\n'
        
        # Find the index of the line containing the '(:init' tag
        init_index = None
        for index, line in enumerate(pddl_content):
            if line.strip().lower().startswith('(:init'):
                init_index = index
                break
        
        if init_index is None:
            print("Error: '(:init' tag not found in the PDDL file.")
            exit()
        
        # Insert the extracted content from map.txt right after the '(:init' tag in the pddl file
        for item in map_content:
            pddl_content.insert(init_index + 2, '\t' '\t' + item + '\n')
            init_index += 1
        
        # Write the modified content back to the map pddl file
        with open(destination_map_pddl_path, 'w') as f:
            f.writelines(pddl_content)
        
        print(f"Content inserted successfully into {destination_map_pddl_path}")
        
        # Append the path of the generated PDDL file to the list
        pddl_files.append(destination_map_pddl_path)
        
        # Increment the count
        count += 1
        if count >= max_files:
            break
