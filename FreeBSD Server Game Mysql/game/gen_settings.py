#### Luigina start scripts ####
from platform import system as p_system
v_system = p_system()

from subprocess import check_output as sp_co, call as sp_call, CalledProcessError as sp_CalledProcessError
def fShell(szCmd, bRet=False):
	try:
		if bRet:
			return sp_co(szCmd, shell=True)[:-1]	# remove final \n
		else:
			return sp_call(szCmd, shell=True)
	except sp_CalledProcessError:
		return -1

if v_system=="FreeBSD":
	v_adminPageLocalIP=fShell("ifconfig em0 | grep -Eo 'inet ([0-9]{1,3}\.){3}([0-9]{1,3})' | awk '{print $2}'", True)
elif v_system=="Linux":
	v_adminPageLocalIP=fShell("ifconfig eth0 | grep -Eo 'inet addr:([0-9]{1,3}\.){3}([0-9]{1,3})' | awk -F':' '{print $2}'", True)
elif v_system=="Windows":
	v_adminPageLocalIP="127.0.0.1"

v_adminPagePassword='58948HG83H4G8H84G'				#adminpage_password
v_serverHostname='127.0.0.1'						#host for sql connections
v_serverUserPass='mt2 mt2'							#user&pwd for sql connections
v_serverData="%s %s"%(v_serverHostname, v_serverUserPass)	#host, user and pwd for db sql connections

# v_bindHostname='10.0.2.15'
# v_proxyHostname='127.0.0.1'
v_dbHostname='127.0.0.1'#default hostname for db
v_dbPort=30000		#default port for db (the others will be automatically calculated)
v_mysqlport=3306	#default mysql port (3306 or 0)
v_logFolder='logs'		#name of the all_log path
v_chanFolder='chan/'		#name of the channel path
v_chanPath='../'		#workaround that should be equivalent to $v_charS paths per ../

M2SD = {
	"account":		"account",
	"common":		"common",
	"hotbackup":	"hotbackup",
	"log":			"log",
	"player":		"player",
}

class M2TYPE:
	SERVER, DB, AUTH, CHANFOLDER, CHANNEL, CORE = xrange(6)
	NOCHAN = 0

class PORT:
	RANDOMI = v_dbPort	# a random port will start from such value
	RANDOM = 0
	PORT, P2P_PORT, DB_PORT, BIND_PORT = xrange(4)
	lPORT = ("PORT", "P2P_PORT", "DB_PORT", "BIND_PORT")

M2CONFIG = {
	"db": {
		"general": (
			("SQL_ACCOUNT = \\\"%s %s %s %d\\\"", (v_serverHostname, M2SD["account"], v_serverUserPass, v_mysqlport)),
			("SQL_COMMON = \\\"%s %s %s %d\\\"", (v_serverHostname, M2SD["common"], v_serverUserPass, v_mysqlport)),
			("SQL_PLAYER = \\\"%s %s %s %d\\\"", (v_serverHostname, M2SD["player"], v_serverUserPass, v_mysqlport)),
			("SQL_HOTBACKUP = \\\"%s %s %s %d\\\"", (v_serverHostname, M2SD["hotbackup"], v_serverUserPass, v_mysqlport)),
			#
			("TABLE_POSTFIX = \\\"%s\\\"", ("")),
			#
			# ("BIND_PORT = %s", (v_dbPort,)),
			# ("DB_SLEEP_MSEC = 10", ()),
			("CLIENT_HEART_FPS = %u", (25)),
			# ("HASH_PLAYER_LIFE_SEC = %u", (600)),
			("PLAYER_ID_START = %u", (100)),
			("PLAYER_DELETE_LEVEL_LIMIT = %u", (70)),
			# ("PLAYER_DELETE_LEVEL_LIMIT_LOWER = %u", (15)),
			("ITEM_ID_RANGE = %u %u ", (100000000, 200000000)),
			# ("BACKUP_LIMIT_SEC = %u", (3600)),
			("DISABLE_HOTBACKUP = %u", (True)),
			("LOCALE = %s", ("latin1")),
		),
		"extra": (
			("PROTO_FROM_DB = %u", (False)),
			("MIRROR2DB = %u", (True)),
		)
	},
	"core": {
		M2TYPE.AUTH: (
			("AUTH_SERVER: %s", ("master")),
			("PLAYER_SQL: %s %s %d", (v_serverData, M2SD["account"], v_mysqlport)),
		),
		M2TYPE.CORE: (
			("PLAYER_SQL: %s %s %d", (v_serverData, M2SD["player"], v_mysqlport)),
		),
		"general": (
			("DB_ADDR: %s", (v_dbHostname)),
			("COMMON_SQL: %s %s %d", (v_serverData, M2SD["common"], v_mysqlport)),
			("LOG_SQL: %s %s %d", (v_serverData, M2SD["log"], v_mysqlport)),
		),
		"extra": (
			#("DB_LOG_LEVEL: %u", (1)),
		),
	},
}

COMMONCHAN=(
	{
		"name": "core1",
		"type": M2TYPE.CORE,
		"port": PORT.RANDOM,
		"p2p_port": PORT.RANDOM,
		"config": M2CONFIG["core"],
		"maps": "1 3 4 21 23 24 41 43 44",
	},
	{
		"name": "core2",
		"type": M2TYPE.CORE,
		"port": PORT.RANDOM,
		"p2p_port": PORT.RANDOM,
		"config": M2CONFIG["core"],
		"maps": "61 62 63 64 65 66 67 68 69 70 71 72 73 104 208 216 217 351 352",
	},
	{
		"name": "core3",
		"type": M2TYPE.CORE,
		"port": PORT.RANDOM,
		"p2p_port": PORT.RANDOM,
		"config": M2CONFIG["core"],
		"maps": "301 302 303 304",
	},
)

CHAN99=(
	{
		"name": "core99",
		"type": M2TYPE.CORE,
		"port": PORT.RANDOM,
		"p2p_port": PORT.RANDOM,
		"config": M2CONFIG["core"],
		"maps": "81 110 113",
	},
)

M2S=(
	{
		"name": "srv1",
		"type": M2TYPE.SERVER,
		"isextra": True,
		"sub": (
			{
				"name": "db",
				"type": M2TYPE.DB,
				"port": PORT.RANDOM,
				"config": M2CONFIG["db"],
			},
			{
				"name": "auth",
				"type": M2TYPE.AUTH,
				"port": PORT.RANDOM,
				"p2p_port": PORT.RANDOM,
				"config": M2CONFIG["core"],
			},
			{
				"name": "chan",
				"type": M2TYPE.CHANFOLDER,
				"sub": (
					{
						"name": "ch1",
						"type": M2TYPE.CHANNEL,
						"chan": 1,
						"sub": COMMONCHAN,
					},
					# {
					# 	"name": "ch2",
					# 	"type": M2TYPE.CHANNEL,
					# 	"chan": 2,
					# 	"sub": COMMONCHAN,
					# },
					# {
					# 	"name": "ch3",
					# 	"type": M2TYPE.CHANNEL,
					# 	"chan": 3,
					# 	"sub": COMMONCHAN,
					# },
					# {
                    #     "name": "ch4",
					# 	"type": M2TYPE.CHANNEL,
					# 	"chan": 4,
					# 	"sub": COMMONCHAN,
					# },
					{
						"name": "ch99",
						"type": M2TYPE.CHANNEL,
						"chan": 99,
						"sub": CHAN99,
					},
				)
			}
		)
	},
)

CustIpfwList="""#!/bin/sh
IPF="ipfw -q add"
ipfw -q -f flush

#loopback
$IPF 10 allow all from any to any via lo0
$IPF 20 deny all from any to 127.0.0.0/8
$IPF 30 deny all from 127.0.0.0/8 to any
$IPF 40 deny tcp from any to any frag

# stateful
$IPF 50 check-state
$IPF 60 allow tcp from any to any established
$IPF 70 allow all from any to any out keep-state
$IPF 80 allow icmp from any to any

# open port ftp (20, 21), ssh (22), mail (25)
# http (80), https (443), dns (53), mysql (3306)
default_udp_yes_ports='53'
default_tcp_yes_ports='22 53 3306'
default_tcp_no_ports=''

# here auth PORTs for "NORM"/"..." thing
metin2_udp_yes_ports='%s'
# here PORTs
metin2_tcp_yes_ports='%s'
# here DB_PORTs and P2P_PORTs
metin2_tcp_no_ports='%s'

# merge lists
udp_yes_ports="$default_udp_yes_ports $metin2_udp_yes_ports"
tcp_yes_ports="$default_tcp_yes_ports $metin2_tcp_yes_ports"
tcp_nop_ports="$default_tcp_no_ports $metin2_tcp_no_ports"

# white ip list
white_sites=''

# block tcp/udp ports
for val in $tcp_nop_ports; do
	$IPF 2220 allow all from 127.0.0.0/8 to any $val
	for whitez in $white_sites; do
		$IPF 2210 allow tcp from $whitez to any $val in
		$IPF 2210 allow tcp from 127.0.0.0/8 to $whitez $val out
	done
	$IPF 2230 deny all from any to me $val
done
# unblock tcp ports
for val in $tcp_yes_ports; do
	$IPF 2200 allow tcp from any to any $val in limit src-addr 20
	$IPF 2210 allow tcp from any to any $val out
done
# unblock udp ports
for val in $udp_yes_ports; do
	$IPF 2200 allow udp from any to any $val in limit src-addr 20
	$IPF 2210 allow udp from any to any $val out
done
"""
