resource "random_id" "suffix" {
  byte_length = 5
}


module "mysql-db" {
  source               = "../"
  name                 = "example-mysql-db"
  random_instance_name = true
  project_id           = "astute-veld-344810"

  deletion_protection = false

  database_version = "MYSQL_8_0"
  region           = "us-central1"
  zone             = "us-central1-c"
  tier             = "db-n1-standard-1"

  // By default, all users will be permitted to connect only via the
  // Cloud SQL proxy.
  additional_users = [
    {
      name     = "app"
      password = "PaSsWoRd"
      host     = "localhost"
      type     = "BUILT_IN"
    },
    {
      name     = "readonly"
      password = "PaSsWoRd"
      host     = "localhost"
      type     = "BUILT_IN"
    },
  ]

}