workspace "Multi-Environment Deployment Example" "Example of a single system deployed into Production and DR environments." {

    model {
        /****************************************
         * People
         ****************************************/
        user = person "End User" "A user of the system."

        /****************************************
         * Software System
         ****************************************/
        webSystem = softwareSystem "Online Service" "Provides business functionality via a web interface." {
            webApp = container "Web Application" "Provides the user interface." "Java / Spring Boot"
            api     = container "API Application" "Provides JSON/REST APIs." "Java / Spring Boot"
            db      = container "Database" "Stores application data." "PostgreSQL"
        }

        user -> webApp "Uses" "HTTPS"
        webApp -> api "Invokes" "HTTPS / JSON"
        api -> db "Reads from and writes to" "JDBC"

        /****************************************
         * Deployment Environments
         ****************************************/

        deploymentEnvironment "Production" {
            deploymentNode "AWS" "Primary production region" {
                deploymentNode "VPC" {
                    deploymentNode "Public Subnet" {
                        deploymentNode "Load Balancer" "AWS ALB" {
                            containerInstance webApp
                        }
                    }

                    deploymentNode "Private Subnet" {
                        deploymentNode "Application Tier" {
                            containerInstance api
                        }

                        deploymentNode "Database Tier" {
                            containerInstance db
                        }
                    }
                }
            }
        }

        deploymentEnvironment "DR" {
            deploymentNode "AWS" "Secondary DR region" {
                deploymentNode "VPC" {
                    deploymentNode "Public Subnet" {
                        deploymentNode "Load Balancer" "AWS ALB" {
                            containerInstance webApp
                        }
                    }

                    deploymentNode "Private Subnet" {
                        deploymentNode "Application Tier" {
                            containerInstance api
                        }

                        deploymentNode "Database Tier" {
                            containerInstance db
                        }
                    }
                }
            }
        }
    }

    views {

        /****************************************
         * Static Views
         ****************************************/
        systemContext webSystem {
            include *
            autoLayout lr
        }

        container webSystem {
            include *
            autoLayout lr
        }

        /****************************************
         * Deployment Views
         ****************************************/
        deployment webSystem "Production" {
            title "Production Deployment"
            include *
            autoLayout lr
        }

        deployment webSystem "DR" {
            title "Disaster Recovery Deployment"
            include *
            autoLayout lr
        }

        /****************************************
         * Styling
         ****************************************/
        styles {
            element "Person" {
                shape person
            }
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "Database" {
                shape cylinder
            }
            element "Deployment Node" {
                background #eeeeee
                color #000000
            }
        }
    }
}
