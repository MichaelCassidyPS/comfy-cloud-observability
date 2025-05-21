#!/usr/bin/env bash
# Adds 700 ms artificial delay to the payment service.
kubectl exec deploy/payment -- bash -c 'export DELAY_MS=700'
