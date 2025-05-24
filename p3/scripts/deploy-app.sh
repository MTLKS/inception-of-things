#!/bin/bash

echo "Waiting for argocd-server pod to be Ready..."
kubectl wait --namespace argocd \
  --for=condition=Ready pod \
  -l app.kubernetes.io/name=argocd-server \
  --timeout=180s
echo "Argocd-server pod is Ready."

# https://argo-cd.readthedocs.io/en/stable/getting_started/#1-install-argo-cd
kubectl config set-context --current --namespace=argocd
argocd login --core

# https://argo-cd.readthedocs.io/en/stable/getting_started/#creating-apps-via-cli
kubectl create namespace dev
argocd app create wil --repo https://github.com/MTLKS/argocd-sample.git --path . --dest-server https://kubernetes.default.svc --dest-namespace dev --sync-policy automated