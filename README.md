# Comfy Cloud – Observability Demo (Module 3)

Minimal instructions for the Module 3 demo: attach an OpenTelemetry sidecar, light up CloudWatch Application Signals, create a p95-latency anomaly alarm, inject latency, and watch the alert fire.

---

## Prerequisites

| Tool | Version tested |
|------|----------------|
| **AWS CLI** | ≥ 2.13 |
| **kubectl** | ≥ 1.29 |

1. **Re-create the EKS cluster**

    ```bash
    eksctl create cluster \
      --name dev-eks \
      --region us-east-1 \
      --nodes 2 \
      --node-type t3.medium \
      --vpc-nat-mode=Disable \
      --node-private-networking=false
    ```

2. **Module 1 and Module 2 resources are running**  
   *CodeBuild project `hoodie-build`and SNS topic `ComfyPipelineAlerts`.*

3. **Enable the CloudWatch Observability EKS add-on**  
   Installs the ADOT collector and auto-attaches the IAM policy `AWSXRayDaemonWriteAccess`.  
   Console path: **EKS → dev-eks → Add-ons → Get more add-ons → AWS Distro for OpenTelemetry (ADOT) → Create**  
   CLI alternative:  
   &nbsp;&nbsp;&nbsp;&nbsp;aws eks create-addon \\  
   &nbsp;&nbsp;&nbsp;&nbsp;  --cluster-name dev-eks \\  
   &nbsp;&nbsp;&nbsp;&nbsp;  --addon-name adot \\  
   &nbsp;&nbsp;&nbsp;&nbsp;  --addon-version latest  

4. **Clone this repo and switch to branch `main`**  

    ```bash
    git clone https://github.com/<your-handle>/comfy-cloud-observability.git
    cd comfy-cloud-observability
    ```



5. **Make helper scripts executable**  
   &nbsp;&nbsp;&nbsp;&nbsp;chmod +x scripts/\*.sh  

