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
        obsidianCA = softwareSystem "Obsidian CA Service" "Provides EMV Root CA functionality" {
		
            adminclient = container "Administration Client" "Provides the user interface." ".Net"
            caserver     = container "Obsidian CA Server" "Provides Central control" ".Net"
			hsm     = container "Entrust XC HSM" "Provides Key Security" "Native nCore"
            db      = container "Database" "Stores application data." "SQL Server"
			
        }

        user -> adminclient "Uses" "2FA"
		user1 -> adminclient "Uses" "2FA"
		user2 -> adminclient "Uses" "2FA"
		user3 -> adminclient "Uses" "2FA"
								
								
								
        adminclient -> caserver "Invokes" "TCP / ASE-protected"
        caserver -> db "Reads from and writes to" "ODBC"
		caserver -> hsm "Reads from and writes to" "hardserver"
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		

        /****************************************
         * Deployment Environments
         ****************************************/
		 
		 
		 
		 
		deploymentEnvironment "Full HA Deployment" {
		
		
		
		
            deploymentNode "Production Main Site" "Primary production region" {
                deploymentNode "VPC" {
                    deploymentNode "Workstation Subnet" {
                        deploymentNode "Load Balancer" "AWS ALB" {
                            containerInstance adminclient
                        }
                    }

                    deploymentNode "Restricted Subnet" {
                        deploymentNode "Application Tier" {
                            containerInstance caserver
							containerInstance hsm
                        }

                        
                    }
                }
            }
			
			
			
			
			
			deploymentNode "DR" "Secondary DR region" {
                deploymentNode "VPC" {
                    deploymentNode "Workstation Subnet" {
                        deploymentNode "Load Balancer" "AWS ALB" {
                            containerInstance adminclient
                        }
                    }

                    deploymentNode "Restricted Subnet" {
                        deploymentNode "Application Tier" {
                            containerInstance caserver
							containerInstance hsm
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
                            containerInstance adminclient
                        }
                    }

                    deploymentNode "Private Subnet" {
                        deploymentNode "Application Tier" {
                            containerInstance caserver
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
                            containerInstance adminclient
                        }
                    }

                    deploymentNode "Private Subnet" {
                        deploymentNode "Application Tier" {
                            containerInstance caserver
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
        systemContext obsidianCA {
            include *
            autoLayout lr
        }

        container obsidianCA {
            include *
            autoLayout lr
        }

        /****************************************
         * Deployment Views
         ****************************************/
        
		deployment obsidianCA "Full HA Deployment" {
            title "Full HA Deployment"
            include *
            /*autoLayout lr*/
			autoLayout lr
        }
		
		
		
		deployment obsidianCA "Production" {
            title "Production Deployment"
            include *
            autoLayout lr
        }

        deployment obsidianCA "DR" {
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
