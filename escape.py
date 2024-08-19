import os
import shutil
import subprocess

# Configuration: Paths and Directories
BASE_DIR = r'E:\Collage\Semester-4\AI-SysProject\Problem_5\project\assignment2'
EXAMPLE_MAPS_DIR = os.path.join(BASE_DIR, 'example-maps')
# EXAMPLE_MAPS_DIR = os.path.join(BASE_DIR, 'maps')
ORIGINAL_MAP_DIR = BASE_DIR
EXAMPLE_PDDL_DIR = os.path.join(BASE_DIR, 'file-pddl')
PLANNER_OUTPUT_DIR = os.path.join(BASE_DIR, 'file-pddl-sol')
SOLUTION_TXT_DIR = os.path.join(BASE_DIR, 'file-txt')
WUMPUS_PDDL_DIR = BASE_DIR

# Function to parse the map file and extract content
def parse_map_file(map_file):
    map_state = []
    with open(map_file, 'r') as f:
        lines = f.readlines()
    for row, line in enumerate(lines):
        for col, char in enumerate(line):
            cell = f'cell{row}_{col}'
            if char == 'S':
                map_state.append(f'(at s {cell})')   # Agent
            elif char == " ":
                map_state.append(f'(empty {cell})')  # Empty Space
            elif char == 'W':
                map_state.append(f'(at w {cell})')   # Wumpus
            elif char == 'A':
                map_state.append(f'(at a {cell})')   # Arrow
            elif char == 'F':
                map_state.append(f'(at f {cell})')   # Fireworks
            elif char == 'C':
                map_state.append(f'(at c {cell})')   # Crate
            elif char == 'H':
                map_state.append(f'(at h {cell})')   # Half Crate
            elif char == 'P':
                map_state.append(f'(at p {cell})')   # Pit
    return map_state

# Function to copy map.pddl files and insert map content into them
def copy_and_insert_map_content(example_map_dir, original_map_dir, example_pddl_dir):
    pddl_files = []
    for example_problem_file in os.listdir(example_map_dir)[0:10]:
        if example_problem_file.endswith('.txt'):
            problem_number = example_problem_file.split('.')[0]

            # Paths for input and output files
            map_txt_file_path = os.path.join(example_map_dir, example_problem_file)
            destination_map_pddl_path = os.path.join(example_pddl_dir, f'{problem_number}.pddl')

            # Parse the map file to extract content
            map_content = parse_map_file(map_txt_file_path)

            # Copy the original map.pddl file to the output folder
            shutil.copy(os.path.join(original_map_dir, 'map.pddl'), destination_map_pddl_path)

            # Read and modify the PDDL file
            with open(destination_map_pddl_path, 'r') as f:
                pddl_content = f.readlines()

            # Update the problem name in the PDDL file
            for index, line in enumerate(pddl_content):
                if line.strip().startswith('(define (problem map)'):
                    pddl_content[index] = f'(define (problem {problem_number})\n'

            # Insert the map content after the '(:init' tag
            init_index = None
            for index, line in enumerate(pddl_content):
                if line.strip().lower().startswith('(:init'):
                    init_index = index
                    break

            if init_index is None:
                print("Error: '(:init' tag not found in the PDDL file.")
                exit()

            for item in map_content:
                pddl_content.insert(init_index + 2, '\t' '\t' + item + '\n')
                init_index += 1

            # Write the modified content back to the PDDL file
            with open(destination_map_pddl_path, 'w') as f:
                f.writelines(pddl_content)

            print(f"Content inserted successfully into {destination_map_pddl_path}")
            pddl_files.append(destination_map_pddl_path)

    return pddl_files

# Function to execute the planner for each PDDL file
def execute_planner(example_pddl_dir, planner_output_dir, pddl_files):
    for pddl_file in pddl_files:
        problem_number = os.path.basename(pddl_file).split('.')[0]

        docker_command = (
            f'docker run --rm -v "{example_pddl_dir}:/files" '
            f'-v "{WUMPUS_PDDL_DIR}:/wumpus" '
            f'aibasel/downward --alias lama-first --plan-file /files/{problem_number}.soln '
            f'/wumpus/wumpus.pddl /files/{problem_number}.pddl'
        )

        subprocess.run(docker_command, shell=True)

        output_file = os.path.join(example_pddl_dir, f'{problem_number}.soln')
        if os.path.exists(output_file):
            print(f"Planner executed successfully for {problem_number}.pddl")
            shutil.move(output_file, os.path.join(planner_output_dir, f'{problem_number}.pddl.soln'))
            print(f"Planner output stored successfully in {os.path.join(planner_output_dir, f'{problem_number}.pddl.soln')}")
        else:
            print(f"No solution found for {problem_number}.pddl")

    print("All planner successful outputs stored successfully in:", planner_output_dir)

# Function to map actions from the solution file
def map_actions(solution_file):
    mapped_actions = []
    with open(solution_file, 'r') as f:
        lines = f.readlines()
    for line in lines:
        action = line.split()[0]
        if action == '(exit_map':
            mapped_actions.append(mapped_actions[-1])
        else:
            mapped_actions.append(action)
    return mapped_actions

# Function to generate solution text files
def generate_solution_text_files(planner_output_dir, solution_txt_dir, action_map):
    for solution_file in os.listdir(planner_output_dir):
        if solution_file.endswith('.pddl.soln'):
            problem_number = solution_file.split('.')[0]
            solution_txt_file_path = os.path.join(solution_txt_dir, f'{problem_number}-solution.txt')
            mapped_actions = map_actions(os.path.join(planner_output_dir, solution_file))
            with open(solution_txt_file_path, 'w') as f:
                if not mapped_actions:
                    f.write("No solution found.")
                else:
                    for action in mapped_actions:
                        action = action.strip('();')
                        mapped_action = action_map.get(action, action)
                        if mapped_action == 'pickupfireworks':
                            continue
                        f.write(f"{mapped_action}\n")
            print(f"Solution text file generated successfully for {problem_number}.pddl.soln")

# Main function to orchestrate the workflow
def main():
    # Action mapping
    action_map = {
        "walknorth": "walk north",
        "walksouth": "walk south",
        "walkwest": "walk west",
        "walkeast": "walk east",
        "pushnorth": "push north",
        "pushsouth": "push south",
        "pushwest": "push west",
        "pusheast": "push east",
        "shootnorth": "shoot north",
        "shootsouth": "shoot south",
        "shootwest": "shoot west",
        "shooteast": "shoot east",
        "scarewest": "scare west",
        "scareeast": "scare east",
        "scarenorth": "scare north",
        "scaresouth": "scare south",
        "pushhalfcratenorth": "push north",
        "pushhalfcratesouth": "push south",
        "pushhalfcratewest": "push west",
        "pushhalfcrateeast": "push east"
    }

    # Copy map content into PDDL files
    pddl_files = copy_and_insert_map_content(EXAMPLE_MAPS_DIR, ORIGINAL_MAP_DIR, EXAMPLE_PDDL_DIR)

    # Execute planner for each PDDL file
    execute_planner(EXAMPLE_PDDL_DIR, PLANNER_OUTPUT_DIR, pddl_files)

    # Generate solution text files
    generate_solution_text_files(PLANNER_OUTPUT_DIR, SOLUTION_TXT_DIR, action_map)

if __name__ == "__main__":
    main()
