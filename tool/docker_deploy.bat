@echo off

set CREATE_USER=airc_developer
set REPOSITORY_NAME=dev_ait_template_for_aithub-%CREATE_USER%
set DOCKER_IMAGE_NAME=%REPOSITORY_NAME%:0.1
set REGISTORY=public.ecr.aws%/f3x6l5y4
set REGION=us-east-1

cd /d %~dp0

rem login
aws ecr-public get-login-password --region %REGION% | docker login --username AWS --password-stdin %REGISTORY%

rem �����폜
echo start docker crean up...
docker rmi %DOCKER_IMAGE_NAME%
docker system prune -f
docker rmi %REGISTORY%/%DOCKER_IMAGE_NAME%

rem �r���h
echo start docker build...
docker build -f ..\deploy\container\dockerfile -t %DOCKER_IMAGE_NAME% ..\deploy\container

rem �^�O�t��
echo start docker tag...
docker tag %DOCKER_IMAGE_NAME% %REGISTORY%/%DOCKER_IMAGE_NAME%

rem ���|�W�g���o�^
aws ecr-public create-repository --repository-name %REPOSITORY_NAME% --region %REGION%

rem �v�b�V��
echo start docker push...
docker push %REGISTORY%/%DOCKER_IMAGE_NAME%

rem logout
docker logout

pause