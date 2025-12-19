workspace "Multi-Environment Deployment Example" "Example of a single system deployed into Production and DR environments." {

    model {
	
	
        /****************************************
         * People
         ****************************************/
        user = person "Administrator 1" "Administrator of the system."
		user1 = person "Administrator 2" "Administrator of the system."

		user2 = person "Officer 1" "Operator of the system."

		user3 = person "Officer 2" "Operator of the system."





        /****************************************
         * Software System
         ****************************************/
        webSystem = softwareSystem "Obsidian CA Service" "Provides EMV Root CA functionality" {
            webApp = container "Administration Client" "Provides the user interface." ".Net"
            api     = container "Obsidian CA" "Provides Central control" ".Net"
            db      = container "Database" "Stores application data." "SQL Server"
        }

        user -> webApp "Uses" "HTTPS"
		        user1 -> webApp "Uses" "HTTPS"
				        user2 -> webApp "Uses" "HTTPS"
						        user3 -> webApp "Uses" "HTTPS"
								
								
								
        webApp -> api "Invokes" "TCP / ASE-protected"
        api -> db "Reads from and writes to" "ODBC"
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		

        /****************************************
         * Deployment Environments
         ****************************************/
		 
		 
		 
		 
		deploymentEnvironment "Full HA Deployment" {
		
		
		
		
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

                        
                    }
                }
            }
			
			
			
			
			
			deploymentNode "_AWS_" "Secondary DR region" {
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

                        
                    }
                }
            }
			
			
			deploymentNode "Database Tier" {
                            containerInstance db
                        }
			
			
			
        }
		 
		 
		 
		 
		 
		 
		 
		 

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
        
		deployment webSystem "Full HA Deployment" {
            title "Full HA Deployment"
            include *
            /*autoLayout lr*/
			autoLayout lr
        }
		
		
		
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
