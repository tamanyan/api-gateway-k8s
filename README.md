API Gateway on Kubernetes (GKE)
==========================

This project is API gateway for micro services.
It's developed by [Ingress Controller for Kong](https://github.com/Kong/kubernetes-ingress-controller)

# Requirements

- Docker for Mac
- kubectl
- kubectx
- kustomize
- terraform

# Local Development

## How to deploy

```
make local.deploy
```

## How to clean

```
make local.clean
```

# GKE Development

## How to build

First of all, You need to create kubernetes cluster by using Terraform.

```
make terraform.init
make terraform.build
```

```
make gke.init
make gke.build
```

## How to clean

```
make gke.clean
```
