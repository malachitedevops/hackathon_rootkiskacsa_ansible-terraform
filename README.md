# Green Fox Hackathon 2019 September - Team Rootkiskacsa

## Our repositories:
##### [Backend](https://github.com/malachitedevops/hackaton_rootkiskacsa_backend)
##### [Authenticator](https://github.com/malachitedevops/hackathon_rootkiskacsa_auth)
##### [Terraform and Ansible files](https://github.com/malachitedevops/hackathon_rootkiskacsa_ansible-terraform)

### Initialize the infrastructure with Terraform and Ansible
The command *terraform apply* will initiate three separate AWS instances: an EC2 for the application, another EC2 for Elastic Stack monitoring, and an encrypted RDS instance for the (MySQL) database.
**Terraform** will then call on **Ansible** to take care of configuration management. It also copies a *docker-compose.yml*, which will run the backend and an authentication interface with **Docker Compose**.

### Continuous Deployment with Jenkins
Our repositories are hooked to Github, and every merge to the master branch will call on **Jenkins** to start a multibranch pipeline, which will essentially update the docker images, and restart the service on the remote server. Of course only these machines can access the encrypted database.

### Monitoring with Elastic Stack
**Elastic Stack** will check on the application every minute. A cron job will also initiate a **Python3** script, which will check on the logs, and will alert the sysadmin via email to take action if the system has unacceptable amount of downtimes.

### Make queries on our simple frontend
Our backend is tied to a simple frontend to make queries to the database. With the help of this application, you can register, validate, block and query bankcards at ease.

