#!/bin/sh
#### TurkmmoSF start scripts ####
v_base=$PWD
v_mt2f=$v_base
v_bakf=$v_base/baks
v_dbf=$v_bakf/db
v_fsf=$v_bakf/fs
v_foldername=srv1
v_localename=turkey
v_bin=python2.7

fecho () { echo -e "\033[35m$1\033[0m"; }
_fecho () { echo -e "\033[4;35m$1\033[0m"; }
f_echo () { echo -e "\033[1;35m$1\033[0m"; }
becho () { echo -e "\033[34m$1\033[0m"; }
yecho () { echo -e "\033[33m$1\033[0m"; }
_yecho () { echo -e "\033[4;33m$1\033[0m"; }
y_echo () { echo -e "\033[1;33m$1\033[0m"; }
gecho () { echo -e "\033[32m$1\033[0m"; }
recho () { echo -e "\033[31m$1\033[0m"; }
_recho () { echo -e "\033[4;31m$1\033[0m"; }
r_echo () { echo -e "\033[1;31m$1\033[0m"; }
cecho () { echo -e "\033[36m$1\033[0m"; }
ruecho () { echo -e "\033[1;4;33;41m$1\033[0m"; }
bnecho () {  echo -e "\033[1;4;30;47m$1\033[0m"; }
rnecho () {  echo -e "\033[1;4;30;41m$1\033[0m"; }
abio () { echo -e "\033[31m$1\033[32m$1\033[33m$1\033[34m$1\033[35m$1\033[36m$1\033[37m$1\033[0m"; }

r_echo ".:. YoneticiPaneli .:."
gecho "Ne yapmak istersin?"
recho "1. Baslat (baslat)
1s. Secmeli Baslat (baslats)
2. Durdur (durdur|kapat)
2s. Secmeli durdur(durdurs|kapats)
3. Temizle (temizle)
33. Hepsini temizle (temizleh)
4. Yedekle mysql/db (bak1|db|db_backup)
5. Yedekle game/fs (bak2|fs|fs_backup)
666. Kanallari yarat (yarat)
777. Questleri derle (quest)
888. Game Symlink (symlink)
999. Ara (ara)"
_yecho "1h. Baslat+Vrunner (baslath)"
_yecho "2h. Durdur+Vrunner (durdurh|kapath)"
_recho "0. Cik (cik)"

if [ -z $1 ]; then
	read phase
else
	phase=$1
fi

case  $phase in
1|baslat)
	cd $v_mt2f
	$v_bin start.py
	cd $v_base
	cecho "start completed"
;;
1s|baslats)
	cd $v_mt2f
	$v_bin start.py --prompt
	cd $v_base
	cecho "starti completed"
;;
1h|baslath)
	cd $v_mt2f
	sh daemon.sh &
	cd $v_base
	cecho "startall completed"
;;
2|durdur|kapat)
	cd $v_mt2f
	$v_bin stop.py
	cd $v_base
	cecho "stop completed"
;;
2s|durdurs|kapats)
	cd $v_mt2f
	$v_bin stop.py --prompt
	cd $v_base
	cecho "stopi completed"
;;
2h|durdurh|kapath)
	ps afx | grep 'sh daemon.sh' | grep -v grep | awk '{print $1}' | xargs kill -9
	cd $v_mt2f
	$v_bin stop.py
	cd $v_base
	cecho "stopall completed"
;;
3|temizle)
	cd $v_mt2f
	$v_bin clear.py
	cd $v_base
	cecho "clean completed"
;;
33|temizleh)
	cd $v_mt2f
	$v_bin clear.py
	cd $v_base
	make -C $v_dbf clean
	make -C $v_fsf clean
	cecho "cleanall completed"
;;
4|bak1|db|db_backup)
	make -C $v_dbf dump
	cecho "bak db completed"
;;
5|bak2|fs|fs_backup)
	make -C $v_fsf dump
	cecho "bak fs completed"
;;
666|yarat)
	cd $v_mt2f
	# rm -rf $v_foldername/logs $v_foldername/auth $v_foldername/chan $v_foldername/db
	$v_bin gen.py
	cd $v_base
	cecho "gen completed"
;;
777|quest)
	cd $v_mt2f/$v_foldername/share/locale/$v_localename/quest
	chmod u+x qc
	$v_bin pre_qc.py -ac
	cd $v_base
	cecho "quest completed"
;;
888|symlink)
	cd $v_mt2f/$v_foldername/share/bin
	rm -f game db
	ln -s /turkmmosf/source/Server/game/game_symlink game
	ln -s /turkmmosf/source/Server/db/db_symlink db
	cecho "symlink completed"
;;
999|ara)
	find $v_base -name "CONFIG" -print -exec cat {} \; | grep -e PORT -e HOSTNAME
;;
0|cik)
	abio ".:|:."
;;
*)
	cecho "$Secenek bulunamadi"
esac



