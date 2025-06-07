@echo off
title Активация Windows 10 Pro через KMS
color 0A

setlocal EnableDelayedExpansion
set KEY=W269N-WFGWX-YVC9B-4J6C9-T83GX
set LOG=%~dp0activation_log.txt

echo ------------------------------ >> "%LOG%"
echo [%DATE% %TIME%] Запуск активации >> "%LOG%"

echo Установка ключа: %KEY%
slmgr /ipk %KEY% >> "%LOG%" 2>&1

set KMS_LIST=kms.digiboy.ir kms8.msguides.com kms.activator.host

set activated=0
for %%K in (%KMS_LIST%) do (
    echo Пробую сервер %%K...
    echo Подключение к %%K >> "%LOG%"
    slmgr /skms %%K >> "%LOG%" 2>&1
    slmgr /ato >> "%LOG%" 2>&1

    timeout /t 3 >nul
    cscript //Nologo slmgr.vbs /xpr | find /i "180" >nul
    if !errorlevel! == 0 (
        echo ✅ Активация прошла успешно через %%K
        echo [%DATE% %TIME%] Успешно: %%K >> "%LOG%"
        set activated=1
        goto end
    ) else (
        echo ❌ Не удалось через %%K
        echo [%DATE% %TIME%] Ошибка: %%K >> "%LOG%"
    )
)

:end
if %activated%==0 (
    echo ❌ Активация не удалась. Попробуйте позже.
    echo [%DATE% %TIME%] Все серверы недоступны >> "%LOG%"
)

echo Готово. Лог сохранён в "%LOG%"
pause >nul
