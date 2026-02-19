@echo off
echo ========================================
echo MCP CLOUDHUB DEPLOY - COE AUTH (NO .env)
echo ========================================

REM ========================================
REM COE Business Group = FULL Maven Server Auth
REM ========================================
echo [INFO] Using COE credentials from settings.xml
echo [INFO] App: employee-onboarding-mcp-server
echo [INFO] Env: Sandbox
echo.

REM ========================================
REM SINGLE COMMAND - BUILD + DEPLOY
REM ========================================
mvn clean mule:deploy ^
  -DskipTests=true ^
  -Dapp.name=employee-onboarding-mcp-server ^
  -Denv.name=Sandbox ^
  -Dmule.verbose=true ^
  -DskipExchangeDeploy=true

if %ERRORLEVEL% equ 0 (
    echo.
    echo 🎉 SUCCESS! 
    echo MCP Health: https://employee-onboarding-mcp-server.us-east-1.cloudhub.io/mcp/health
    echo MCP Server: https://employee-onboarding-mcp-server.us-east-1.cloudhub.io/
) else (
    echo [ERROR] Check Runtime Manager logs
)

echo.
pause
