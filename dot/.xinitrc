errorlog="${HOME}/.xerrors"

# Настройки логирования и запуск иксов с чистыми логами
if (cp /dev/null "${errorlog}"); then
  chmod 600 "${errorlog}"
  exec >"${errorlog}" 2>&1
fi

wmname LG3D

exec dbus-launch --sh-syntax --exit-with-session awesome
