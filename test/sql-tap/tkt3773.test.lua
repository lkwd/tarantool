#!/usr/bin/env tarantool
test = require("sqltester")
test:plan(1)

--!./tcltestrunner.lua
-- 2009 April 2
--
-- The author disclaims copyright to this source code.  In place of
-- a legal notice, here is a blessing:
--
--    May you do good and not evil.
--    May you find forgiveness for yourself and forgive others.
--    May you share freely, never taking more than you give.
--
-------------------------------------------------------------------------
--
-- Ticket #3773:  Be careful not to over-optimize when a compound
-- subquery contains an ORDER BY clause.
--
--
-- $Id: tkt3773.test,v 1.1 2009/04/02 16:59:47 drh Exp $
-- ["set","testdir",[["file","dirname",["argv0"]]]]
-- ["source",[["testdir"],"\/tester.tcl"]]


test:do_test(
    "tkt3773-1.1",
    function()
        return test:execsql [[
            CREATE TABLE t1(a INT primary key,b INT);
            INSERT INTO t1 VALUES(2,1);
            INSERT INTO t1 VALUES(33,3);
            CREATE TABLE t2(x INT,y INT primary key);
            INSERT INTO t2 VALUES(123,2);
            INSERT INTO t2 VALUES(4,4);
            SELECT a FROM (
              SELECT a, b FROM t1
              UNION ALL
              SELECT x, y FROM t2
              ORDER BY 2
            );
        ]]
    end, {
        -- <tkt3773-1.1>
        2, 123, 33, 4
        -- </tkt3773-1.1>
    })

test:finish_test()

