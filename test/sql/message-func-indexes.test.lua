test_run = require('test_run').new()
engine = test_run:get_cfg('engine')
box.sql.execute('pragma sql_default_engine=\''..engine..'\'')
box.sql.execute('pragma interactive_mode=0;')

-- Creating tables.
box.sql.execute("CREATE TABLE t1(id INTEGER PRIMARY KEY, a INTEGER)")
box.sql.execute("CREATE TABLE t2(object INTEGER PRIMARY KEY, price INTEGER, count INTEGER)")

-- Expressions that're supposed to create functional indexes
-- should return certain message.
box.sql.execute("CREATE INDEX i1 ON t1(a+1)")
box.sql.execute("CREATE INDEX i2 ON t1(a)")
box.sql.execute("CREATE INDEX i3 ON t2(price + 100)")
box.sql.execute("CREATE INDEX i4 ON t2(price)")
box.sql.execute("CREATE INDEX i5 ON t2(count + 1)")
box.sql.execute("CREATE INDEX i6 ON t2(count * price)")

-- Cleaning up.
box.sql.execute("DROP TABLE t1")
box.sql.execute("DROP TABLE t2")
