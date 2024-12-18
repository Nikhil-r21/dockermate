#!/bin/bash

# Advanced Docker Management Tool v5.0
# Comprehensive script for Docker container, image, network, and volume management

# Improved Color Definitions with Extended Palette
declare -A COLORS=(
    [RED]='\033[0;31m'
    [GREEN]='\033[0;32m'
    [YELLOW]='\033[1;33m'
    [BLUE]='\033[0;34m'
    [MAGENTA]='\033[0;35m'
    [CYAN]='\033[0;36m'
    [WHITE]='\033[1;37m'
    [RESET]='\033[0m'
)

# Enhanced Error Handling Function
handle_error() {
    local error_message="$1"
    local error_code="${2:-1}"
    
    echo -e "${COLORS[RED]}Error: $error_message${COLORS[RESET]}"
    exit "$error_code"
}

# Function to print header
print_header() {
    clear
    echo -e "${COLORS[BLUE]}===========================================${COLORS[RESET]}"
    echo -e "${COLORS[CYAN]}   Docker Management Tool v5.0${COLORS[RESET]}"
    echo -e "${COLORS[BLUE]}===========================================${COLORS[RESET]}"
}

# Function to display containers with color
display_containers() {
    echo -e "${COLORS[YELLOW]}Available Docker Containers:${COLORS[RESET]}"
    docker ps -a --format "{{.ID}}: {{.Image}} {{.Names}} (Status: {{.Status}})" | while read -r container_info; do
        if [[ $container_info == *"Up"* ]]; then
            echo -e "${COLORS[GREEN]}$container_info${COLORS[RESET]}"
        elif [[ $container_info == *"Exited"* ]]; then
            echo -e "${COLORS[RED]}$container_info${COLORS[RESET]}"
        else
            echo -e "${COLORS[MAGENTA]}$container_info${COLORS[RESET]}"
        fi
    done
}

# Function to display images with color
display_images() {
    echo -e "${COLORS[YELLOW]}Available Docker Images:${COLORS[RESET]}"
    docker images --format "{{.ID}}: {{.Repository}}:{{.Tag}} (Size: {{.Size}})" | while read -r image_info; do
        echo -e "${COLORS[CYAN]}$image_info${COLORS[RESET]}"
    done
}

# Function to display networks with color
display_networks() {
    echo -e "${COLORS[YELLOW]}Available Docker Networks:${COLORS[RESET]}"
    docker network list --format "{{.ID}}: {{.Name}} (Driver: {{.Driver}}, Scope: {{.Scope}})" | while read -r network_info; do
        echo -e "${COLORS[CYAN]}$network_info${COLORS[RESET]}"
    done
}

# Function to display volumes with color
display_volumes() {
    echo -e "${COLORS[YELLOW]}Available Docker Volumes:${COLORS[RESET]}"
    docker volume list --format "{{.Driver}}: {{.Name}}" | while read -r volume_info; do
        echo -e "${COLORS[CYAN]}$volume_info${COLORS[RESET]}"
    done
}

# Individual Container Management Function
manage_individual_container() {
    while true; do
        display_containers
        
        echo -e "${COLORS[YELLOW]}Select the container number to manage (0 to go back):${COLORS[RESET]}"
        read -r container_choice
        
        if [[ "$container_choice" == "0" ]]; then
            return
        fi
        
        selected_container=$(docker ps -a --format "{{.ID}}" | awk "NR==$container_choice")
        
        if [[ -z "$selected_container" ]]; then
            echo -e "${COLORS[RED]}Invalid container selection.${COLORS[RESET]}"
            read -n 1 -s -r -p "Press any key to continue..."
            continue
        fi
        
        while true; do
            echo -e "${COLORS[YELLOW]}Choose an action for the individual container:${COLORS[RESET]}"
            echo -e "1) ${COLORS[GREEN]}Start${COLORS[RESET]}"
            echo -e "2) ${COLORS[RED]}Stop${COLORS[RESET]}"
            echo -e "3) ${COLORS[MAGENTA]}Restart${COLORS[RESET]}"
            echo -e "4) ${COLORS[RED]}Delete${COLORS[RESET]}"
            echo -e "5) ${COLORS[BLUE]}View Logs${COLORS[RESET]}"
            echo -e "6) ${COLORS[CYAN]}Detailed Inspection${COLORS[RESET]}"
            echo -e "0) ${COLORS[YELLOW]}Back${COLORS[RESET]}"
            read -r action
            
            case $action in
                0) return ;;
                1)
                    docker start "$selected_container"
                    read -n 1 -s -r -p "Press any key to continue..."
                    ;;
                2)
                    docker stop "$selected_container"
                    read -n 1 -s -r -p "Press any key to continue..."
                    ;;
                3)
                    docker restart "$selected_container"
                    read -n 1 -s -r -p "Press any key to continue..."
                    ;;
                4)
                    docker rm -f "$selected_container"
                    break
                    ;;
                5)
                    docker logs "$selected_container"
                    read -n 1 -s -r -p "Press any key to continue..."
                    ;;
                6)
                    docker inspect "$selected_container"
                    read -n 1 -s -r -p "Press any key to continue..."
                    ;;
                *)
                    echo -e "${COLORS[RED]}Invalid option.${COLORS[RESET]}"
                    read -n 1 -s -r -p "Press any key to continue..."
                    ;;
            esac
        done
    done
}

# Individual Image Management Function
manage_individual_image() {
    while true; do
        display_images
        
        echo -e "${COLORS[YELLOW]}Select the image number to manage (0 to go back):${COLORS[RESET]}"
        read -r image_choice
        
        if [[ "$image_choice" == "0" ]]; then
            return
        fi
        
        selected_image=$(docker images --format "{{.ID}}" | awk "NR==$image_choice")
        
        if [[ -z "$selected_image" ]]; then
            echo -e "${COLORS[RED]}Invalid image selection.${COLORS[RESET]}"
            read -n 1 -s -r -p "Press any key to continue..."
            continue
        fi
        
        while true; do
            echo -e "${COLORS[YELLOW]}Choose an action for the individual image:${COLORS[RESET]}"
            echo -e "1) ${COLORS[RED]}Delete Image${COLORS[RESET]}"
            echo -e "2) ${COLORS[BLUE]}Inspect Image${COLORS[RESET]}"
            echo -e "0) ${COLORS[YELLOW]}Back${COLORS[RESET]}"
            read -r action
            
            case $action in
                0) return ;;
                1)
                    docker rmi -f "$selected_image"
                    break
                    ;;
                2)
                    docker inspect "$selected_image"
                    read -n 1 -s -r -p "Press any key to continue..."
                    ;;
                *)
                    echo -e "${COLORS[RED]}Invalid option.${COLORS[RESET]}"
                    read -n 1 -s -r -p "Press any key to continue..."
                    ;;
            esac
        done
    done
}

# Manage Containers Function
manage_containers() {
    while true; do
        print_header
        display_containers

        echo -e "${COLORS[YELLOW]}Choose a container management action:${COLORS[RESET]}"
        echo -e "1) ${COLORS[CYAN]}Individual Container Management${COLORS[RESET]}"
        echo -e "2) ${COLORS[GREEN]}Start All Stopped Containers${COLORS[RESET]}"
        echo -e "3) ${COLORS[RED]}Stop All Running Containers${COLORS[RESET]}"
        echo -e "4) ${COLORS[MAGENTA]}Restart All Containers${COLORS[RESET]}"
        echo -e "5) ${COLORS[RED]}Delete All Containers${COLORS[RESET]}"
        echo -e "6) ${COLORS[YELLOW]}Back${COLORS[RESET]}"
        echo -e "0) ${COLORS[WHITE]}Exit${COLORS[RESET]}"
        read -r container_action

        case $container_action in
            0)
                echo -e "${COLORS[GREEN]}Thank you for using Docker Management Tool v5.0${COLORS[RESET]}"
                exit 0
                ;;
            1)
                manage_individual_container
                ;;
            2)
                echo -e "${COLORS[GREEN]}Starting all stopped containers...${COLORS[RESET]}"
                docker start $(docker ps -a -q -f status=exited -f status=created)
                echo -e "${COLORS[GREEN]}All stopped containers started.${COLORS[RESET]}"
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
            3)
                echo -e "${COLORS[RED]}Stopping all running containers...${COLORS[RESET]}"
                docker stop $(docker ps -q)
                echo -e "${COLORS[RED]}All running containers stopped.${COLORS[RESET]}"
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
            4)
                echo -e "${COLORS[MAGENTA]}Restarting all containers...${COLORS[RESET]}"
                docker restart $(docker ps -aq)
                echo -e "${COLORS[MAGENTA]}All containers restarted.${COLORS[RESET]}"
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
            5)
                echo -e "${COLORS[RED]}Deleting all containers...${COLORS[RESET]}"
                docker container prune -f && echo -e "${COLORS[RED]}All stopped containers deleted.${COLORS[RESET]}"
                docker rm -f $(docker ps -aq) && echo -e "${COLORS[RED]}All containers deleted.${COLORS[RESET]}"
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
            6)
                return
                ;;
            *)
                echo -e "${COLORS[RED]}Invalid option.${COLORS[RESET]}"
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
        esac
    done
}

# List Unused Images Function
list_unused_images() {
    echo -e "${COLORS[BLUE]}Unused Docker Images:${COLORS[RESET]}"
    docker images -f "dangling=true"
}

# Delete Unused Images Function
delete_unused_images() {
    echo -e "${COLORS[RED]}Deleting unused images...${COLORS[RESET]}"
    docker image prune -f && echo -e "${COLORS[GREEN]}Unused images deleted.${COLORS[RESET]}"
}

# Manage Images Function
manage_images() {
    while true; do
        print_header
        display_images

        echo -e "${COLORS[YELLOW]}Choose an image management action:${COLORS[RESET]}"
        echo -e "1) ${COLORS[CYAN]}Individual Image Management${COLORS[RESET]}"
        echo -e "2) ${COLORS[BLUE]}List Unused Images${COLORS[RESET]}"
        echo -e "3) ${COLORS[RED]}Delete Unused Images${COLORS[RESET]}"
        echo -e "4) ${COLORS[RED]}Delete ALL Images${COLORS[RESET]}"
        echo -e "5) ${COLORS[YELLOW]}Back${COLORS[RESET]}"
        echo -e "0) ${COLORS[WHITE]}Exit${COLORS[RESET]}"
        read -r image_action

        case $image_action in
            0)
                echo -e "${COLORS[GREEN]}Thank you for using Docker Management Tool v5.0${COLORS[RESET]}"
                exit 0
                ;;
            1)
                manage_individual_image
                ;;
            2)
                list_unused_images
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
            3)
                delete_unused_images
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
            4)
                echo -e "${COLORS[RED]}Deleting ALL images...${COLORS[RESET]}"
                docker rmi -f $(docker images -q) && echo -e "${COLORS[RED]}All images deleted.${COLORS[RESET]}"
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
            5)
                return
                ;;
            *)
                echo -e "${COLORS[RED]}Invalid option.${COLORS[RESET]}"
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
        esac
    done
}

# Network Management Function
network_management() {
    while true; do
        print_header
        display_networks

        echo -e "${COLORS[YELLOW]}Network Management Menu:${COLORS[RESET]}"
        echo -e "1) ${COLORS[BLUE]}Inspect Network Details${COLORS[RESET]}"
        echo -e "2) ${COLORS[RED]}Delete a Network${COLORS[RESET]}"
        echo -e "3) ${COLORS[GREEN]}Create a New Network${COLORS[RESET]}"
        echo -e "4) ${COLORS[YELLOW]}Back to Main Menu${COLORS[RESET]}"
        echo -e "0) ${COLORS[WHITE]}Exit${COLORS[RESET]}"
        
        read -r network_choice
        
        case $network_choice in

            1)
                echo -e "${COLORS[YELLOW]}Enter Network Name/ID to inspect:${COLORS[RESET]}"
                read -r network_name
                docker network inspect "$network_name"
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
            2)
                echo -e "${COLORS[RED]}Enter Network Name/ID to delete:${COLORS[RESET]}"
                read -r network_to_delete
                docker network rm "$network_to_delete"
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
            3)
                echo -e "${COLORS[GREEN]}Enter New Network Name:${COLORS[RESET]}"
                read -r new_network_name
                echo -e "${COLORS[YELLOW]}Select Network Driver (bridge/overlay/host):${COLORS[RESET]}"
                read -r network_driver
                docker network create --driver "$network_driver" "$new_network_name"
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
            4)
                return
                ;;
            0)
                echo -e "${COLORS[GREEN]}Thank you for using Docker Management Tool v5.0${COLORS[RESET]}"
                exit 0
                ;;
            *)
                echo -e "${COLORS[RED]}Invalid option.${COLORS[RESET]}"
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
        esac
    done
}

# Volume Management Function
volume_management() {
    while true; do
        print_header
        display_volumes

        echo -e "${COLORS[YELLOW]}Volume Management Menu:${COLORS[RESET]}"
        echo -e "1) ${COLORS[BLUE]}Inspect Volume Details${COLORS[RESET]}"
        echo -e "2) ${COLORS[RED]}Delete a Volume${COLORS[RESET]}"
        echo -e "3) ${COLORS[GREEN]}Create a New Volume${COLORS[RESET]}"
        echo -e "4) ${COLORS[YELLOW]}Back to Main Menu${COLORS[RESET]}"
        echo -e "0) ${COLORS[WHITE]}Exit${COLORS[RESET]}"

        read -r volume_choice
        
        case $volume_choice in
            1)
                echo -e "${COLORS[YELLOW]}Enter Volume Name to inspect:${COLORS[RESET]}"
                read -r volume_name
                docker volume inspect "$volume_name"
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
            2)
                echo -e "${COLORS[RED]}Enter Volume Name to delete:${COLORS[RESET]}"
                read -r volume_to_delete
                docker volume rm "$volume_to_delete"
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
            3)
                echo -e "${COLORS[GREEN]}Enter New Volume Name:${COLORS[RESET]}"
                read -r new_volume_name
                docker volume create "$new_volume_name"
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
            4)
                return
                ;;
            0)    
                echo -e "${COLORS[GREEN]}Thank you for using Docker Management Tool v5.0${COLORS[RESET]}"
                exit 0
                ;;
            *)
                echo -e "${COLORS[RED]}Invalid option.${COLORS[RESET]}"
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
        esac
    done
}

# Container Health Check Function
container_health_check() {
    print_header
    echo -e "${COLORS[YELLOW]}Container Health Check:${COLORS[RESET]}"
    
    # Check overall Docker system health
    echo -e "${COLORS[CYAN]}Docker System Information:${COLORS[RESET]}"
    sudo docker info | grep -E "Containers:|Images:|Server Version:"
    
    echo -e "\n${COLORS[BLUE]}Detailed Container Health:${COLORS[RESET]}"
    sudo docker ps --format "{{.Names}}: {{.Status}}" | while read -r container_status; do
        container_name=$(echo "$container_status" | cut -d: -f1)
        status=$(echo "$container_status" | cut -d: -f2-)
        
        if [[ $status == *"Up"* ]]; then
            echo -e "${COLORS[GREEN]}$container_name: Healthy ✓${COLORS[RESET]}"
        elif [[ $status == *"Exited"* ]]; then
            echo -e "${COLORS[RED]}$container_name: Stopped ✗${COLORS[RESET]}"
        else
            echo -e "${COLORS[YELLOW]}$container_name: Unknown Status${COLORS[RESET]}"
        fi
    done
    
    read -n 1 -s -r -p "Press any key to continue..."
}

# Debugging Tools Function
debugging_tools() {
    while true; do
        print_header
        echo -e "${COLORS[YELLOW]}Debugging Tools Menu:${COLORS[RESET]}"
        echo -e "1) ${COLORS[CYAN]}Filter Logs with Timestamps${COLORS[RESET]}"
        echo -e "2) ${COLORS[BLUE]}Capture Container Events${COLORS[RESET]}"
        echo -e "3) ${COLORS[MAGENTA]}Live Container Resource Usage${COLORS[RESET]}"
        echo -e "4) ${COLORS[GREEN]}Detailed Container Logs${COLORS[RESET]}"
        echo -e "5) ${COLORS[YELLOW]}Back to Main Menu${COLORS[RESET]}"
        echo -e "0) ${COLORS[WHITE]}Exit${COLORS[RESET]}"
        
        read -r debug_choice
        
        case $debug_choice in
            1)
                echo -e "${COLORS[YELLOW]}Enter container name to filter logs:${COLORS[RESET]}"
                read -r container_name
                echo -e "${COLORS[YELLOW]}Enter start time (YYYY-MM-DD HH:MM:SS):${COLORS[RESET]}"
                read -r start_time
                echo -e "${COLORS[YELLOW]}Enter end time (YYYY-MM-DD HH:MM:SS):${COLORS[RESET]}"
                read -r end_time
                sudo docker logs --since "$start_time" --until "$end_time" "$container_name"
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
            2)
                echo -e "${COLORS[BLUE]}Capturing Docker events (press Ctrl+C to stop):${COLORS[RESET]}"
                sudo docker events
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
            3)
                echo -e "${COLORS[MAGENTA]}Live Container Resource Usage:${COLORS[RESET]}"
                sudo docker stats
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
            4)
                echo -e "${COLORS[GREEN]}Enter container name for detailed logs:${COLORS[RESET]}"
                read -r container_name
                echo -e "${COLORS[YELLOW]}Select log tail count (default 50):${COLORS[RESET]}"
                read -r log_count
                log_count=${log_count:-50}
                sudo docker logs -f --tail "$log_count" "$container_name"
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
            5)
                return
                ;;
            0)
                echo -e "${COLORS[GREEN]}Thank you for using Docker Management Tool v5.0${COLORS[RESET]}"
                exit 0
                ;;
            *)
                echo -e "${COLORS[RED]}Invalid option.${COLORS[RESET]}"
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
        esac
    done
}

# Define the trap handler for Ctrl+C
trap_ctrl_c() {
    echo -e "${COLORS[GREEN]}Thank you for using Docker Management Tool v5.0${COLORS[RESET]}"
    exit 0
}

# Main Menu Function
main_menu() {
    while true; do
        print_header
        
        echo -e "${COLORS[YELLOW]}Docker Management Tool - Main Menu${COLORS[RESET]}"
        echo -e "1) ${COLORS[CYAN]}Container Management${COLORS[RESET]}"
        echo -e "2) ${COLORS[BLUE]}Image Management${COLORS[RESET]}"
        echo -e "3) ${COLORS[GREEN]}Network Management${COLORS[RESET]}"
        echo -e "4) ${COLORS[MAGENTA]}Volume Management${COLORS[RESET]}"
        echo -e "5) ${COLORS[RED]}Container Health Check${COLORS[RESET]}"
        echo -e "6) ${COLORS[YELLOW]}Debugging Tools${COLORS[RESET]}"
        echo -e "0) ${COLORS[WHITE]}Exit${COLORS[RESET]}"
        
        read -r menu_choice
        
        case $menu_choice in
            1)
                manage_containers
                ;;
            2)
                manage_images
                ;;
            3)
                network_management
                ;;
            4)
                volume_management
                ;;
            5)
                container_health_check
                ;;
	        6)
                debugging_tools
                ;;
            0)
                echo -e "${COLORS[GREEN]}Thank you for using Docker Management Tool v5.0${COLORS[RESET]}"
                exit 0
                ;;
            *)
                echo -e "${COLORS[RED]}Invalid option.${COLORS[RESET]}"
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
        esac
    done
}

# Check Docker Installation
check_docker_installation() {
    if ! command -v docker &> /dev/null; then
        handle_error "Docker is not installed. Please install Docker first." 1
    fi
}

# Main Script Execution
main() {
    # Set trap for Ctrl+C
    trap 'trap_ctrl_c' SIGINT
    
    # Check if Docker is installed
    check_docker_installation
	
    # Log script start
    log_message "INFO" "Starting Docker Management Tool"
    
    # Start main menu
    main_menu
}

# Execute the main function
main
