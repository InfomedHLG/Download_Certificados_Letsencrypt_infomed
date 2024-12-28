## 🔐 Automatización para la Descarga de Certificados de Let's Encrypt

# 📘 Guía para Ejecutar Playbook con Ansible

Sigue estos pasos para usar Ansible de forma manual:

## 1️⃣ Actualizar el Sistema

1. **Actualizar los paquetes del sistema:**
   - Abre una terminal y ejecuta los siguientes comandos para asegurarte de que tu sistema está actualizado:
   ```bash
   sudo apt update
   sudo apt upgrade -y
   ```

## 2️⃣ Instalar Ansible

1. **Instalar Ansible desde los repositorios de Debian:**
   - Ejecuta el siguiente comando para instalar Ansible:
   ```bash
   sudo apt install ansible -y
   ```

## 3️⃣ Clonar el Repositorio

1. **Crear el directorio:**
   - Puedes crear el directorio que desees, por ejemplo:
   ```bash
   mkdir /opt/Download_Certificados_Letsencrypt_infomed
   ```

2. **Cambiar al directorio correcto:**
   - Usa `cd` para cambiar de directorio:
   ```bash
   cd /opt/Download_Certificados_Letsencrypt_infomed
   ```

3. **Clonar el repositorio:**
   - Usa el siguiente comando para clonar el repositorio en ese directorio:
   ```bash
   git clone https://github.com/InfomedHLG/Download_Certificados_Letsencrypt_infomed.git .
   ```
   - **Nota:** El punto (.) al final del comando indica que el repositorio se clonará en el directorio actual en lugar de crear una nueva carpeta.

## 4️⃣ Preparar el Entorno

1. **Crear el archivo de inventario:**
   - Crea un archivo `inventory.yml` con el siguiente contenido, ajustando los hosts según tu entorno:
   ```yaml
   all:
     hosts:
       181.225.253.44:
         ansible_port: 9122
         ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
   ```

2. **Crear el archivo de variables JSON:**
   - Crea un archivo `variables.json` con las variables necesarias. Por ejemplo:
   ```json
   {
       "CERT_URL": "https://example.com/certificates/sample.tar.gz",
       "FINAL_CERT_DIR": "/home/test/Certificados",
       "CERT_DOMAIN": "example.com",
       "GITHUB_API_URL": "https://api.example.com/v1",
       "GITHUB_URL": "https://github.example.com",
       "GIT_USER": "TestUser",
       "GIT_REPO": "test_certificates_repo",
       "GIT_BRANCH": "main",
       "SEND_EMAIL": "false",
       "SEND_TELEGRAM": "false",
       "EMAIL_SMTP_SERVER": "smtp.example.com",
       "EMAIL_SMTP_PORT": 587,
       "EMAIL_SMTP_USER": "testuser@example.com",
       "EMAIL_SMTP_EMAIL": "testuser@example.com",
       "EMAIL_SMTP_TO": "recipient@example.com",
       "EMAIL_SMTP_BCC": "bccrecipient@example.com",
       "disable_notification": "true",
       "disable_web_page_preview": "true",
       "RELEASES_TO_KEEP": "2",
       "DELETE_RELEASES": "false",
       "UPLOAD_RELEASES": "false"
   }
   ```

3. **Crear el archivo de secretos JSON:**
   - Crea un archivo `secretos.json`:
   ```json
   {
       "GIT_TOKEN": "1234567890abcdef1234567890abcdef12345678",
       "EMAIL_SMTP_PASSWORD": "examplepassword123",
       "TELEGRAM_BOT_TOKEN": "123456789:ABCdefGhIjKLmnopQRsTUvWxYz12345678",
       "TELEGRAM_CHAT_ID": "9876543210"
   }
   ```

## 5️⃣ Ejecutar el Playbook

1. **Ejecutar el playbook:**
   - Usa el siguiente comando para ejecutar el playbook, especificando el archivo de inventario y el archivo de variables:
   ```bash
   ansible-playbook -i inventory.yml download_certificados.yml -e @variables.json -e @secretos.json --ask-vault-pass
   ```

## 6️⃣ Programar la Ejecución Automática

1. **Crear un script para ejecutar el playbook:**
   - Crea un archivo de script (por ejemplo, `run_ansible_playbook.sh`) con el siguiente contenido:
   ```bash
   #!/bin/bash

   # Cambiar al directorio donde está el playbook
   cd /opt/Download_Certificados_Letsencrypt_infomed || exit

   # Ejecutar el playbook
   ansible-playbook -i inventory.yml download_certificados.yml -e @variables.json -e @secretos.json
   ```

2. **Hacer el script ejecutable:**
   ```bash
   chmod +x run_ansible_playbook.sh
   ```

3. **Configurar el cron job:**
   - Edita el crontab:
   ```bash
   nano /etc/crontab
   ```

   - Agrega la siguiente línea para programar la ejecución diaria del script:
   ```bash
   0 0 * * * /opt/Download_Certificados_Letsencrypt_infomed/run_ansible_playbook.sh >> /opt/Download_Certificados_Letsencrypt_infomed/playbook.log 2>&1
   ```

4. **Reiniciar el servicio cron:**
   ```bash
   /etc/init.d/cron restart
   ```

---

[🔙 Volver al Proyecto Principal](../)

<p align="center">
Desarrollado con ❤️
</p>
