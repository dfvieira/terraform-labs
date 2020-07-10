provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"

  ##Utilizar caso seja necessario realizar assume role para outra conta AWS
  # assume_role {
  #   role_arn     = "${var.role_arn}"
  #   session_name = "${var.session_name}"
  #   external_id  = "${var.external_id}"
  #}

  region = "${var.region}"
}

locals {
  common_tags = {
    Owner       = "administrador@exemplo.com.br"
    Project     = "Nome do Projeto"
    Environment = "Ambiente"
  }
}

resource "random_id" "randon" {
  byte_length = 4
}

#VPC
module "vpc-exemplo" {
  source   = "../../modules/vpc"
  vpc_cidr = "192.168.8.0/22"

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "vpc-exemplo-${var.region}")
  )}"
}

#Internet Gateway
module "igw-exemplo" {
  source = "../../modules/igw"
  vpc_id = "${module.vpc-exemplo.vpc_id}"

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "igw-exemplo-${var.region}")
  )}"
}

#Subnets
module "subnet-exemplo" {
  source       = "../../modules/subnet"
  vpc_id       = "${module.vpc-exemplo.vpc_id}"
  block_subnet = ["192.168.8.0/24", "192.168.9.0/24"]
  azs          = ["us-east-1a", "us-east-1b"]

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "subnet-exemplo")
  )}"
}

module "rtb-attach-sunet1" {
  source         = "../../modules/rtb_attach"
  route_table_id = "${module.vpc-exemplo.rtb_id}"
  subnet_id      = "${module.subnet-exemplo.id_sub[0]}"
}

module "rtb-attach-sunet2" {
  source         = "../../modules/rtb_attach"
  route_table_id = "${module.vpc-exemplo.rtb_id}"
  subnet_id      = "${module.subnet-exemplo.id_sub[1]}"
}

#Interfaces para EC2
# module "eni-exemplo" {
#   source                = "../../modules/interface"
#   subnet_id             = "${module.subnet-exemplo.id_sub[0]}"
#   eni_private_ip        = ["192.168.9.10"]
#   eni_source_dest_check = false

#   tags = "${merge(
#     local.common_tags,
#     map(
#       "Name", "eni-exemplo")
#   )}"
# }

#Instancias EC2
module "ec2-exemplo-1" {
  source                  = "../../modules/ec2"
  ec2_ami                 = "ami-0b69ea66ff7391e80"
  ec2_instance_type       = "t2.micro"
  ec2_key                 = "ec2-key"
  ec2_monitoring          = true
  ec2_subnet_id           = "${module.subnet-exemplo.id_sub[0]}"
  ec2_associate_public_ip = true

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "ec2-exemplo-1")
  )}"
}
##Instancia EC2 utilizando ENI especifica
# module "ec2-exemplo-2" {
#   source                = "../../modules/ec2"
#   ec2_ami               = "ami-0b69ea66ff7391e80"
#   ec2_instance_type     = "t2.micro"
#   ec2_key               = "ec2-key"
#   ec2_monitoring        = true
#   ec2_subnet_id         = "${module.subnet-exemplo.id_sub[0]}"
#   network_interface_id1 = "${module.eni-exemplo.eni_id}"

#   tags = "${merge(
#     local.common_tags,
#     map(
#       "Name", "ec2-exemplo-2")
#   )}"
# }

#EKS Cluster
module "k8s-cluster" {
  source                    = "git::https://github.com/terraform-aws-modules/terraform-aws-eks/tree/tf0.11"
  cluster_name              = "k8s-exemplo"
  subnets                   = "${module.subnet-exemplo.id_sub}"
  vpc_id                    = "${module.vpc-exemplo.vpc_id}"
  worker_group_count        = 2
  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  worker_groups = [
    {
      instance_type        = "t2.small"
      asg_max_size         = 3
      asg_desired_capacity = 2
      kubelet_extra_args   = "--node-labels=workertype=apps"
    },
    {
      name                 = "runner"
      instance_type        = "t2.small"
      asg_max_size         = 2
      asg_desired_capacity = 1
      kubelet_extra_args   = "--node-labels=workertype=services"
    },
  ]

  tags = {
    Owner       = "administrador@exemplo.com.br"
    Project     = "Nome do Projeto"
    Environment = "Ambiente"
  }
}

#Elastic Cache - Redis
module "cache-cluster" {
  source                       = "../../modules/elasticache"
  cluster_id                   = "redis-dev-${var.region}"
  cache_engine                 = "redis"
  cluster_node_type            = "cache.t2.medium"
  number_cache_nodes           = "1"
  cluster_parameter_group_name = ""
  subnet_group_name            = "cluster-subnet-group"
  cluster_engine_version       = ""
  subnet_ids                   = "${module.subnet-exemplo.id_sub}"
}

#ElasticSearch
module "elasticsearch" {
  source                = "../../modules/elasticsearch"
  domain_name           = "elasticsearch-dev-domain"
  elasticsearch_version = "7.1"
  ebs_volume_size       = "10"
  es_instance_type      = "t2.small.elasticsearch"
  subnet_ids            = ["${module.subnet-exemplo.id_sub}"]

  tags = "${merge(
    local.common_tags,
    map(
      "Domain", "elasticsearch-dev-domain"),
      map(
      "Name", "elasticsearch-dev-domain")
  )}"
}

module "ecr-exemplo" {
  source                   = "../../modules/ecr"
  ecr_name                 = "exemplo-registry"
  ecr_image_tag_mutability = "MUTABLE"

  tags = "${merge(
    local.common_tags)}"
}

#Bucket S3

module "s3-exemplo" {
  source  = "../../modules/s3"
  s3_name = "s3-exemplo-${random_id.randon.hex}"
  s3_acl  = "private"

  tags = "${merge(
  local.common_tags)}"
}

module "vpce-s3" {
  source                = "../../modules/vpce"
  vpc_id                = "${module.vpc-exemplo.vpc_id}"
  endpoint_service_name = "com.amazonaws.${var.region}.s3"
  endpoint_type         = "Gateway"
  route_table_id        = "${module.vpc-exemplo.rtb_id}"
}
