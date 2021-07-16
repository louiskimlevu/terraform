/**
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

output "dev_bu1_project_base" {
  description = "Project sample base project."
  value       = module.projects_bu1_dev.base_shared_vpc_project
}

output "dev_bu1_project_floating" {
  description = "Project sample floating project."
  value       = module.projects_bu1_dev.floating_project
}

output "dev_bu1_project_peering" {
  description = "Project sample peering project."
  value       = module.projects_bu1_dev.peering_project
}

output "dev_bu1_network_peering" {
  description = "Peer network peering resource."
  value       = module.projects_bu1_dev.peering_network
}

output "dev_bu1_project_restricted" {
  description = "Project sample restricted project."
  value       = module.projects_bu1_dev.restricted_shared_vpc_project
}

output "dev_bu1_project_restricted_number" {
  description = "Project sample restricted project."
  value       = module.projects_bu1_dev.restricted_shared_vpc_project_number
}

output "dev_bu2_project_base" {
  description = "Project sample base project."
  value       = module.projects_bu2_dev.base_shared_vpc_project
}

output "dev_bu2_project_restricted" {
  description = "Project sample restricted project."
  value       = module.projects_bu2_dev.restricted_shared_vpc_project
}

output "dev_bu2_project_restricted_number" {
  description = "Project sample restricted project."
  value       = module.projects_bu2_dev.restricted_shared_vpc_project_number
}

output "dev_bu2_project_floating" {
  description = "Project sample floating project."
  value       = module.projects_bu2_dev.floating_project
}

output "dev_bu2_project_peering" {
  description = "Project sample peering project."
  value       = module.projects_bu2_dev.peering_project
}

output "dev_bu2_network_peering" {
  description = "Peer network peering resource."
  value       = module.projects_bu2_dev.peering_network
}

output "dev_bu1_restricted_vpc_service_control_perimeter_name" {
  description = "VPC Service Control name."
  value       = module.projects_bu1_dev.vpc_service_control_perimeter_name
}

output "dev_bu1_restricted_apis" {
  description = "Activated APIs."
  value       = module.projects_bu1_dev.restricted_enabled_apis
}

output "dev_bu2_restricted_vpc_service_control_perimeter_name" {
  description = "VPC Service Control name."
  value       = module.projects_bu2_dev.vpc_service_control_perimeter_name
}

output "dev_bu2_restricted_apis" {
  description = "Activated APIs."
  value       = module.projects_bu2_dev.restricted_enabled_apis
}

output "nonprod_bu1_project_base" {
  description = "Project sample base project."
  value       = module.projects_bu1_nonprod.base_shared_vpc_project
}

output "nonprod_bu1_project_floating" {
  description = "Project sample floating project."
  value       = module.projects_bu1_nonprod.floating_project
}

output "nonprod_bu1_project_peering" {
  description = "Project sample peering project."
  value       = module.projects_bu1_nonprod.peering_project
}

output "nonprod_bu1_network_peering" {
  description = "Peer network peering resource."
  value       = module.projects_bu1_nonprod.peering_network
}

output "nonprod_bu1_project_restricted" {
  description = "Project sample restricted project."
  value       = module.projects_bu1_nonprod.restricted_shared_vpc_project
}

output "nonprod_bu1_project_restricted_number" {
  description = "Project sample restricted project."
  value       = module.projects_bu1_nonprod.restricted_shared_vpc_project_number
}

output "nonprod_bu2_project_base" {
  description = "Project sample base project."
  value       = module.projects_bu2_nonprod.base_shared_vpc_project
}

output "nonprod_bu2_project_restricted" {
  description = "Project sample restricted project."
  value       = module.projects_bu2_nonprod.restricted_shared_vpc_project
}

output "nonprod_bu2_project_restricted_number" {
  description = "Project sample restricted project."
  value       = module.projects_bu2_nonprod.restricted_shared_vpc_project_number
}

output "nonprod_bu2_project_floating" {
  description = "Project sample floating project."
  value       = module.projects_bu2_nonprod.floating_project
}

output "nonprod_bu2_project_peering" {
  description = "Project sample peering project."
  value       = module.projects_bu2_nonprod.peering_project
}

output "nonprod_bu2_network_peering" {
  description = "Peer network peering resource."
  value       = module.projects_bu2_nonprod.peering_network
}

output "nonprod_bu1_restricted_vpc_service_control_perimeter_name" {
  description = "VPC Service Control name."
  value       = module.projects_bu1_nonprod.vpc_service_control_perimeter_name
}

output "nonprod_bu1_restricted_apis" {
  description = "Activated APIs."
  value       = module.projects_bu1_nonprod.restricted_enabled_apis
}

output "nonprod_bu2_restricted_vpc_service_control_perimeter_name" {
  description = "VPC Service Control name."
  value       = module.projects_bu2_nonprod.vpc_service_control_perimeter_name
}

output "nonprod_bu2_restricted_apis" {
  description = "Activated APIs."
  value       = module.projects_bu2_nonprod.restricted_enabled_apis
}

output "prod_bu1_project_base" {
  description = "Project sample base project."
  value       = module.projects_bu1_prod.base_shared_vpc_project
}

output "prod_bu1_project_floating" {
  description = "Project sample floating project."
  value       = module.projects_bu1_prod.floating_project
}

output "prod_bu1_project_peering" {
  description = "Project sample peering project."
  value       = module.projects_bu1_prod.peering_project
}

output "prod_bu1_network_peering" {
  description = "Peer network peering resource."
  value       = module.projects_bu1_prod.peering_network
}

output "prod_bu1_project_restricted" {
  description = "Project sample restricted project."
  value       = module.projects_bu1_prod.restricted_shared_vpc_project
}

output "prod_bu1_project_restricted_number" {
  description = "Project sample restricted project."
  value       = module.projects_bu1_prod.restricted_shared_vpc_project_number
}

output "prod_bu2_project_base" {
  description = "Project sample base project."
  value       = module.projects_bu2_prod.base_shared_vpc_project
}

output "prod_bu2_project_restricted" {
  description = "Project sample restricted project."
  value       = module.projects_bu2_prod.restricted_shared_vpc_project
}

output "prod_bu2_project_restricted_number" {
  description = "Project sample restricted project."
  value       = module.projects_bu2_prod.restricted_shared_vpc_project_number
}

output "prod_bu2_project_floating" {
  description = "Project sample floating project."
  value       = module.projects_bu2_prod.floating_project
}

output "prod_bu2_project_peering" {
  description = "Project sample peering project."
  value       = module.projects_bu2_prod.peering_project
}

output "prod_bu2_network_peering" {
  description = "Peer network peering resource."
  value       = module.projects_bu2_prod.peering_network
}

output "prod_bu1_restricted_vpc_service_control_perimeter_name" {
  description = "VPC Service Control name."
  value       = module.projects_bu1_prod.vpc_service_control_perimeter_name
}

output "prod_bu1_restricted_apis" {
  description = "Activated APIs."
  value       = module.projects_bu1_prod.restricted_enabled_apis
}

output "prod_bu2_restricted_vpc_service_control_perimeter_name" {
  description = "VPC Service Control name."
  value       = module.projects_bu2_prod.vpc_service_control_perimeter_name
}

output "prod_bu2_restricted_apis" {
  description = "Activated APIs."
  value       = module.projects_bu2_prod.restricted_enabled_apis
}

output "access_context_manager_policy_id" {
  description = "Access Context Manager Policy ID."
  value       = var.policy_id
}
