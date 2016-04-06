clear
echo -e "\n\n${FG_GREEN} Creating ${FG_WHITE}package database${FG_GREEN}, this will take a few moments.\n"

cnt=0;
package_count=$(
    for line in "$($YUM list installed | sed '1,/^Installed Packages/Id')"; do 
        echo -e "$line\n"; 
    done | 
    cut -f1 -d' ' | 
    sed '/^\s*$/d' | wc -l
);

setterm -cursor off

echo -e "<packages>" > /etc/slingshot/packages.xml;
for line in "$($YUM list installed | sed '1,/^Installed Packages/Id')"; do 
    echo -e "$line\n"; 
done | 
cut -f1 -d' ' | 
sed '/^\s*$/d' | 

while read -r name; do
    echo -e "\t<package>"  >> /etc/slingshot/packages.xml;
    echo -e "\t\t<index>$((++cnt))</index>"  >> /etc/slingshot/packages.xml;

    name=$(echo $name | cut -f1 -d.); name=$(echo ${name//[[:blank:]]/});

    if [ "$(installed $name)" = "0" ]; then echo xxxxxxx ERROR xxxxxxxxx $name;  read x; fi

    echo -en "\e[s"
    line=$(echo -en "${FG_WHITE} Package${FG_GREEN}:${FG_WHITE} ${FG_CYAN}$name${FG_GREEN} ........................................................... " | cut -c1-90);

    echo -en "$line ${FG_WHITE}$((cnt)) ${FG_GREEN}of ${FG_WHITE}$package_count";
    echo -en "\e[u";

echo -e "\n$cnt" >> /etc/slingshot/lines;
    $YUM info $name | sed '1,/^installed packages/Id' | sed '/^available packages.*$/I,$ d' | sed 's/^$//' | 
    while read -r lines; do 
        key=$(echo $lines | cut -f1 -d:); 
        key=$(echo ${key,,} | sed 's/ /_/g');
        value=$(echo $lines | cut -f2- -d: | sed 's/^ *//' | sed 's/ *$//');

        if [ "$key" = "description" ]; then 
            echo -en "\t\t<$key>$value" >> /etc/slingshot/packages.xml;

            while read -r line; do 
                line=$(echo -e $line | sed 's/^://' | sed 's/^ //');
                echo -en " $line" >> /etc/slingshot/packages.xml;
            done;
            echo "</$key>" >> /etc/slingshot/packages.xml;
        else echo -e "\t\t<$key>$value</$key>" >> /etc/slingshot/packages.xml; fi
    done
    echo -e "\t</package>" >> /etc/slingshot/packages.xml;
done 
echo "<packages>" >> /etc/slingshot/packages.xml;

echo -e "\n\n${FG_GREEN} Finished creating the ${FG_WHITE}package database${FG_GREEN} file.\n"

sleep 3;
setterm -cursor on