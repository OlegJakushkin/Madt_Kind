#!/usr/bin/env bash
cd ~/istio-1.6.0
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')