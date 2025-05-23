output "leader" {
  value = {
    id         = oci_core_instance.leader.id
    vm_user    = local.vm_user
    hostname   = oci_core_instance.leader.create_vnic_details[0].hostname_label
    fqdn       = local.leader_fqdn
    private_ip = oci_core_instance.leader.private_ip
    ssh_lb = {
      listener_id = oci_network_load_balancer_listener.leader_ssh.id
      backend_id  = oci_network_load_balancer_backend.leader_ssh.id
    }
  }
}

output "workers" {
  value = [for worker in oci_core_instance.worker : {
    id         = worker.id
    private_ip = worker.private_ip
    public_ip  = worker.public_ip
    hostname   = worker.hostname_label
    vm_user    = local.vm_user
  }]
}

output "availability_domain" {
  value = local.availability_domain
}
