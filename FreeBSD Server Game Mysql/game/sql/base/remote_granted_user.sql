/* script not runned automatically since using ssh tunnel with root@localhost is better */
/* choose user n password generated from https://passwordsgenerator.net/ without special symbols possibly; length 16 is ok */
/* in case of issues:
	delete any my.cnf you find on your machine (by running `find / -name my.cnf`)
	and also restart your server (by running `shutdown -r now`) */
GRANT ALL PRIVILEGES ON *.* TO 'y75EejBpZJWM3ctP'@'%' IDENTIFIED BY '7Dqt6xqXtRucYmF8';
FLUSH PRIVILEGES;
