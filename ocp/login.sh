cp /home/azureuser/ocp/ocp4/auth/kubeconfig /home/azureuser/.kube/config
cp /home/azureuser/ocp/ocp4/auth/kubeadmin-password /home/azureuser/.kube/kubeadmin-password
oc login -u kubeadmin -p $(cat /home/azureuser/.kube/kubeadmin-password);
oc get nodes;
