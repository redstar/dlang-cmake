﻿# Special DMD compiler definitions

set(CMAKE_D_VERBOSE_FLAG "-v")
set(CMAKE_D_COMPILE_OPTIONS_PIC "")

set(CMAKE_D_FLAGS_INIT "")
set(CMAKE_D_FLAGS_DEBUG_INIT "-g")
set(CMAKE_D_FLAGS_RELEASE_INIT "-O -release -inline")
set(CMAKE_D_FLAGS_MINSIZEREL_INIT "-O -release")
set(CMAKE_D_FLAGS_RELWITHDEBINFO_INIT "-O -g -release")

set(CMAKE_SHARED_LIBRARY_D_FLAGS "")
set(CMAKE_SHARED_LIBRARY_CREATE_D_FLAGS "-shared")
