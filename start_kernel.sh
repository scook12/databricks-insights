#!/bin/bash
jupyter kernelgateway --KernelGatewayApp.ip=0.0.0.0 \
--KernelGatewayApp.port=9999 \
--KernelGatewayApp.allow_origin='*' \
--KernelGatewayApp.allow_credentials='*' \
--KernelGatewayApp.allow_headers='*' \
--KernelGatewayApp.allow_methods='*' \
--JupyterWebsocketPersonality.list_kernels=True