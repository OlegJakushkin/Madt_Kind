#!/bin/bash
# Create the bookinfo gateway in cluster1:
kubectl apply --context=$CTX_CLUSTER1 -f samples/bookinfo/networking/bookinfo-gateway.yaml
# Define the ingress gateway for the application:
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
# Determine if your Kubernetes cluster is running
kubectl get svc istio-ingressgateway -n istio-system
# Set the ingress ports:
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')
export TCP_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="tcp")].nodePort}')
# Setting the ingress IP depends on the cluster provider:
# export INGRESS_HOST=15.0.0.1
export INGRESS_HOST=$(kubectl get po -l istio=ingressgateway -n istio-system -o jsonpath='{.items[0].status.hostIP}')
# Set GATEWAY_URL:
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
# To confirm that the Bookinfo application is accessible from outside the cluster:
curl -s "http://${GATEWAY_URL}/productpage" | grep -o "<title>.*</title>"
# result: <title>Simple Bookstore App</title>