@echo off


rem set arguments
set _MS_VS_SHELL=%1
set _MS_VS_SHELL_ARG=%2
set _MSB_RSP_FILE=%3


call %_MS_VS_SHELL% %_MS_VS_SHELL_ARG%


rem exec MSBuild
msbuild.exe @%_MSB_RSP_FILE%

