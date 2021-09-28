
## Notes: data from single table

- Strings are not case-sensitive
- AND is always evaluated first
- BETWEEN is inclusive of the values
- LIKE is old, use REGEXP
	- '^' means start of string
	- '$' means end of string
	- '|' means OR for multiple search patterns
	- '[abcd]' means a list of options
	- '[a-d]' means a range of options
- LIMIT can be used with an offset number first


## Notes: data from multiple tables

- INNER is optional for JOIN
- OUTER is optional for JOIN (implicit with LEFT or RIGHT)
	- use LEFT JOIN
- us USING to join on equally names columns
- use CROSS JOIN to combine e.g. all colors and all sizes
- use UNION for combining rows with equal number of columns

![Join types](https://github.com/martheveldhuis/SQL_refresh/blob/main/joins.png)

## Notes: inserting, updating, and deleting data

- VARCHAR is variable in length
- using CREATE TABLE x AS + SELECT * does not maintain PK
- write the SELECT subquery before the CREATE TABLE


## Notes: summarizing data

- use HAVING to filter after grouping (WHERE clause would not work)
- HAVING only works on selected columns
- ROLLUP only works with the actual column name, not an alias


## Notes: complex queries

- you can use both subqueries or joins depending on readability
- correlated subqueries are useful to find information for the main query
- EXISTS operator is more efficient for using on a subquery than IN because it is 
a boolean operator
- when using a subquery in the FROM clause, you must use an alias
	- only use this in simple queries
	- otherwise, store the subquery in a view


## Notes: views

- a view can be worked upon like a table
- preferably use CREATE OR REPLACE
- views are often saved in sql files, named the same as the view
and put under source control.
- "updatable views" can be used in INSERT, UPDATE and DELETE statements 
if they DO NOT include:
	- DISTINCT
	- Aggregate functions (MIN, MAX, SUM)
	- GROUP BY / HAVING
	- UNION
- updating views might be necessary if you don't have access to the actual tables
- updating or deleting from views might remove some rows, to prevent use: 
	- WITH CHECK OPTION: this will instead give an error

- benefits of views:
	- simplify queries
	- reduce impact of changes as it is an abstraction on top of tables
		- e.g. table column changes, all queries would have to change.
		- if you write queries against views instead, only the view changes.
	- restrict access to the data
		- note that you might want to update the áctual data.

## Notes: stored procedures

- do not mix SQL- application code.
- stored procedure = database object that contains a block of SQL code. (function)
- code in stored procedures could be executed faster.
- also increases data security.
- DELIMITER keyword changes the default delimiter so that a block of code
can be executed as one. This is required in MySQL.
- parameters are placeholders in function definitions, 
arguments are the values you supply.
- validating paramaters should be minimal, should be in application
- variables are used often with output parameters
- local variables are only stored during stored procedures
- functions, in contrast to stored procedures, can only return a single value.
- functions must have a, or multiple, attributes 
	- DETERMINISTIC
	- READS SQL DATA
	- MODIFIES SQL DATA
