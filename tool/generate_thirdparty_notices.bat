@echo off

rem #####AIT Docker�C���[�W�쐬#####

set DOCKER_IMAGE_NAME=ait_license_base:latest
set REGISTORY=localhost:5500

cd /d %~dp0

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

rem �v�b�V��
echo start docker push...
docker push %REGISTORY%/%DOCKER_IMAGE_NAME%

rem #####AIT���C�Z���X���o��#####

set LICENSE_DOCKER_IMAGE_NAME=ait_license_thirdparty_notices

cd /d %~dp0

rem �����폜
echo start docker crean up...
docker rmi %LICENSE_DOCKER_IMAGE_NAME%
docker system prune -f

rem �r���h
echo start docker build...
docker build -t %LICENSE_DOCKER_IMAGE_NAME% -f ..\deploy\container\dockerfile_license ..\deploy\container

rem ���s
echo run docker...
docker run %LICENSE_DOCKER_IMAGE_NAME%:latest > ../ThirdPartyNotices.txt

pause