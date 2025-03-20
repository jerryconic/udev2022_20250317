BEGIN TRAN;

INSERT INTO dbo.Test(id) VALUES(10);

INSERT INTO dbo.Test(id) VALUES(1);

ROLLBACK TRAN;

SELECT *
FROM sys.fn_xe_file_target_read_file('C:\Data\xe\deadlock*.xel', NULL, NULL, NULL)
WHERE object_name = 'xml_deadlock_report';


SELECT CAST(event_data AS xml)
FROM sys.fn_xe_file_target_read_file('C:\Data\xe\deadlock*.xel', NULL, NULL, NULL)
WHERE object_name = 'xml_deadlock_report';


SELECT CAST(event_data AS xml).query('(//inputbuf)')
FROM sys.fn_xe_file_target_read_file('C:\Data\xe\deadlock*.xel', NULL, NULL, NULL)
WHERE object_name = 'xml_deadlock_report';

SELECT CAST(event_data AS xml).query('(/)')
FROM sys.fn_xe_file_target_read_file('C:\Data\xe\deadlock*.xel', NULL, NULL, NULL)
WHERE object_name = 'xml_deadlock_report';