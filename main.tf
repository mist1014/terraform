terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">=0.61.0"
    }
  }
  required_version = ">= 0.13"
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "terraform1014"
    region     = "ru-central1"
    key        = "terraform.tfstate"
    access_key = "YCAJEkdxxIbUwcwkKpg6oOLjo"
    secret_key = "YCNAjjgWu-hTr1F8DBEzHXLsFviex222v809IUtO"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}



provider "yandex" {
  token     = "t1.9euelZrPlpSXm53LnZSLmp3IkpmNje3rnpWalpeMzZ6WjMaWlc-SkY2OkJfl8_cJGyNd-e8-L0h2_t3z90lJIF357z4vSHb-zef1656VmsbJm5bIyZeOnMjOkZSPzo6c7_0.F6ewdgvOXP95UE9frbkr5k2TMQ1i9Y6VMw3DKNvae2FSYUSa5hTS5p9_Ne9z9acB2RfI01vHE60t2Jpura_kCQ"
  cloud_id  = "b1g9j5o7nuir2h2hocuf"
  folder_id = "b1g7elm4f781a4r2vbib"
  zone      = "ru-central1-a"
}


resource "yandex_vpc_network" "network-1" {
  name = "network-1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet-1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "subnet-2" {
  name           = "subnet-2"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.11.0/24"]
}


module "vm_1" {
  source                = "./modules/vm"
  instance_family_image = "lemp"
  vpc_subnet_id         = yandex_vpc_subnet.subnet-1.id
  zone                  = yandex_vpc_subnet.subnet-1.zone
}

module "vm_2" {
  source                = "./modules/vm"
  instance_family_image = "lamp"
  vpc_subnet_id         = yandex_vpc_subnet.subnet-2.id
  zone                  = yandex_vpc_subnet.subnet-2.zone
}
