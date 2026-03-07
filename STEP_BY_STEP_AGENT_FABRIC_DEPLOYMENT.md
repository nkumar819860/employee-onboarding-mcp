# Step-by-Step Agent Fabric Deployment Guide

## Overview
This guide will walk you through deploying your Employee Onboarding Agent Fabric to the MuleSoft Anypoint Platform step-by-step.

## Prerequisites Checklist
Before starting, ensure you have:
- [ ] MuleSoft Anypoint Platform account with Agent Fabric access
- [ ] All MCP servers deployed to CloudHub
- [ ] Agent Broker deployed to CloudHub  
- [ ] Groq API key for LLM integration
- [ ] API keys for MCP server authentication

---

## STEP 1: Prepare Environment Variables

### 1.1 Gather Required API Keys
You'll need these environment variables:

```bash
# MCP Server Authentication Keys
EMPLOYEE_API_KEY=your-employee-mcp-server-api-key
ASSET_API_KEY=your-asset-mcp-server-api-key
NOTIFICATION_API_KEY=your-notification-mcp-server-api-key

# LLM Integration
GROQ_API_KEY=your-groq-api-key-from-console.groq.com
```

### 1.2 How to Get Groq API Key
1. Go to https://console.groq.com/
2. Sign up or log in
3. Navigate to "API Keys" section
4. Create a new API key
5. Copy the key (starts with `gsk_...`)

---

## STEP 2: Access Anypoint Platform

### 2.1 Login to Anypoint Platform
1. Go to https://anypoint.mulesoft.com/
2. Log in with your MuleSoft credentials
3. Select your organization if prompted

### 2.2 Navigate to Agent Fabric
1. From the main navigation, click on **"Agent Fabric"**
2. If you don't see it, check if Agent Fabric is enabled for your organization
3. You should see the Agent Fabric dashboard

---

## STEP 3: Deploy Agent Network (Method 1 - UI)

### 3.1 Create New Agent Network
1. In Agent Fabric, click **"Create Agent Network"**
2. Choose **"Import from YAML"**
3. Click **"Upload File"**
4. Select the `agent-network-deployment-ready.yaml` file
5. Click **"Next"**

### 3.2 Configure Environment Variables
1. In the configuration screen, you'll see environment variable fields:
   ```
   EMPLOYEE_API_KEY: [Enter your employee MCP API key]
   ASSET_API_KEY: [Enter your asset MCP API key]  
   NOTIFICATION_API_KEY: [Enter your notification MCP API key]
   GROQ_API_KEY: [Enter your Groq API key]
   ```
2. Fill in all the required values
3. Click **"Validate Configuration"**

### 3.3 Deploy Network
1. Review the deployment summary
2. Click **"Deploy Agent Network"**
3. Wait for deployment to complete (usually 2-5 minutes)
4. You should see "Deployment Successful" message

---

## STEP 4: Deploy Agent Network (Method 2 - CLI)

### 4.1 Install Anypoint CLI
```bash
# Install Node.js if not already installed
# Then install Anypoint CLI
npm install -g @mulesoft/anypoint-cli-v4
```

### 4.2 Configure CLI Authentication
```bash
# Set up authentication
anypoint-cli-v4 conf organization set <your-org-id>
anypoint-cli-v4 conf username set <your-username>
anypoint-cli-v4 conf password set <your-password>

# Or use connected app (recommended for production)
anypoint-cli-v4 conf client_id set <connected-app-client-id>
anypoint-cli-v4 conf client_secret set <connected-app-secret>
```

### 4.3 Set Environment Variables
Create a `.env` file in your deployment directory:
```bash
# Create .env file
cat > .env << EOF
EMPLOYEE_API_KEY=your-employee-mcp-server-api-key
ASSET_API_KEY=your-asset-mcp-server-api-key
NOTIFICATION_API_KEY=your-notification-mcp-server-api-key
GROQ_API_KEY=your-groq-api-key
EOF
```

### 4.4 Deploy via CLI
```bash
# Load environment variables
source .env

# Deploy the agent network
anypoint-cli-v4 agent-fabric network deploy \
  --file agent-network-deployment-ready.yaml \
  --environment production \
  --name "Employee Onboarding Network"
```

---

## STEP 5: Verify Deployment

### 5.1 Check Agent Network Status
**Via UI:**
1. Go to Agent Fabric → Agent Networks
2. Find "Employee Onboarding Agent Network"
3. Status should show "Running" or "Active"
4. Click on the network to see details

**Via CLI:**
```bash
# List all networks
anypoint-cli-v4 agent-fabric network list

# Get specific network details
anypoint-cli-v4 agent-fabric network describe <network-id>
```

### 5.2 Test MCP Server Health
Test each MCP server health endpoint:

```bash
# Test Employee MCP Server
curl -X GET https://employee-onboarding-mcp-server.us-e1.cloudhub.io/health

# Test Assets MCP Server  
curl -X GET https://assets-allocation-mcp-server.us-e1.cloudhub.io/health

# Test Notification MCP Server
curl -X GET https://email-notification-mcp-server.us-e1.cloudhub.io/health

# Test Agent Broker
curl -X GET https://employee-onboarding-agent-broker.us-e1.cloudhub.io/health
```

All should return status "HEALTHY" or "UP".

### 5.3 Test Agent Network Integration
Test the agent network's ability to connect to MCP servers:

```bash
# Test MCP info endpoints through agent network
curl -X GET https://employee-onboarding-mcp-server.us-e1.cloudhub.io/mcp/info
curl -X GET https://assets-allocation-mcp-server.us-e1.cloudhub.io/mcp/info  
curl -X GET https://email-notification-mcp-server.us-e1.cloudhub.io/mcp/info
```

---

## STEP 6: Test End-to-End Workflow

### 6.1 Test Complete Onboarding Process
```bash
curl -X POST https://employee-onboarding-agent-broker.us-e1.cloudhub.io/api/mcp/tools/orchestrate-employee-onboarding \
  -H "Content-Type: application/json" \
  -H "X-API-Key: ${EMPLOYEE_API_KEY}" \
  -d '{
    "firstName": "Test",
    "lastName": "Employee", 
    "email": "test.employee@example.com",
    "department": "Engineering",
    "position": "Software Engineer",
    "startDate": "2026-03-10",
    "assets": ["laptop", "id-card"],
    "manager": "John Manager",
    "managerEmail": "john.manager@example.com",
    "companyName": "Test Company"
  }'
```

**Expected Response:**
```json
{
  "status": "success",
  "message": "Employee onboarding orchestration completed successfully",
  "employeeId": "EMP123",
  "onboardingSteps": {
    "profileCreation": {"status": "completed"},
    "assetAllocation": {"status": "completed"},
    "welcomeEmail": {"status": "completed"},
    "assetNotification": {"status": "completed"},
    "onboardingComplete": {"status": "completed"}
  }
}
```

### 6.2 Test AI-Powered Natural Language Processing
```bash
curl -X POST https://employee-onboarding-agent-broker.us-e1.cloudhub.io/api/mcp/tools/think \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Plan onboarding for a senior developer named Sarah who will work remotely in the AI team"
  }'
```

---

## STEP 7: Monitor and Maintain

### 7.1 Set Up Monitoring
1. **In Anypoint Platform:**
   - Go to Monitoring → Agent Fabric
   - Set up alerts for network health
   - Configure notification preferences

2. **Health Check Monitoring:**
   - Agent networks automatically monitor MCP server health
   - Check the Agent Fabric dashboard for status updates

### 7.2 View Logs and Analytics
1. **Agent Network Logs:**
   - Go to Agent Fabric → Networks → Your Network → Logs
   - Filter by time range and log level

2. **MCP Server Logs:**
   - Go to Runtime Manager → Applications
   - Click on each MCP server to view logs

---

## Troubleshooting Common Issues

### Issue 1: "Network Failed to Deploy"
**Symptoms:** Deployment fails with validation errors
**Solutions:**
1. Check YAML syntax is valid
2. Verify all environment variables are set
3. Ensure MCP server URLs are accessible
4. Check API keys are valid

### Issue 2: "MCP Server Connection Failed"
**Symptoms:** Agent network can't connect to MCP servers
**Solutions:**
1. Verify MCP servers are deployed and running
2. Check health endpoints return 200 status
3. Verify API keys in environment variables
4. Check network connectivity

### Issue 3: "LLM Integration Not Working"
**Symptoms:** AI features not responding
**Solutions:**
1. Verify Groq API key is valid
2. Check Groq service status
3. Ensure network has internet access
4. Review LLM configuration in YAML

### Issue 4: "Workflow Steps Failing"
**Symptoms:** Onboarding steps fail or timeout
**Solutions:**
1. Check individual MCP server logs
2. Verify database connections in MCP servers
3. Check for network timeouts
4. Review error messages in agent broker logs

---

## Next Steps After Deployment

### 1. Production Readiness
- [ ] Set up monitoring alerts
- [ ] Configure backup procedures  
- [ ] Implement security best practices
- [ ] Set up log aggregation

### 2. User Training
- [ ] Train HR team on natural language requests
- [ ] Create user documentation
- [ ] Set up support procedures
- [ ] Conduct user acceptance testing

### 3. Scaling and Optimization
- [ ] Monitor performance metrics
- [ ] Optimize based on usage patterns
- [ ] Plan for increased load
- [ ] Consider additional features

## Support Contacts
- **Technical Issues**: MuleSoft Support Portal
- **Agent Fabric Questions**: MuleSoft Documentation
- **API Issues**: Review individual MCP server logs
- **LLM Issues**: Groq support documentation

**Deployment Complete!** 🎉

Your Employee Onboarding Agent Fabric is now ready for production use with AI-powered automation, intelligent error handling, and comprehensive monitoring.
