provider "azurerm" {
  features {}
}

resource "random_id" "id" {
  byte_length = 8
}

resource "azurerm_resource_group" "tf2_test" {
  name = "tf2mainrg"
  location = "westeurope"
}

resource "azurerm_container_group" "tfcg2_test" {
  name                      = "weatherapi"
  location                  = azurerm_resource_group.tf2_test.location
  resource_group_name       = azurerm_resource_group.tf2_test.name

  ip_address_type     = "public"
  dns_name_label      = "steedleswa2"
  os_type             = "Linux"

  container {
    name            = "weatherapi-${random_id.id.hex}"
    image           = "steedles/weatherapiv2"
    cpu             = "1"
    memory          = "1"

    ports {
      port        = 80
      protocol    = "TCP"
    }
  }
}
