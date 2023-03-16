#!/bin/bash



rm -rf ~/bin
rm -rf interpNameAll
rm -rf interpNameUniq

mkdir ~/bin
touch interpNameAll
touch interpNameUniq


for var in $(find /usr/bin)
do
	c=$(head -1 $var | cut -c 1,2)
	if [[ '#!' == $c ]];
	then
	filename=$(basename "$var")
	interprit=$(./getInterpreter "$(head -1 $var)")
	echo "$interprit" >> interpNameAll
	cp "$var" ~/bin/$filename.$interprit
	fi
done

(sort -u interName1) > interpNameUniq




for str in $(cat interpNameUniq);
do	count=$(grep $str interpNameAll | wc -l)
	
	echo "- Interpreter $str contains in $count files"
done



echo "Specify which interpreter you want to delete: "

select interp in $(cat interpNameUniq) stop_program;
do
	if [[ $interp == 'stop_program' ]]
	then
		break
	fi
	rm -rf ~/bin/*.$interp
	echo "Files of $interp deleteted"

done
exit 0

