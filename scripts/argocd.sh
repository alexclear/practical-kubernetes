#!/bin/bash
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm upgrade --install -n argocd argocd argo/argo-cd --create-namespace -f applications-helm/argocd/argocd/values.yaml --version=5.33.3
kubectl apply -f applications-raw/argocd/project-infrastructure/appproject.yaml -n argocd
kubectl apply -f main-application.yaml -n argocd
