#!/bin/bash
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm upgrade --install -n argocd argocd argo/argo-cd --create-namespace -f applications-helm/argocd/argocd/values.yaml --version=5.33.3
