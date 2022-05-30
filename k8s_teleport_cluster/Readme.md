# TELEPORT CLUSTER TF MODULE

## HOW TO SETUP ADMIN USER

1. Ensure you have access to the cluster where Teleport Cluster was installed, usually "Common Cluster".
2. Run this command via your terminal or Rancher KUBECTL `kubectl exec -it deploy/teleport -n teleport -- tctl users add admin --roles=editor,access --logins=root,ubuntu,ec2-user,centos --ttl=48h` 
3. Follow the instructions


## HOW TO SETUP A TELEPORT AGENT TOKEN

1. Ensure you have access to the cluster where Teleport Cluster was installed, usually "Common Cluster".
2. Run this command via your terminal or Rancher KUBECTL `kubectl exec -it deploy/teleport -n teleport -- tctl tokens add --type=node,app --ttl=17520h`
3. Add to the env yaml the token generated `auth_token`.