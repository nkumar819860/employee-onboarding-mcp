@echo off
echo ========================================
echo CLOUDHUB DEPLOY - BYPASS EXCHANGE
echo ========================================

REM Load .env
if exist .env (for /f "tokens=1,2 delims==" %%a in (.env) do set %%a=%%b)

REM 🔥 COMMAND LINE FLAGS OVERRIDE EVERYTHING
mvn clean install -DskipTests=true ^
  -DskipExchangeDeploy=true ^
  -Dmule.deploy.skipExchange=true ^
  -Dmaven.javadoc.skip=true ^
  -Dmaven.source.skip=true ^
  -Dcheckstyle.skip=true ^
  -Dspotless.skip=true

echo.
echo Deploying to CloudHub...
mvn mule:deploy ^
  -DskipTests=true ^
  -DskipExchangeDeploy=true ^
  -Dmule.deploy.skipExchange=true ^
  -Dconnected.app.clientId=%connected.app.clientId% ^
  -Dconnected.app.clientSecret=%connected.app.clientSecret% ^
  -Dapp.name=%app.name% ^
  -Denv.name=%env.name%

echo.
echo 🎉 https://%app.name%.us-east-1.cloudhub.io/mcp/health
pause
