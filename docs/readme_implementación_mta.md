# 🔐 Automatización para la Descarga de Certificados de Let's Encrypt

## 7: 📨 Configuración del Servidor de Correo

## Descripción

En caso de querer enviar correos electrónicos desde el servidor, se debe configurar el MTA (Mail Transfer Agent) para el envío de correos electrónicos a través de la línea de comandos utilizando `mailx`. Es ideal para automatizar notificaciones y mensajes desde sistemas basados en Linux.

## Instalación

Para instalar y configurar el entorno necesario para utilizar este servidor, sigue los siguientes pasos:

1. **Instalar `msmtp`**:
   `msmtp` es un cliente SMTP que se puede utilizar como un agente de transporte de correo (MTA) para enviar correos electrónicos. Para instalarlo, ejecuta:
   ```bash
   sudo apt-get install msmtp
   ```

2. **Instalar `mailx`**:
   ```bash
   sudo apt-get update
   sudo apt-get install mailutils
   ```

3. **Configurar `msmtp`**:
   Crea o edita el archivo de configuración `/etc/msmtprc` con los detalles de tu servidor SMTP. Asegúrate de que el archivo tenga permisos seguros:
   ```bash
   chmod 600 /etc/msmtprc
   ```

   Un ejemplo de configuración para Gmail podría ser:
   ```plaintext
   defaults
   auth           on
   tls            on
   tls_trust_file /etc/ssl/certs/ca-certificates.crt
   logfile        /var/log/msmtp/msmtp.log
   timeout        60

   account gmail
   host smtp.gmail.com
   port 587
   from usuario@gmail.com
   user usuario@gmail.com
   password passwordGmail

   tls_starttls   on
   tls_certcheck  on

   account default : gmail
   ```

4. **Eliminar configuraciones sobrantes**:
   Si no planeas usar Postfix, considera purgarlo por completo:
   ```bash
   sudo apt purge postfix
   sudo apt autoremove
   ```

5. **Configurar `mailx` para usar `msmtp`**:
   Edita o crea el archivo `~/.mailrc` y agrega estas líneas para indicarle a `mailx` que utilice `msmtp` como programa de envío:
   ```plaintext
   set sendmail=/usr/bin/msmtp
   set message-sendmail-extra-args="-a default"
   ```

6. **Crear enlace simbólico para `sendmail`**:
   ```bash
   ln -s /usr/bin/msmtp /usr/sbin/sendmail
   ```

## Modo de uso

Para especificar la cuenta que deseas usar con el comando `mailx`, puedes utilizar diferentes opciones. Aquí te muestro varias formas:

1. **Usando `msmtp` directamente**:
   ```bash
   echo "Este es un correo de prueba" | msmtp --debug -a default destinatario@correo.com
   ```

2. **Usando la opción `-a` (account) con `mailx`**:
   ```bash
   echo "Este es un mensaje de prueba" | mailx -s "Asunto" -a gmail ssanchezhlg@gmail.com
   ```

---

[🔙 Volver al Proyecto Principal](../)

<p align="center">
Desarrollado con ❤️
</p>