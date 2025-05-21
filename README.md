# comfy-cloud-observability

# Comfy Cloud Observability Demo 


---

## Prerequisites  
• EKS cluster with the **checkout** Deployment (from Module 1).  
• SNS topic **ComfyPipelineAlerts** (created in Module 2).  
• AWS CLI v2 and **kubectl** configured for the same AWS account / region.  
• Files from this repo:  
  • `k8s/adot-sidecar-patch.json` – JSON patch that adds the ADOT collector as a sidecar  
  • `scripts/load_test.sh` – 30-second traffic generator  
  • `alarm/p95-latency-alarm.json` – CloudWatch alarm template  
  • `scripts/induce_latency.sh` – adds a 700 ms delay to the **payment** service  

---

## 1  Deploy the ADOT sidecar  
$ kubectl patch deployment checkout -n default --type=json \  
  -p "$(cat k8s/adot-sidecar-patch.json)"  
→ Wait until the new pod shows **2/2 READY** (`kubectl get pods`).

---

## 2  Generate load and create traces  
$ scripts/load_test.sh http://<ALB_URL>/checkout?items=hoodie  
(30 seconds of traffic ≈ 900 traces.)

---

## 3  Find the slow dependency in ServiceLens  
Open *CloudWatch → X-Ray → Service map* → filter for **checkout**.  
The **payment** node should be orange/red. Click it to inspect traces and confirm high latency.

---

## 4  Create a p95-latency alarm linked to SNS  
$ aws cloudwatch put-metric-alarm --cli-input-json file://alarm/p95-latency-alarm.json  
Ensure the **AlarmActions** ARN inside the JSON targets **ComfyPipelineAlerts**.

---

## 5  Trigger latency and verify alerts  
$ scripts/induce_latency.sh                          # inject 700 ms delay  
$ scripts/load_test.sh http://<ALB_URL>/checkout?items=hoodie  

Within ~60 s you should see:  
• **Checkout-P95-Latency** alarm in **ALARM** state  
• Notifications in Alex’s inbox and the dev Slack channel  
• Charlie inspects the trace, removes the delay, and latency returns to normal.

---

## Clean-up (optional)  
$ kubectl rollout undo deployment checkout  
$ aws cloudwatch delete-alarms --alarm-names Checkout-P95-Latency  

You now have full **trace → map → alarm → notification** visibility for Comfy Cloud’s checkout workflow.
