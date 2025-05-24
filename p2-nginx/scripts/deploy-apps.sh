#!/bin/bash

# -- DEPLOY INGRESS CONTROLLER --
# https://kubernetes.github.io/ingress-nginx/deploy/
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.2/deploy/static/provider/cloud/deploy.yaml

kubectl wait --namespace ingress-nginx \
  --for=condition=available \
  --timeout=60s \
  deployment/ingress-nginx-controller

# https://stackoverflow.com/questions/61616203/nginx-ingress-controller-failed-calling-webhook
kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission

# https://kubernetes.io/docs/concepts/workloads/controllers/deployment/
kubectl apply -f /vagrant/conf
