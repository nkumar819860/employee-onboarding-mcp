# Employee Onboarding Agent Fabric Workspace

This workspace is organized according to Mule Agent Fabric standards for proper execution in VSCode.

## 🏗️ Project Structure

```
employee-onboarding-mcp/
├── agent-network/                           # Agent Network Configuration
│   ├── agent-network.yaml                  # Main agent network definition
│   ├── exchange.json                       # Exchange metadata
│   └── .env                                # Environment variables
├── mcp-servers/                            # MCP Server Applications
│   ├── employee-onboarding-mcp-server/     # Employee management MCP
│   ├── assets-allocation-mcp-server/       # Asset allocation MCP
│   └── email-notification-mcp-server/      # Email notification MCP
├── brokers/                                # Agent Broker Applications
│   └── employee-onboarding-agent-broker/   # Main orchestration broker
├── mule-workspace.yaml                     # Workspace configuration
├── employee-onboarding-agent-fabric.code-workspace  # VSCode workspace
└── README-AGENT-FABRIC-WORKSPACE.md       # This file
```

## 🚀 Getting Started

### Prerequisites

1. **VSCode Extensions**: Install the recommended extensions:
   - Salesforce Mule DX for VSCode
   - Salesforce Mule Agent Fabric Extension
   - Java Extension Pack
   - YAML Support

2. **Java Runtime**: Java 8 or 11 (required for Mule runtime)

3. **Maven**: Apache Maven 3.6+ (for building projects)

### Opening the Workspace

1. **Open VSCode**
2. **File → Open Workspace from File**
3. **Select**: `employee-onboarding-agent-fabric.code-workspace`

This will open the workspace with four organized folders:
- **Agent Network**: Configuration and deployment files
- **MCP Servers**: All MCP server applications
- **Agent Brokers**: Orchestration broker applications
- **Documentation**: Root-level documentation and configs

## 🔧 Development Workflow

### 1. Building Projects

Use VSCode Command Palette (`Ctrl+Shift+P`):
- **Tasks: Run Task** → **Build All Projects**

Or run individually:
- **Build Employee Onboarding MCP**
- **Build Assets Allocation MCP**
- **Build Email Notification MCP**
- **Build Agent Broker**

### 2. Running Applications

#### Start All MCP Servers (Recommended)
```bash
# Command Palette → Tasks: Run Task → Start All MCP Servers
```

#### Start Individual Components
- **Start Employee Onboarding MCP** (Port: 8082)
- **Start Assets Allocation MCP** (Port: 8083)
- **Start Email Notification MCP** (Port: 8084)
- **Start Agent Broker** (Port: 8081)

### 3. Debugging

Set breakpoints and attach debugger:
- **Debug Employee Onboarding MCP** (Port: 5006)
- **Debug Assets Allocation MCP** (Port: 5007)
- **Debug Email Notification MCP** (Port: 5008)
- **Debug Agent Broker** (Port: 5005)

## 🌐 Agent Network Deployment

### Local Development
The agent network is configured for local development with connections to:
- Employee Onboarding MCP: `http://localhost:8082`
- Assets Allocation MCP: `http://localhost:8083`
- Email Notification MCP: `http://localhost:8084`
- Agent Broker: `http://localhost:8081`

### Environment Configuration
Update the `.env` files in each component with appropriate values:

```bash
# agent-network/.env
EMPLOYEE_API_KEY=your-employee-api-key
ASSET_API_KEY=your-asset-api-key
NOTIFICATION_API_KEY=your-notification-api-key
GROQ_API_KEY=your-groq-api-key
```

## 🔄 Startup Sequence

The recommended startup order is automated in the workspace:

1. **MCP Servers** (parallel startup):
   - Employee Onboarding MCP Server
   - Assets Allocation MCP Server
   - Email Notification MCP Server

2. **Agent Broker**:
   - Employee Onboarding Agent Broker

3. **Agent Network**:
   - Deploy/Configure via Mule Agent Fabric CLI

## 📊 Health Checks

Each component provides health check endpoints:
- Employee Onboarding: `http://localhost:8082/health`
- Assets Allocation: `http://localhost:8083/health`
- Email Notification: `http://localhost:8084/health`
- Agent Broker: `http://localhost:8081/health`

## 🛠️ Database Configuration

All MCP servers now use **script-based H2 database initialization**:
- **Employee Onboarding**: `init-h2.sql` with employee/department schemas
- **Assets Allocation**: `init-h2.sql` with asset/allocation schemas
- **Email Notification**: No database (template-based)

## 🔧 Key Features

### Production-Grade Database Initialization
- PostgreSQL compatibility mode
- Proper sequence management
- Referential integrity controls
- Sample data initialization
- Performance indexes

### Agent Fabric Integration
- Contract-first API development with APIKit
- Comprehensive error handling
- Health monitoring
- CORS support
- Environment-aware configuration

### Development Experience
- Hot reload capabilities
- Integrated debugging
- Build automation
- Multi-project workspace
- Task orchestration

## 📁 File Organization

### Original vs. Organized Structure

**Before (Flat Structure):**
```
employee-onboarding-mcp/
├── employee-onboarding-mcp-server/
├── assets-allocation-mcp-server/
├── email-notification-mcp-server/
├── employee-onboarding-agent-broker/
└── agent-network/
```

**After (Agent Fabric Standard):**
```
employee-onboarding-mcp/
├── agent-network/           # 🎯 Agent Network
├── mcp-servers/            # 🔧 MCP Servers
├── brokers/               # 🤖 Agent Brokers
└── *.code-workspace       # 📋 VSCode Config
```

## 🎯 Benefits of This Organization

1. **Clear Separation of Concerns**: Each folder has a specific purpose
2. **VSCode Integration**: Optimized for development workflow
3. **Agent Fabric Compliance**: Follows MuleSoft standards
4. **Scalability**: Easy to add new MCP servers or brokers
5. **Team Collaboration**: Clear project boundaries
6. **Debugging**: Isolated debugging configurations
7. **Build Management**: Parallel builds and deployments

## 🚀 Next Steps

1. **Open the workspace**: `employee-onboarding-agent-fabric.code-workspace`
2. **Install extensions**: Follow the recommendations
3. **Build projects**: Run "Build All Projects" task
4. **Start services**: Run "Start All MCP Servers" task
5. **Test integration**: Use health check endpoints
6. **Deploy agent network**: Configure via Mule Agent Fabric CLI

## 📞 Support

For issues with:
- **MCP Servers**: Check individual project logs in `mcp-servers/`
- **Agent Broker**: Check broker logs in `brokers/`
- **Agent Network**: Review `agent-network/agent-network.yaml`
- **VSCode Setup**: Verify extensions and workspace settings

---

**Ready to develop with Mule Agent Fabric! 🚀**
