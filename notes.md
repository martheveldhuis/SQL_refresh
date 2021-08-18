
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

