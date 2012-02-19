cmake_minimum_required(VERSION 2.6)

add_subdirectory(astromobile)
add_subdirectory(benefit)
add_subdirectory(common)

message(WARNING "-------------------------- README ------------------------------\n" 
                "This will NOT compile all of simon-tools but exclude" 
		 "simon-touch and simone." 
		 "Please use the individual subfolders to build those " 
		 "projects.")

