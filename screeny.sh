#!/usr/bin/zsh
#
# Windows Screenfetch (Without the Screenshot functionality)
# Hacked together by Nijikokun <nijikokun@gmail.com>
# License: AOL <aol.nexua.org>

version='0.4'

# Displayment
display=( Host Cpu OS Arch Shell Motherboard HDD Memory Uptime Resolution DEe WMe WMTheme Font )

# # Color Loop
# bld=$'\e[1m'
# rst=$'\e[0m'
# inv=$'\e[7m'
# und=$'\e[4m'
# f=3 b=4
# for j in f b; do
#   for i in {0..7}; do
#     printf -v $j$i %b "\e[${!j}${i}m"
#   done
# done

# Debugging
debug=

Debug () {
	echo -e "\e[1;31m:: \e[0m$1"
}

# Flag Check
while getopts "vVh" flags; do
	case $flags in
		h)
			echo -e "${und}Usage${rst}:"
			echo -e "  screeny [Optional Flags]"
			echo ""
			echo "WinScreeny - A CLI Bash Script to show System Information for Windows!"
			echo ""
			echo -e "${und}Options${rst}:"
			echo -e "    ${bld}-v${rst}                 Verbose / Debug Output"
			echo -e "    ${bld}-V${rst}                 Display script version"
			echo -e "    ${bld}-h${rst}                 Display this file"
			exit;;
		V)
			echo -e "${und}WinScreeny${rst} - Version ${version}"
			echo -e "Copyright (C) Nijiko Yonskai (nijikokun@gmail.com)"
			echo ""
			echo -e "This is free software, under the AOL license: http://aol.nexua.org"
			echo -e "Source can be downloaded from: https://github.com/Nijikokun/WinScreeny"
			exit;;
		v) debug=1 continue;;
	esac
done

# Prevent Unix Output
unameOutput=`uname`
if [[ unameOutput == 'Linux' ]]; then
    echo 'This script is for Windows, silly!'
    exit 0
fi

# Begin Detection
detectHost () {
	user=$(echo "$USER")
	host=$(hostname)
	[[ "$debug" -eq "1" ]] && Debug "Finding hostname, and user.... Found as: '$user@$host'"
}

detectCpu () {
	cpu=$(awk -F':' '/model name/{ print $2 }' /proc/cpuinfo | head -n 1 | tr -s " " | sed 's/^ //')
	[[ "$debug" -eq "1" ]] && Debug "Finding cpu.... Found as: '$cpu'"
}

detectOS () {
	os=`wmic os get name | head -2 | tail -1`
	os=`expr match "$os" '\(Microsoft Windows [A-Za-z0-9]\+\)'`
	[[ "$debug" -eq "1" ]] && Debug "Finding OS.... Found as: '$os'"
}

detectArch () {
	arch=`wmic os get OSArchitecture | head -2 | tail -1 | tr -d '\r '`
	[[ "$debug" -eq "1" ]] && Debug "Finding Architecture.... Found as: '$arch'"
}

detectHDD () {
	size=`df -H | grep -vE '^[A-Z]\:\/|File' | awk '{ print $2 }' | head -1 | tr -d '\r '`
	free=`df -H | grep -vE '^[A-Z]\:\/|File' | awk '{ print $4 }' | head -1 | tr -d '\r '`
	[[ "$debug" -eq "1" ]] && Debug "Finding HDD Size, and Free Space.... Found as: '$free / $size'"
}

detectResolution () {
	width=`wmic desktopmonitor get screenwidth | grep -vE '[a-z]+' | tr -d '\r\n '`
	height=`wmic desktopmonitor get screenheight | grep -vE '[a-z]+' | tr -d '\r\n '`
	[[ "$debug" -eq "1" ]] && Debug "Finding Screen Resolution.... Found as: '$width / $height'"
}

detectUptime () {
	uptime=`awk -F. '{print $1}' /proc/uptime`
	secs=$((${uptime}%60))
	mins=$((${uptime}/60%60))
	hours=$((${uptime}/3600%24))
	days=$((${uptime}/86400))
	uptime="${mins}m"

	if [ "${hours}" -ne "0" ]; then
	  uptime="${hours}h ${uptime}"
	fi

	if [ "${days}" -ne "0" ]; then
	  uptime="${days}d ${uptime}"
	fi

	[[ "$debug" -eq "1" ]] && Debug "Finding Uptime.... Found as: '$uptime${rst}'"
}

detectMemory () {
	total_mem=$(awk '/MemTotal/ { print $2 }' /proc/meminfo)
	totalmem=$((${total_mem}/1024))
	free_mem=$(awk '/MemFree/ { print $2 }' /proc/meminfo)
	used_mem=$((${total_mem} - ${free_mem}))
	usedmem=$((${used_mem}/1024))
	mem="${usedmem}MB / ${totalmem}MB"

	[[ "$debug" -eq "1" ]] && Debug "Finding Memory.... Found as: '$mem${rst}'"
}

detectShell () {
	myshell=$(echo $SHELL | awk -F"/" '{print $NF}')
	[[ "$debug" -eq "1" ]] && Debug "Finding Shell.... Found as: '$myshell'"
}

detectMotherboard () {
    board=`wmic baseboard get product | tail -2 | tr -d '\r '`
    [[ "$debug" -eq "1" ]] && Debug "Finding Motherboard.... Found as: '$board'"
}

detectDEe () {
	winver=`wmic os get version | grep -o '^[0-9]'`
	if [[ "$winver" == "7" ]]; then
		de='Aero'
	elif [[ "$winver" == "6" ]]; then
		de='Aero'
	else
		de='Luna'
	fi
	[[ "$debug" -eq "1" ]] && Debug "Finding Desktop Environment.... Found as: '$de'"
}

detectWMe () {
	wm=`tasklist | grep -o 'bugn' | tr -d '\r \n'`
	if [[ "$wm" == "bugn" ]]; then
		wm="bug.n"
	else
		wm="DWM"
	fi
	[[ "$debug" -eq "1" ]] && Debug "Finding Window Manager.... Found as: '$wm'"
}

detectWMTheme () {
	themeFile="$(reg query 'HKCU\Software\Microsoft\Windows\CurrentVersion\Themes' /v 'CurrentTheme' | grep -o '[A-Z]:\\.*')"
	theme=$(echo $themeFile | awk -F"\\" '{print $NF}' | grep -o '[0-9A-z. ]*$' | grep -o '^[0-9A-z ]*')
	[[ "$debug" -eq "1" ]] && Debug "Finding Window Theme.... Found as: '$theme'"
}

detectFont () {
	font=$(cat $HOME/.minttyrc | grep '^Font=.*' | grep -o '[0-9A-z ]*$')
	[[ "$debug" -eq "1" ]] && Debug "Finding Font.... Found as: '$font'"
}

# Loops :>
for i in "${display[@]}"; do
	[[ "${display[*]}" =~ "$i" ]] && detect${i}
done

source ~/.oh-my-zsh/lib/spectrum.zsh

f1='[38;5;124m'
f2='[38;5;034m'
f3='[38;5;184m'
f4='[38;5;039m'
f7='[00m'

# Output
# cat << EOF

echo "$f1         ,.=:^!^!t3Z3z.,"
echo "$f1        :tt:::tt333EE3                  ${f1}${user}${f7}@${f3}${host}"
echo "$f1        Et:::ztt33EEE  $f2@Ee.,      ..,"
echo "$f1       ;tt:::tt333EE7 $f2;EEEEEEttttt33#   ${f1}OS: ${f7}${os} ${arch}"
echo "$f1      :Et:::zt333EEQ.$f2 SEEEEEttttt33QL   ${f1}CPU: ${f7}${cpu}"
echo "$f1      it::::tt333EEF $f2@EEEEEEttttt33F    ${f1}HDD: ${f7}$free / $size"
echo "$f1     ;3=*^\`\`\`'*4EEV $f2:EEEEEEttttt33@.    ${f1}Memory: ${f7}${mem}"
echo "$f4     ,.=::::it=., $f1\` $f2@EEEEEEtttz33QF     ${f1}Uptime: ${f7}$uptime"
echo "$f4    ;::::::::zt33)   $f2'4EEEtttji3P*      ${f1}Resolution: ${f7}$width x $height"
echo "$f4   :t::::::::tt33.$f3:Z3z..  $f2\`\` $f3,..g.      ${f1}Motherboard: ${f7}$board"
echo "$f4   i::::::::zt33F$f3 AEEEtttt::::ztF       ${f1}Shell: ${f7}$myshell"
echo "$f4  ;:::::::::t33V $f3;EEEttttt::::t3        ${f1}DE: ${f7}$de"
echo "$f4  E::::::::zt33L $f3@EEEtttt::::z3F        ${f1}WM: ${f7}$wm"
echo "$f4 {3=*^\`\`\`'*4E3) $f3;EEEtttt:::::tZ\`        ${f1}WM Theme: ${f7}$theme"
echo "$f4             \` $f3:EEEEtttt::::z7          ${f1}Font: ${f7}$font"
echo "$f3                 $f3'VEzjt:;;z>*\`"

# EOF
