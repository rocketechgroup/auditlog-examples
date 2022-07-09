WITH
  resource_info AS (
  SELECT
    timestamp,
    resource.type AS resource_type,
    resource.labels.service_name,
    protopayload_auditlog.methodName AS method_name,
    PARSE_JSON(protopayload_auditlog.responseJson) AS response_json
  FROM
    `rocketech-de-pgcp-sandbox.log_sinks.cloudaudit_googleapis_com_activity`
  WHERE
    resource.type = 'cloud_run_revision' )
SELECT
  timestamp,
  resource_type,
  service_name,
  method_name,
  JSON_EXTRACT_SCALAR(response_json['metadata']['annotations']['run.googleapis.com/ingress']) AS ingress_setting,
  JSON_EXTRACT_SCALAR(response_json['status']['latestCreatedRevisionName']) AS latest_created_revision_name,
  JSON_EXTRACT_SCALAR(response_json['status']['latestReadyRevisionName']) AS latest_ready_revision_name,
  JSON_EXTRACT_SCALAR(response_json['status']['traffic'][0]['revisionName']) AS traffic_0_revision,
  JSON_EXTRACT_SCALAR(response_json['status']['traffic'][0]['percent']) AS traffic_0_percentage,
  JSON_EXTRACT_SCALAR(response_json['status']['traffic'][1]['revisionName']) AS traffic_1_revision,
  JSON_EXTRACT_SCALAR(response_json['status']['traffic'][1]['percent']) AS traffic_1__percentage,
  JSON_EXTRACT_SCALAR(response_json['status']['url']) AS url
FROM
  resource_info
WHERE service_name != ''
