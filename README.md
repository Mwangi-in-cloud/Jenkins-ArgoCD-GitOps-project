## GitOps with 
This repository demonstrates a gitops workflow using jenkins container and argoCD to deploy kubernetes manifests to a k0s cluster.The project integrates jenkins CI/CD with argoCD to allow for automated deployments whenever changes are pushed to the github repo.

### Project Overview
jenkins:Runs as a docker container outside the k0s cluster to handle CI/CD tasks

k0s :Serves as our simple lightweight kubernetes cluster.

ArgoCD : Manages the continous deployments of kubernetes manifests.

Github Webhooks : This triggers the jenkins upon git push events

Manifests directory : Contains kubernetes YAML files for deployment.

### Architecture
Gitpush: Changes to the repo trigger a Github webhook.

Jenkins Pipeline : Jenkins fetches the updated repository and interacts with argoCD to deploy the manifests.

ArgoCD : Synsc with the manifests with the k0s cluster ensuring the cluster state matches the desired configurations.

### Prerequisites
#### Tools
Docker

k0s - lightweight kubernetes cluster

jenkins

ArgoCD CLI

Git

### Setup
A k0s cluster

A GitHub repository with Kubernetes manifest files in a manifests directory.

A Jenkins container running outside the k0s cluster

ArgoCD installed and configured in the k0s cluster