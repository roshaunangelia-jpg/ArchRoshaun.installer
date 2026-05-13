================================ ArchRoshaun V1.1 ================================

1. About
	1.1. Info
		ArchRoshaun V1.1 is a custom OS layer built on Arch Linux, It
		replaces the traditional desktop with a Python-based UI and
		Github-driven update system
	1.2. Author and Credits
		Scripter: Roshaun
		System services/systemd: Roshaun
		Everything else?: Roshaun		

		Some images may have came from online sources
	1.3. Features:
		* Custom Tk desktop enviroment
		* GitHub-based system updates
		* Boot-time auto launcher via systemd
		* Modular OS structure (view in /opt)
		* Made for programmers

2. Installation
	2.1. Connect to WiFi/LAN/WAN Network
		The system requires online installation because it uses GitHub, a
		cloud based platform built on top of Git
	2.2. Install dependencies
		Run the command below to install git
		
		> sudo pacman -s git
	
	2.3 Pull installer git file
		Clone the installer
		
		> git clone git@github.com:roshaunangelia-jpg/ArchRoshaun.installer.git
		
		After cloning, find installer.sh and run it, the computer should start
		downloading repositories and dependencies, it might take some time
	2.4 Set up userspace
		Answer the questions after installation is complete, the answers will
		reflect on your user data such as your username and password

3. Note
	This is experimental software ( for now )
	install on production systems with caution
	built for learning/customization

		
		
# ArchRoshaun.installer
