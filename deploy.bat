@echo off
echo ========================================
echo 🚀 MCP DEPLOY - ANYPOINT CLI v4 + CONNECTED APP
echo ========================================

REM Check CLI
anypoint-cli-v4 --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [❌] Install: npm install -g anypoint-cli-v4
    pause
    exit /b 1
)

REM Build JAR
echo [1/3] Building...
call mvn clean package -DskipTests=true -B -q

set "JAR=target\employee-onboarding-mcp-server-1.0.1-mule-application.jar"
if not exist "%JAR%" (
    echo [❌] JAR missing: %JAR%
    pause
    exit /b 1
)

REM Deploy with CLI
echo [2/3] Deploying to Sandbox...
anypoint-cli-v4 runtime-mgr cloudhub-application deploy ^
  "employee-onboarding-mcp-server" ^
  "%JAR%" ^
  --environment "Sandbox" ^
  --worker "Micro" ^
  --workers 1 ^
  --region "us-east-1"

if %ERRORLEVEL% equ 0 (
    echo.
    echo 🎉✅ DEPLOYED SUCCESSFULLY!
    echo.
    echo Health: https://employee-onboarding-mcp-server.us-east-1.cloudhub.io/mcp/health
    echo API:    https://employee-onboarding-mcp-server.us-east-1.cloudhub.io/mcp/api
) else (
    echo [❌] DEPLOYMENT FAILED
    echo Run: anypoint-cli-v4 runtime-mgr cloudhub-application status "employee-onboarding-mcp-server"
)

pause
