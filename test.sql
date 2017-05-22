SELECT DES.session_id AS [SESSION ID],
Db_name(DDSSU.database_id) AS [DATABASE Name],
host_name AS [System Name],
program_name AS [Program Name],
login_name AS [USER Name],
status,
( user_objects_alloc_page_count * 8 ) AS
[SPACE Allocated FOR USER Objects (in KB)],
( user_objects_dealloc_page_count * 8 ) AS
[SPACE Deallocated FOR USER Objects (in KB)],
( internal_objects_alloc_page_count * 8 ) AS
[SPACE Allocated FOR Internal Objects (in KB)],
( internal_objects_dealloc_page_count * 8 ) AS
[SPACE Deallocated FOR Internal Objects (in KB)],
cpu_time AS [CPU TIME (in milisec)],
total_scheduled_time AS
[Total Scheduled TIME (in milisec)],
total_elapsed_time AS
[Elapsed TIME (in milisec)],
( memory_usage * 8 ) AS [Memory USAGE (in KB)],
CASE is_user_process
WHEN 1 THEN 'user session'
WHEN 0 THEN 'system session'
END AS [SESSION Type],
row_count AS [ROW COUNT]
FROM tempdb.sys.dm_pdw_nodes_db_session_space_usage AS DDSSU
INNER JOIN sys.dm_pdw_nodes_exec_sessions AS DES
ON DDSSU.session_id = DES.session_id
ORDER BY [SPACE Allocated FOR Internal Objects (in KB)] DESC