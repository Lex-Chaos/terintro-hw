terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }

    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.9"
}

provider "yandex" {
  # token     = var.yandex_cloud_token 
  # cloud_id  = "b1g6fo99h0qim9jv8gnk"
  # folder_id = "b1g2495p8ldt10kjk28s"
  # zone      = "ru-central1-a"
}

provider "docker" {
  # host     = "ssh://lex@158.160.35.235:22"
  # host     = "ssh://lex@${yandex_compute_instance.terintro-serv.network_interface.0.nat_ip_address}:22"
  # ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}

variable "folder_id" {
  default = ""
}

resource "yandex_iam_service_account" "terintro-hw-sa" {
  name        = "terintro-hw-sa"
  description = "Сервисный аккаунт для ДЗ"
}

resource "yandex_resourcemanager_folder_iam_member" "terintro-hw-admin" {
  folder_id = var.folder_id
  role      = "admin"
  member    = "serviceAccount:${yandex_iam_service_account.terintro-hw-sa.id}"
}

resource "yandex_compute_instance" "terintro-serv" {
  name        = "terintro-serv"
  hostname    = "terintro-serv"
  zone        = "ru-central1-a"
  platform_id = "standard-v3"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd81no7ub0p1nooono37"
      size     = 10
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-1.id
    nat                = true
    # security_group_ids = [yandex_vpc_security_group.s-ssh-traffic.id, yandex_vpc_security_group.s-webservers.id]
    # ip_address         = "192.168.1.1"
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }

  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_vpc_network" "net-1" {
  name = "net-1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet-1"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.net-1.id}"
  v4_cidr_blocks = ["10.0.1.0/24"]
  # route_table_id = "${yandex_vpc_route_table.rt.id}"
}

# resource "docker_image" "mysql"{
#   name         = "mysql:8"
#   # keep_locally = true
# }