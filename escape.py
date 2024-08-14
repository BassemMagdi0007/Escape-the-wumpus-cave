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

# Function to copy map.pddl files and insert map content into them
def copy_and_insert_map_content(example_map, original_map, example_pddl):
    # List to store PDDL file paths
    pddl_files = []

    # Iterate over each example problem file
    for example_problem_file in os.listdir(example_map)[71:72]:
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

    return pddl_files

# Function to execute the planner for each PDDL file
def execute_planner(example_pddl, planner_output, pddl_files):
    # Iterate over each generated PDDL file and solve it
    for pddl_file in pddl_files:
        # Extract the problem number from the file name
        problem_number = os.path.basename(pddl_file).split('.')[0]

        # Docker command to run fast-downward planner for the current PDDL file
        docker_command = f'docker run --rm -v "{example_pddl}:/files" aibasel/downward --alias lama-first --plan-file /files/{problem_number}.soln /files/wumpus.pddl /files/{problem_number}.pddl'

        # Execute the Docker command
        subprocess.run(docker_command, shell=True)

        # Check if the output file exists
        output_file = os.path.join(example_pddl, f'{problem_number}.soln')
        if os.path.exists(output_file):
            print(f"Planner executed successfully for {problem_number}.pddl")
            # Move the planner output to the planner output directory
            shutil.move(output_file, os.path.join(planner_output, f'{problem_number}.pddl.soln'))
            print(f"Planner output stored successfully in {os.path.join(planner_output, f'{problem_number}.pddl.soln')}")
        else:
            print(f" \t \t \t No solution found for {problem_number}.pddl")

    print("All planner successful outputs stored successfully in:", planner_output)

# Function to map actions from the solution file
def map_actions(solution_file):
    mapped_actions = []
    with open(solution_file, 'r') as f:
        lines = f.readlines()
    for line in lines:
        # Extract the first word from each line
        action = line.split()[0]
        # Handle the 'exit_map' action
        if action == '(exit_map':
            # Use the previous action as it is for 'exit_map'
            mapped_actions.append(mapped_actions[-1])
        else:
            # Map the action and append to the list
            mapped_actions.append(action)
    return mapped_actions

# Function to generate solution text files
def generate_solution_text_files(planner_output, solution_txt_directory, action_map):
    # Iterate over each solution file and create the corresponding text file
    for solution_file in os.listdir(planner_output):
        if solution_file.endswith('.pddl.soln'):
            # Extract the problem number from the file name
            problem_number = solution_file.split('.')[0]
            # Path for the solution text file
            solution_txt_file_path = os.path.join(solution_txt_directory, f'{problem_number}-solution.txt')
            # Map actions from the solution file
            mapped_actions = map_actions(os.path.join(planner_output, solution_file))
            # Write the mapped actions to the text file
            with open(solution_txt_file_path, 'w') as f:
                if not mapped_actions:  # If mapped_actions is empty
                    f.write("No solution found.")
                else:
                    for action in mapped_actions:
                        # Remove the leading '(' and the ';' at the end of the line
                        action = action.strip('();')
                        # Map the action using action_map if available, else use the original action
                        mapped_action = action_map.get(action, action)
                        # Skip writing 'pickupfireworks' to the file
                        if mapped_action == 'pickupfireworks':
                            continue
                        # Write the mapped action to the file
                        f.write(f"{mapped_action}\n")
            print(f"Solution text file generated successfully for {problem_number}.pddl.soln")

                  
# Main function to orchestrate the workflow
def main():
    # Directories
    example_maps = r'E:\Collage\Semester-4\AI-SysProject\Problem_5\project\assignment2\example-maps'
    original_map = r'E:\Collage\Semester-4\AI-SysProject\Problem_5\project\assignment2'
    example_pddl = r'E:\Collage\Semester-4\AI-SysProject\Problem_5\project\assignment2\example-pddl'
    planner_output = r'E:\Collage\Semester-4\AI-SysProject\Problem_5\project\assignment2\planner-output'
    solution_txt_directory = r'E:\Collage\Semester-4\AI-SysProject\Problem_5\project\assignment2\example-txt'

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
        "pushhalfcratewest": "push H west",
        "pushhalfcratenorth": "push H north",
        "pushhalfcratesouth": "push H south",
        "pushhalfcrateeast": "push H east",
    }

    # Copy map content into PDDL files
    pddl_files = copy_and_insert_map_content(example_maps, original_map, example_pddl)

    # Execute planner for each PDDL file
    execute_planner(example_pddl, planner_output, pddl_files)

    # Generate solution text files
    generate_solution_text_files(planner_output, solution_txt_directory, action_map)

if __name__ == "__main__":
    main()
