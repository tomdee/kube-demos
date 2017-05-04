#!/usr/bin/env bash

. $(dirname ${BASH_SOURCE})/../util.sh

desc "Create a Namespace for the demo"
run "kubectl create --save-config ns demos"

desc "Run the redis datastore"
run "cat $(relative redis-rc.yaml)"
run "kubectl apply -f $(relative redis-rc.yaml)"

desc "Run a service for redis"
run "cat $(relative redis-svc.yaml)"
run "kubectl apply -f $(relative redis-svc.yaml)"
run "kubectl describe rc redis --namespace=demos"

desc "Use a simple Python app to access redis"
run "cat $(relative app/app.py)"

desc "Run a replication controller for the frontend"
run "cat $(relative frontend-rc.yaml)"
run "kubectl apply -f $(relative frontend-rc.yaml)"

desc "Run a service for the frontend"
run "cat $(relative frontend-svc.yaml)"
run "kubectl apply -f $(relative frontend-svc.yaml)"
run "kubectl describe rc frontend --namespace=demos"
