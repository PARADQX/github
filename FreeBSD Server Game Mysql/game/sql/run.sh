## Create db struct and mt2 user with limited privileges
mysql < base/db_create.sql
mysql < base/mt2_user_c.sql

## Create clean metin2 db struct
mysql account < account.sql
mysql common < common.sql
mysql log < log.sql
mysql player < player.sql

## Insert new features in metin2 db struct
mysql common < updates/common__exp_table.sql
mysql common < updates/common__priv_settings.sql
mysql log < updates/log__chat_log.sql
mysql player < updates/player__skill_proto.sql
mysql player < updates/player__updates.sql

### NOTE: DON'T TOUCH updates/post/ queries! (they are just for rare cases!)

## Insert Log tables about AcceSystem
mysql log < acce_system/db.log.acce.sql
mysql player < acce_system/db.player.player.sql