# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# compile C with /usr/bin/cc
# compile CUDA with /usr/local/cuda/bin/nvcc
# compile CXX with /usr/bin/c++
C_FLAGS = -O3 -DNDEBUG   -Wall -Wextra -Wpedantic -DMW_CUDA_ARCH=750 -D__MW_TARGET_USE_HARDWARE_RESOURCES_H__ -DROS2_PROJECT -DSTACK_SIZE=200000 -DMODEL=deployedPointPillarModel -std=gnu99

C_DEFINES = -DDEFAULT_RMW_IMPLEMENTATION=rmw_fastrtps_cpp -DRCUTILS_ENABLE_FAULT_INJECTION -DROS_PACKAGE_NAME=\"deployedpointpillarmodel\" -DSPDLOG_COMPILED_LIB

C_INCLUDES = -I/codegen/exe -I/home/aiv/YongJun_ws/src/deployedpointpillarmodel/include -I/home/aiv/YongJun_ws/src/deployedpointpillarmodel/include/deployedpointpillarmodel -I/usr/local/cuda/targets/x86_64-linux/include -isystem /home/aiv/YongJun_ws/install/vision_msgs/include -isystem /opt/ros/foxy/include 

CUDA_FLAGS =   -Xcompiler= -DMW_CUDA_ARCH=750 -D__MW_TARGET_USE_HARDWARE_RESOURCES_H__ -DROS2_PROJECT -DSTACK_SIZE=200000 -DMODEL=deployedPointPillarModel -arch sm_75 -rdc=true -Xcudafe "--display_error_number --diag_suppress=unsigned_compare_with_zero --diag_suppress=field_without_dll_interface --diag_suppress=base_class_has_different_dll_interface" -Xcompiler=-fPIC

CUDA_DEFINES = -DDEFAULT_RMW_IMPLEMENTATION=rmw_fastrtps_cpp -DRCUTILS_ENABLE_FAULT_INJECTION -DROS_PACKAGE_NAME=\"deployedpointpillarmodel\" -DSPDLOG_COMPILED_LIB

CUDA_INCLUDES = -I/codegen/exe -I/home/aiv/YongJun_ws/src/deployedpointpillarmodel/include -I/home/aiv/YongJun_ws/src/deployedpointpillarmodel/include/deployedpointpillarmodel -isystem=/home/aiv/YongJun_ws/install/vision_msgs/include -isystem=/opt/ros/foxy/include 

CXX_FLAGS = -O3 -DNDEBUG   -Wall -Wextra -Wpedantic -DMW_CUDA_ARCH=750 -D__MW_TARGET_USE_HARDWARE_RESOURCES_H__ -DROS2_PROJECT -DSTACK_SIZE=200000 -DMODEL=deployedPointPillarModel -std=gnu++17

CXX_DEFINES = -DDEFAULT_RMW_IMPLEMENTATION=rmw_fastrtps_cpp -DRCUTILS_ENABLE_FAULT_INJECTION -DROS_PACKAGE_NAME=\"deployedpointpillarmodel\" -DSPDLOG_COMPILED_LIB

CXX_INCLUDES = -I/codegen/exe -I/home/aiv/YongJun_ws/src/deployedpointpillarmodel/include -I/home/aiv/YongJun_ws/src/deployedpointpillarmodel/include/deployedpointpillarmodel -I/usr/local/cuda/targets/x86_64-linux/include -isystem /home/aiv/YongJun_ws/install/vision_msgs/include -isystem /opt/ros/foxy/include 

