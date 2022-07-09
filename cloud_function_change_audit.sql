WITH
  resource_info AS (
  SELECT
    timestamp,
    resource.type AS resource_type,
    resource.labels.function_name as service_name,
    protopayload_auditlog.methodName AS method_name
  FROM
    `rocketech-de-pgcp-sandbox.log_sinks.cloudaudit_googleapis_com_activity`
  WHERE
    resource.type = 'cloud_function' )
SELECT
  timestamp,
  resource_type,
  service_name,
  method_name
FROM
  resource_info
