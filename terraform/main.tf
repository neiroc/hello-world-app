/**
 * Provisioning of n VMs on GCP
 */

provider "google" {
  project = "k3s-hello-world"  # Replace with your GCP project ID
  region  = "europe-west8"  # Replace with your preferred region 
}

# Define the SSH public key
variable "ssh_public_key" {
  description = "The SSH public key for access"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCiJliaAaOmpRsHvJO6DWtzjhCyYivXbzJYaZM7EJiPB/NncUP4sW4cXyEHyG1u5/ymFLcAuwwMsolQx3Rc2/GS3iiVrChBuhc/S/mz0QKRiHX7HwCCk95RdBoZIQ0DlPShNA8qeXq1Q17g8Ldy3+cgNh5KP51KL9gIU+IOnRbzTiNWreXk/WXlEx8uNl1fg/GokWTOjbpbpxikuWetFxm+AFE4kB/J5v/EkCvVwn8V5gZgBEbH4EXfyfqlNpH7e7uwPfYu11h6BQ2MdniBhB6macKSURHWkVw/iyYQaLxwVNO1LEqhLXZOCGJ/i28c+PJjrZpssoJI3egTxqQGttZpyDpnMFpD1afLBpOA8lJrlZK4moTld+pF5A88Q0IKC8ojg7IuXLwdbAuFEBTqUDICYlUi0ZJRBTqL/YvBtAKSVOp9UFDg7ZkrkAgncEwdUs60UEZG4/LBk3dDzb4knwpGf37Xp0M957U6Y/9MtKDzsa0GWHYwH1/Kt+j9KNRzCwM="  # Replace with your SSH public key
}

resource "google_compute_instance" "k3s-master" {
  name         = "k3s-master"
  machine_type = "e2-medium"
  zone         = "europe-west8-a" # Milan, Italy

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts" 
      size  = 50
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    ssh-keys = "justanotherwop:${var.ssh_public_key}"  # Inject SSH public key
  }
}

# resource "google_compute_instance" "k3s-worker-1" {
#   name         = "k3s-worker-1"
#   machine_type = "e2-medium"
#   zone         = "europe-west8-a" # Milan, Italy

#   boot_disk {
#     initialize_params {
#       image = "ubuntu-os-cloud/ubuntu-2204-lts" 
#       size  = 50
#     }
#   }

#   network_interface {
#     network = "default"
#     access_config {}
#   }

#   metadata = {
#     ssh-keys = "justanotherwop:${var.ssh_public_key}"  # Inject SSH public key
#   }
# }


resource "google_compute_firewall" "k3s_ports" {
  name    = "k3s-required-ports"
  network = "default" # Update if using a custom network

  allow {
    protocol = "tcp"
    ports    = ["6443", "10250", "8472", "30000-32767"]
  }

  source_ranges = ["0.0.0.0/0"] # Replace with specific IPs or CIDR ranges for security
  #target_tags   = ["k3s-node"]

  description = "Firewall rule to open required ports for Kubernetes"
}
