test_run = require('test_run').new()
engine = test_run:get_cfg('engine')

box.schema.user.grant('guest', 'replication')

-- Deploy a replica.
test_run:cmd("create server replica with rpl_master=default, script='replication/replica.lua'")
test_run:cmd("start server replica")
test_run:cmd("switch replica")

replication = box.cfg.replication
box.cfg{replication = {replication, replication}}


test_run:cmd("switch default")
box.schema.user.revoke('guest', 'replication') 
