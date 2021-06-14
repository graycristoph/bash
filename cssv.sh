#!/bin/bash
reset="\\e[0m"
red="\\e[31;1m"
blue="\\e[34;1m"
green="\\e[32;1m"
yellow="\\e[33;1m"
white="\\e[39;1m"
Date=$(date "+%F")
version="     3.2.1v"
clear -T $TERM
#-----------------------------------------------------------------------------
function color(){
  local fun=$1
  printf "$green"; $fun; printf "$reset"
  unset -v fun
}
#-----------------------------------------------------------------------------
function bar(){
  len=68
  char="x"
  blank="                                                                      "
#
  bar=$(for (( i=1; i <= $len; i++ )); do echo -n "${char}"; done)
#
  for (( i=1; i <= $len; i++ ))
  do
    echo -ne "${green}\r${bar:0:$i}${reset}"
    sleep .1
  done
  echo
}
#-----------------------------------------------------------------------------
function label_cris(){
  cat <<- 'EOF'


 ██████╗██████╗ ██╗███████╗    ████████╗ ██████╗  ██████╗ ██╗     ███████╗
██╔════╝██╔══██╗██║██╔════╝    ╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██╔════╝
██║     ██████╔╝██║███████╗       ██║   ██║   ██║██║   ██║██║     ███████╗
██║     ██╔══██╗██║╚════██║       ██║   ██║   ██║██║   ██║██║     ╚════██║
╚██████╗██║  ██║██║███████║       ██║   ╚██████╔╝╚██████╔╝███████╗███████║
 ╚═════╝╚═╝  ╚═╝╚═╝╚══════╝       ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚══════╝

EOF
}
#-----------------------------------------------------------------------------
function label_bye(){
cat <<- 'EOF'
   ____    U  ___ u   U  ___ u  ____          ____   __   __U _____ u
U /"___|u   \/"_ \/    \/"_ \/ |  _"\      U | __")u \ \ / /\| ___"|/
\| |  _ /   | | | |    | | | |/| | | |      \|  _ \/  \ V /  |  _|"
 | |_| |.-,_| |_| |.-,_| |_| |U| |_| |\      | |_) | U_|"|_u | |___
  \____| \_)-\___/  \_)-\___/  |____/ u      |____/    |_|   |_____|
  _)(|_       \\         \\     |||_        _|| \\_.-,//|(_  <<   >>
 (__)__)     (__)       (__)   (__)_)      (__) (__)\_) (__)(__) (__)
EOF
}
#-----------------------------------------------------------------------------
# trap ctrl-c and call ctrl_c()

trap ctrl_c INT
function ctrl_c(){
  clear -T $TERM
  color label_bye
  bar
  exit
}

#------------------------------------------------------------------------------
 function descrip_cssv(){
 cat <<- 'EOF'

Titulo:      Resumen de Cambios y Validador de Esquema (CSSV)
Autor:       Cristofer H. Garay G.
Correo:      cgaray@syesoftware.com
descripcion: Se realiza una comparacion entre el archivo json
             origanl y el modificado o carpeta a carpeta para
             crear el resumen de los cambios realizados.
EOF
  echo -e "Version:$version\n"
}
#-----------------------------------------------------------------------------
function help_cssv(){
cat <<- 'EOF'
USE:

    cssv [OPTIONS]

OPTIONS:

    -p0                Ruta raíz (root)
    -p1                Ruta del archivo o carpeta de los
                       json sin modificar.
    -p2                Ruta del archivo o carpeta de los
                       json modificados.
    -sc| --save-color  Guarda una copia del resumen de cambios
                       para ser visualizados en una consola bash
                       a color.
    -SC| --schema      Ruta del esquema para validar la estrutura
                       del los json.
    -v | --version     Muestra la version y sale del script.
    -h | --help        Muestra la ayuda y sale del scrip.


EXAMPLES:

  [[ Change Summary ]]
  cssv -p0 $(pwd) -p1 folder1 -p2 folder2 -o resumen.txt -sc resumen.bash

  [[ Schema Validation ]]
  cssv -p0 $(pwd) -p2 folder2 -SC esquema.json

EOF
}
#-----------------------------------------------------------------------------
while [ -n "$1" ]
do
 case "$1" in
  -p0)
    path0="$2"; shift ;;
  -p1) #
    path1="$2"; shift ;;
  -p2) #
    path2="$2"; shift ;;
  -sc| --save-color)
    namebash="$2"; shift ;;
  -SC| --schema)
    schema="$2"; shift ;;
   -o| --out)
    out="$2"; shift ;;
  -v|--version) # version
    color label_cris; color descrip_cssv; shift ;;
  -h|--help) # help
    color label_cris; color help_cssv; shift ;;
   *) color label_cris; echo -e "${red}Opcion $1 no reconizida.${reset}" ;;
 esac
shift
done

#-----------------------------------------------------------------------------
# Change Summary
#-----------------------------------------------------------------------------

if [[ -n "$path0" && -n "$path1" && -n "$path2" && -n "$out" ]]
then
  color label_cris
  color descrip_cssv
  sleep 1
  clear -T $TERM
  folder1=$path0/$path1
  folder2=$path0/$path2
  num=$(ls $folder1 | wc -l)
  for (( i = 1; i <= $num; i++ ))
  do
    file1=$(ls $folder1 | grep '.*\.json' | sed -n "${i}p")
    file2=$(ls $folder2 | grep '.*\.json' | sed -n "${i}p")
    ans=$(diff -q $(echo "$folder1/$file1 $folder2/$file2"))
    if [[ -n "$ans" ]]
    then
      if [ -n "$namebash" ]; then
        echo "\\n\\n$(wc -l $path1/$file1 | sed 's/[[:blank:]]\+/:/g') " >> $namebash
        echo  "$(wc -l $path2/$file2 | sed 's/[[:blank:]]\+/:/g')\\n" >> $namebash
      fi
      echo -ne "\n$(wc -l $path1/$file1 | sed 's/[[:blank:]]\+/:/g')" >> ${out}
      echo " $(wc -l $path2/$file2 | sed 's/[[:blank:]]\+/:/g')" >> ${out}
      sdiff -l $folder1/$file1 $folder2/$file2 | \
      cat -nvE |\
      sed 's/\^M//g' |\
      sed 's/^[[:blank:]]\+//g' | \
      sed 's/[[:blank:]]\{2,\}/ /g' | \
      while read line
      do
        if [[ "$line" =~ "<$" ]]
        then
          echo "$line" | sed 's/\$//' >> ${out}
          if [ -n "$namebash" ]; then
          echo "${red}$line${reset}\\n" | sed 's/<\$//' >> $namebash
          fi
        elif [[ "$line" =~ "\($" ]]
        then
          if [ -n "$namebash" ]; then
          echo "${blue}$line${reset}\\n" | sed 's/(\$//' >> $namebash
          fi
        elif [[ $line =~ [[:blank:]]\> ]]
        then
          echo "$line" | sed 's/\$//' >> ${out}
          if [ -n "$namebash" ]; then
          echo "${green}$line${reset}\\n" | sed 's/\(\$\|>\)//g' >> $namebash
          fi
        elif [[ $line =~ [[:blank:]]\|[[:blank:]] ]]
        then
          echo "$line" | sed 's/\$//' >> ${out}
          if [ -n "$namebash" ]; then
          echo "${yellow}$line${reset}\\n" | sed 's/\(\$\||\)//g' >> $namebash
          fi
        fi
      done
    else
      echo -e "\n$path1/$file1 $path2/$file2\nSin cambios" >> ${out}
      if [ -n "$namebash" ]; then
      echo "\\n\\n${white}$path1/$file1 $path2/$file2${reset}\\n" >> $namebash
      echo "${blue}Sin cambios${reset}" >> $namebash
      fi
    fi
  done
  if [ -e $namebash ]
  then
    echo -e $(cat $namebash) | more
  fi
fi

#-----------------------------------------------------------------------------
#      Schema Validation
#-----------------------------------------------------------------------------

if [[ -n "$schema" && -n "$path0" && -n "$path2" ]]
then
  color label_cris; color descrip_cssv; sleep 1
  clear -T $TERM
  function schema(){
    local path0="$1"
    local path1="$2"
    local schema="$3"
    local json="$4"
    echo -ne "{\n" \
    "  \"schema\":"
    cat -v $schema | sed 's/\^M//g'
    echo -ne "\n   \"json\":"
    cat $path0/$path1/$json
    echo -e "\n}"
  }
  ls $path0/$path2 | \
  grep '.*\.json' | \
  while read line
  do
    if [ -e "$schema" ]; then
     schema $path0 $path2 $schema $line > SchemaJson.json
    fi
    if [[ -e "SchemaJson.json" ]]
    then
      url=$(wget -qO- --post-file=SchemaJson.json https://assertible.com/json)
     if [[ -z "$url" ]]
     then
       echo -e "${white}$path2/$line${reset} ${red}\"valid\": False${reset}"
       if [ -n "$out" ]; then echo " $path2/$line  \"valid\": False" >> $out; fi
         curl -Ss -d'@SchemaJson.json' 'https://assertible.com/json'
         echo
       if [ -n "$out" ]; then echo " $url" | sed 's/$/\n/g' >> $out; fi
     else
       echo -e "${white}$path2/$line${reset} ${green}\"valid\": True${reset}"
       if [ -n "$out" ]; then echo "$path2/$line  \"valid\": True" >> $out; fi
     fi
    fi
  done
  if [[ -e "SchemaJson.json" ]]
  then
    rm SchemaJson.json
 fi
fi
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
