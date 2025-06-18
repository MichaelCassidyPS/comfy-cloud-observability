# Comfy Cloud – Observability Demo (Module 3)

Minimal instructions for the Module 3 demo: attach an OpenTelemetry sidecar, light up CloudWatch Application Signals, create a p95-latency anomaly alarm, inject latency, and watch the alert fire.

---

## Prerequisites

| Tool | Version tested |
|------|----------------|
| **AWS CLI** | ≥ 2.13 |
| **kubectl** | ≥ 1.29 |

1. **Module 1 and Module 2 resources are running**  
   *EKS cluster `dev-eks`, CodeBuild project `hoodie-build`, SNS topic `ComfyPipelineAlerts`.*

2. **Enable the CloudWatch Observability EKS add-on**  
   Installs the ADOT collector and auto-attaches the IAM policy `AWSXRayDaemonWriteAccess`.  
   Console path: **EKS → dev-eks → Add-ons → Get more add-ons → AWS Distro for OpenTelemetry (ADOT) → Create**  
   CLI alternative:  
   &nbsp;&nbsp;&nbsp;&nbsp;aws eks create-addon \\  
   &nbsp;&nbsp;&nbsp;&nbsp;  --cluster-name dev-eks \\  
   &nbsp;&nbsp;&nbsp;&nbsp;  --addon-name adot \\  
   &nbsp;&nbsp;&nbsp;&nbsp;  --addon-version latest  

3. **Clone this repo and switch to branch `main`**  
   &nbsp;&nbsp;&nbsp;&nbsp;git clone https://github.com/&lt;your-handle&gt;/comfy-cloud-observability.git  
   &nbsp;&nbsp;&nbsp;&nbsp;cd comfy-cloud-observability  

4. **Make helper scripts executable**  
   &nbsp;&nbsp;&nbsp;&nbsp;chmod +x scripts/\*.sh  

That’s all you need—everything else happens live in the AWS console during the video.

