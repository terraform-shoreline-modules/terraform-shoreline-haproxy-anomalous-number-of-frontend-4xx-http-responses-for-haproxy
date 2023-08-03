resource "shoreline_notebook" "anomalous_number_of_frontend_4xx_http_responses_for_host" {
  name       = "anomalous_number_of_frontend_4xx_http_responses_for_host"
  data       = file("${path.module}/data/anomalous_number_of_frontend_4xx_http_responses_for_host.json")
  depends_on = [shoreline_action.invoke_backend_server_check,shoreline_action.invoke_restart_haproxy]
}

resource "shoreline_file" "backend_server_check" {
  name             = "backend_server_check"
  input_file       = "${path.module}/data/backend_server_check.sh"
  md5              = filemd5("${path.module}/data/backend_server_check.sh")
  description      = "Network or connectivity issues between the HAProxy and backend servers"
  destination_path = "/agent/scripts/backend_server_check.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "restart_haproxy" {
  name             = "restart_haproxy"
  input_file       = "${path.module}/data/restart_haproxy.sh"
  md5              = filemd5("${path.module}/data/restart_haproxy.sh")
  description      = "Restart the HAProxy service."
  destination_path = "/agent/scripts/restart_haproxy.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_backend_server_check" {
  name        = "invoke_backend_server_check"
  description = "Network or connectivity issues between the HAProxy and backend servers"
  command     = "`chmod +x /agent/scripts/backend_server_check.sh && /agent/scripts/backend_server_check.sh`"
  params      = ["LIST_OF_BACKEND_SERVERS","BACKEND_SERVER"]
  file_deps   = ["backend_server_check"]
  enabled     = true
  depends_on  = [shoreline_file.backend_server_check]
}

resource "shoreline_action" "invoke_restart_haproxy" {
  name        = "invoke_restart_haproxy"
  description = "Restart the HAProxy service."
  command     = "`chmod +x /agent/scripts/restart_haproxy.sh && /agent/scripts/restart_haproxy.sh`"
  params      = []
  file_deps   = ["restart_haproxy"]
  enabled     = true
  depends_on  = [shoreline_file.restart_haproxy]
}

