# Agent Network Deployment Guide

## Prerequisites
Before deploying the agent network YAML, ensure the following:

### 1. MCP Servers Deployed
All three MCP servers must be deployed to CloudHub first:
- `employee-onboarding-mcp-server` → `https://employee-onboarding-mcp-server.us-e1.cloudhub.io`
- `assets-allocation-mcp-server` → `https://assets-allocation-mcp-server.us-e1.cloudhub.io`
- `email-notification-mcp-server` → `https://email-notification-mcp-server.us-e1.cloudhub.io`

### 2. Agent Broker Deployed
The orchestration broker must be deployed:
- `employee-onboarding-agent-broker` → `https://employee-onboarding-agent-broker.us-e1.cloudhub.io`

### 3. Environment Variables Set
Ensure the following environment variables are configured:
```bash
EMPLOYEE_API_KEY=<your-employee-mcp-api-key>
ASSET_API_KEY=<your-asset-mcp-api-key>
NOTIFICATION_API_KEY=<your-notification-mcp-api-key>
GROQ_API_KEY=<your-groq-llm-api-key>
```

## Deployment Steps

### Option 1: Via Anypoint CLI (Recommended)
```bash
# Install Anypoint CLI if not already installed
npm install -g anypoint-cli

# Login to Anypoint Platform
anypoint-cli-v4 conf:env:add --host anypoint.mulesoft.com
anypoint-cli-v4 conf:username:add <your-username>
anypoint-cli-v4 conf:password:add <your-password>

# Deploy the agent network
anypoint-cli-v4 agent-network deploy agent-network/agent-network.yaml
```

### Option 2: Via Anypoint Platform UI
1. Log into Anypoint Platform
2. Navigate to **Agent Fabric** → **Agent Networks**
3. Click **"Deploy Agent Network"**
4. Upload the `agent-network.yaml` file
5. Configure environment variables
6. Click **"Deploy"**

### Option 3: Via Runtime Manager (CloudHub)
1. Go to **Runtime Manager** → **Applications**
2. Click **"Deploy Application"**
3. Select **Agent Network** as application type
4. Upload the YAML file
5. Set environment variables
6. Deploy

## Deployment Verification

### 1. Check Agent Network Status
After deployment, verify the agent network is running:
```bash
anypoint-cli-v4 agent-network list
anypoint-cli-v4 agent-network describe <network-id>
```

### 2. Test MCP Connections
Verify all MCP servers are accessible:
```bash
curl https://employee-onboarding-mcp-server.us-e1.cloudhub.io/health
curl https://assets-allocation-mcp-server.us-e1.cloudhub.io/health  
curl https://email-notification-mcp-server.us-e1.cloudhub.io/health
```

### 3. Test Agent Broker
Verify the orchestration broker is working:
```bash
curl https://employee-onboarding-agent-broker.us-e1.cloudhub.io/health
```

### 4. Test End-to-End Flow
Test a complete onboarding workflow:
```bash
curl -X POST https://employee-onboarding-agent-broker.us-e1.cloudhub.io/api/mcp/tools/orchestrate-employee-onboarding \
  -H "Content-Type: application/json" \
  -d '{
    "firstName": "John",
    "lastName": "Doe", 
    "email": "john.doe@example.com",
    "department": "Engineering",
    "position": "Software Engineer",
    "assets": ["laptop", "id-card"]
  }'
```

## Troubleshooting

### Common Issues

#### 1. MCP Server Connection Failures
**Symptom**: Agent network cannot connect to MCP servers
**Solution**: 
- Verify MCP servers are deployed and running
- Check environment variables are set correctly
- Ensure proper API key authentication

#### 2. Runtime Version Compatibility
**Symptom**: MCP server fails to start with version mismatch
**Solution**:
- The Employee Onboarding MCP server is now configured for Mule Runtime 4.9.5
- Ensure your Anypoint Studio matches this version

#### 3. Health Check Failures
**Symptom**: Health checks return DEGRADED status
**Solution**:
- Check database connections
- Verify H2 database initialization
- Review application logs

#### 4. Agent Network Deployment Failures
**Symptom**: YAML deployment fails with validation errors
**Solution**:
- Validate YAML syntax
- Check all required fields are present
- Verify schema version compatibility

## Post-Deployment Monitoring

### 1. Health Monitoring
Monitor the health endpoints regularly:
- `/health` - Overall system health
- `/mcp/info` - MCP server capabilities

### 2. Log Monitoring  
Check application logs for:
- Connection errors
- Performance issues
- Authentication failures

### 3. Performance Metrics
Monitor key metrics:
- Response times
- Error rates
- Throughput
- Resource utilization

## Support and Maintenance

### Regular Tasks
1. **Weekly**: Check health status of all components
2. **Monthly**: Review performance metrics and logs
3. **Quarterly**: Update dependencies and security patches

### Emergency Contacts
- **Technical Issues**: Contact MuleSoft Support
- **Business Issues**: Contact your organization's IT team
- **Agent Fabric Issues**: Refer to MuleSoft documentation

## Additional Resources
- [Agent Fabric Documentation](https://docs.mulesoft.com/agent-fabric/)
- [MCP Protocol Specification](https://spec.modelcontextprotocol.io/)
- [Anypoint CLI Reference](https://docs.mulesoft.com/anypoint-cli/latest/)
- [CloudHub Deployment Guide](https://docs.mulesoft.com/runtime-manager/cloudhub/)
