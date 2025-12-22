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
		
            adminclient1 = container "Administration Client (Main)" "Provides the user interface." ".Net"
			adminclient2 = container "Administration Client (DR)" "Provides the user interface." ".Net"
            caserver1     = container "Obsidian CA Server" "Central control + RFS" ".Net" {
				tags "Server"
			}
			caserver2     = container "Obsidian CA Server (DR)" "Provides Central control" ".Net" {
				tags "Server"
			}
			
			hsm1     = container "Entrust XC HSM (Main)" "Provides Key Security" "Native nCore"

			hsm2     = container "Entrust XC HSM (DR)" "Provides Key Security" "Native nCore"

		   db      = container "Database" "Stores all application data" "AlwaysON SQL Server" {
				tags "Database"
			}

			
			
        }

        user -> adminclient1 "Uses" "2FA"
		user1 -> adminclient1 "Uses" "2FA"
		user2 -> adminclient1 "Uses" "2FA"
		user3 -> adminclient1 "Uses" "2FA"
								
								
								
        adminclient1 -> caserver1 "Admin commands" "ASE-protected"
        adminclient2 -> caserver2 "Admin Commands" "ASE-protected"

        caserver1 -> db "DB R/W" "ODBC"
		caserver1 -> hsm1 "Crypto commands" 
		caserver1 -> hsm2 "Crypto commands" 
		
		
		
        caserver2 -> db "DB R/W" "ODBC"
		
		caserver2 -> hsm2 "Crypto commands" 
		caserver2 -> hsm1 "Crypto commands" 
		
		
		
		
		
       /****************************************
         * Deployment Environments
         ****************************************/
		 
		 
		 
		 
		deploymentEnvironment "Full HA Deployment" {
		
		
			/* tags "Environment" */
		
            deploymentNode "Production Main Site" "Primary production region" {
			
			
				tags "Production"
                
                    deploymentNode "Workstation Subnet" {
                        
                            containerInstance adminclient1
                        
                    }

                    deploymentNode "Production Subnet" {
                        
                            containerInstance caserver1
							containerInstance hsm1
                        

                        
                    }
                
            }
			
			
			
			deploymentNode "DR" "Secondary DR region" {
			
				tags "Disaster Recovery"
			
                    deploymentNode "Workstation Subnet" {
                       
                            containerInstance adminclient2
                        
                    }

                    deploymentNode "DR Subnet" {
                        
                            containerInstance caserver2
							containerInstance hsm2
                        

                        
                    }
                
            }
			
			
			deploymentNode "Database Tier"  "AlwaysOn"{
                            containerInstance db
                        }
			
			
			
        }
		 
		 
		 
		 
		 
		 
		 
		 

        deploymentEnvironment "Production" {
            
                
                    deploymentNode "Public Subnet" {
                        
                            containerInstance adminclient1
                        
                    }

                    deploymentNode "Private Subnet" {
                        
                            containerInstance caserver1
                        

                        
                    }
                
            
        }

        deploymentEnvironment "DR" {
            
                
                    deploymentNode "Public Subnet" {
                        
                            containerInstance adminclient2
                        
                    }

                    deploymentNode "Private Subnet" {
                        
                            containerInstance caserver2
                        

                        
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
			
			
			
			
			
			
    element "Environment" {
        background #E5E7EB
        color #2E3440
        stroke #2E3440
    }

    element "Production" {
        background #E8F0FA
        stroke #2B6CB0
        color #2E3440
    }

    element "Disaster Recovery" {
        background #EAF6EC
        stroke #2F855A
        color #2E3440
    }

    element "Test" {
        background #FFF8E1
        stroke #B7791F
        color #2E3440
    }

    element "Server" {
        background #FFFFFF
        stroke #2E3440
        color #2E3440
    }

    element "Database" {
        shape Cylinder
        background #F3F4F6
        stroke #4C566A
        color #2E3440
    }

    element "HSM" {
        background #FCEDEA
        stroke #9B2C2C
        color #2E3440
    }

    relationship "Encrypted" {
        color #2B6CB0
    }

    relationship "Replication" {
        color #805AD5
    }


			
			
			
			
			
			
			
			
			
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            
            element "Deployment Node" {
                background #eeeeee
                color #000000
            }
        }
    }
}
