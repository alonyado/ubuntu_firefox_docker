Creation of "isolated" container with latest firefox and lateset ubuntu.
The aim is to create a sandbox environment whihc is more secured and private.

Steps:
1. run rebuild.sh (can provide 2 arguments: name of desired user and uid of that user. Default is 1001)
2. Use run.sh to run the firefox from the container

you can copy firefox_docker.desktop to your desktop to execute firefox by clicking on this.

If rebuild.sh fails due to "useradd: UID X is not unique", please change the uid in rebuild
