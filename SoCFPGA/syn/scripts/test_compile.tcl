# Script de Synthèse en langage Tcl.
set project $env(PROJECT)

load_package flow
load_package incremental_compilation
load_package project
project_open $project

# On n'execute que l'analyse et l'élaboration pour vérifier
# que le code écrit est "synthétisable"

execute_module -tool map -args "--analysis_and_elaboration --incremental_compilation=full_incremental_compilation"

project_close

