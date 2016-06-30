##
# Environment Variables
##
MACHINE_NAME=dev-nfs
NETWORK_NAME=lamp-network

##
# ANSI Escape Codes
##
ESCAPE=\033
RESET=$(ESCAPE)[0m
GREEN=$(ESCAPE)[32m
BOL=$(ESCAPE)[2K$(ESCAPE)[0G

##
# Commands
##
init:
	@echo "$(GREEN)Creating a Docker machine <$(MACHINE_NAME)> for VirtualBox...$(RESET)"
	- @docker-machine create --driver virtualbox $(MACHINE_NAME)
	@echo "$(GREEN)Creating a Docker machine <$(MACHINE_NAME)> for VirtualBox:$(RESET) Done ✓"
	@echo ""
	@echo "$(GREEN)Setup NFS filesystem...$(RESET)"
	- @docker-machine-nfs $(MACHINE_NAME)
	@echo "$(GREEN)Setup NFS filesystem:$(RESET) Done ✓"
	@echo ""
	@echo "$(GREEN)Creating a LAMP Docker network...$(RESET)"
	- @docker network create --driver bridge $(NETWORK_NAME)
	@echo "$(GREEN)Creating a LAMP Docker network:$(RESET) Done ✓"
	@echo ""
	@echo "$(GREEN)Starting LAMP stack containers...$(RESET)"
	- @docker-compose up -d 2>/dev/null
	@echo "$(GREEN)Starting LAMP stack containers:$(RESET) Done ✓"

up:
	@echo "$(GREEN)Starting Docker machine <$(MACHINE_NAME)>...$(RESET)"
	- @docker-machine start $(MACHINE_NAME)
	@echo "$(GREEN)Starting Docker machine <$(MACHINE_NAME)>:$(RESET) Done ✓"
	@echo ""
	@echo "$(GREEN)Creating a LAMP Docker network...$(RESET)"
	- @docker network create --driver bridge $(NETWORK_NAME)
	@echo "$(GREEN)Creating a LAMP Docker network:$(RESET) Done ✓"
	@echo ""
	@echo "$(GREEN)Starting LAMP stack containers...$(RESET)"
	- @docker-compose up -d
	@echo "$(GREEN)Starting LAMP stack containers:$(RESET) Done ✓"

down:
	@echo "$(GREEN)Stopping Docker containers...$(RESET)"
	- @docker-compose stop
	@echo "$(GREEN)Stopping Docker containers:$(RESET) Done ✓"
	@echo ""
	@echo "$(GREEN)Cleanup containers/network...$(RESET)"
	- @docker-clean
	@echo "$(GREEN)Cleanup containers/network:$(RESET) Done ✓"
	@echo ""
	@echo "$(GREEN)Stopping Docker machine...$(RESET)"
	- @docker-machine stop $(MACHINE_NAME) 2>/dev/null
	@echo "$(GREEN)Stopping Docker machine:$(RESET) Done ✓"

start:
	@echo "$(GREEN)Creating a LAMP Docker network...$(RESET)"
	- @docker network create --driver bridge $(NETWORK_NAME)
	@echo "$(GREEN)Creating a LAMP Docker network:$(RESET) Done ✓"
	@echo ""
	@echo "$(GREEN)Starting LAMP stack containers...$(RESET)"
	- @docker-compose up -d
	@echo "$(GREEN)Starting LAMP stack containers:$(RESET) Done ✓"

stop:
	@echo "$(GREEN)Stopping Docker containers...$(RESET)"
	- @docker-compose stop
	@echo "$(GREEN)Stopping Docker containers:$(RESET) Done ✓"
	@echo ""
	@echo "$(GREEN)Cleanup containers/network...$(RESET)"
	- @docker-clean
	@echo "$(GREEN)Cleanup containers/network:$(RESET) Done ✓"

rename:
	find nginx/conf.d -name "*.conf" -print | xargs sed -i 's/var\/www\/html/app/g'