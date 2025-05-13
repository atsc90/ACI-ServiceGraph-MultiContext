Cisco Aci is a stateless solution for network traffic, requiring the use of its Service Graph to send traffic to a stateful firewall. However, if the firewall operates in transparent mode and has numerous contexts and VLANs, sending traffic to it becomes a complex design challenge.
Fortunately, there’s a fantastic solution for this kind of design. It’s fully automated using Terraform, and all you need to do is customize it according to your specific network requirements.

Based on image below we have two tenants and the send and response of traffic is fully described. 2 EPGs for client and DataBase GAteWays and both of them are in my-tenant. the inter-tenant is just use for route back the traffic to my-tenant and has L3Out.

![Untitled](https://github.com/user-attachments/assets/3a011c87-4631-4d61-be8a-1158b93968a9)

tips:
the terraform code has two sides
1- For Fabric Side
2- For Tenant SIDE (Use yaml file)
Base On "NEXUS AS A CODE" (https://developer.cisco.com/docs/nexus-as-code/introduction/)

#you can use this method to all kind of firewalls like sophos, fortigate, palo alto, firepower and ... . you want to customize it base on your kind.
