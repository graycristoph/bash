rex='rar$'
if [[ $(ls) =~ $rex ]]
then
  echo "rar encontrado"
else
  echo "no existe"
fi

select fname in *;
do
	echo you picked $fname \($REPLY\)
	break;
done
