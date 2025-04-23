terraform {
  required_providers {
    twc = {
      source = "tf.timeweb.cloud/timeweb-cloud/timeweb-cloud"
    }
  }
  required_version = ">= 1.4.4"
}

provider "twc" {
  token = "eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCIsImtpZCI6IjFrYnhacFJNQGJSI0tSbE1xS1lqIn0.eyJ1c2VyIjoibGEzMDMxOSIsInR5cGUiOiJhcGlfa2V5IiwiYXBpX2tleV9pZCI6IjVlNjhkNDdiLWQ3ZTUtNDY2Zi1hOTU3LWRiOTE1YTRlZThhYiIsImlhdCI6MTc0NDk4MjAwMywiZXhwIjoxNzUyNzU4MDAzfQ.0OCu_TZh37y2V7U16VuZCRIiO9qfzFD68CzX0uT9hVDoMRaVA7V4ga4IQna9RWyAoseYUDirvrsulDtWJJzSOTtf0x3_xLHUSOiyZfLzwoWau4--AhTY6IgfyR5xmQF2ddQXp3Q_nD0YGGBJhK2R0bAcGUz5lUhNeJVX_8j4R9_HJxUZ0hTmtmuDeph-IuZmWSfrpozo6-19yQoVO6EWAzthyCc_PcekrGCxlfKAJWw4gLBQaxL0XFQv0MQLnBVa1w6zG2oCdDFBvJDlQJkIEYzDbLZBCyslPXey6ctvhx9IjVJeITBIf7DIoJZNooHg9J2nllWZ0JU70TUD3aQdVYtGsTBdKNb5BPwY7o4B9zGKcR8a_AEfvb-YGGm85Ils_QYYRIggKSJ-dhXNQfd34vMJW2n0GPxaOpsAFb2B3252y2dfWxDXlZouSWyXJkmI3MHQLPQnkcVqwlxfEBajIGyF7wukjdon7OD4WMgOFbICULlEa09lpwKyz5MYdv1P"
}

data "twc_configurator" "configurator" {
  location = "ru-1"
  preset_type = "premium"
}

data "twc_os" "os" {
  name = "ubuntu"
  version = "22.04"
}

data "twc_software" "software" {
  name = "Docker"
}

resource "twc_server" "devops" {
  name = "DevOps"
  os_id = data.twc_os.os.id
  software_id = data.twc_software.software.id

  configuration {
    configurator_id = data.twc_configurator.configurator.id
    disk = 30720
    cpu = 2
    ram = 4096
  }
}

resource "twc_server_ip" "server_ip" {
  source_server_id = twc_server.devops.id
  type = "ipv4"
}