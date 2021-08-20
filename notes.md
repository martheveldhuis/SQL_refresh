
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