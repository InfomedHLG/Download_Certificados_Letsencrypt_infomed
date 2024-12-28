## 🔐 Automatización para la Descarga de Certificados de Let's Encrypt

# 🛠️ Mantenimiento de Certificados con Bash

Este script en Bash ofrece una solución más sencilla que un playbook para mantener los certificados actualizados. Su función principal es notificar por correo electrónico cuando los certificados han sido actualizados. No incluye la capacidad de notificar vía Telegram ni de subir los certificados a un repositorio de Git. Sin embargo, opcionalmente, puede ejecutar otro script para realizar funciones adicionales, como copiar los certificados a otros servidores.

## 📖 Guía Básica de Funcionamiento

1. **⬇️ Descarga de Certificados:**
   - El script inicia descargando un archivo comprimido `le.tar.gz` desde una URL específica.

2. **⚙️ Preparación del Entorno:**
   - Define variables para el dominio, rutas de certificados y rutas temporales.
   - Elimina cualquier archivo `.pem` existente en la ruta temporal.

3. **📂 Descompresión y Selección de Certificados:**
   - Descomprime el archivo descargado en una carpeta temporal.
   - Identifica los últimos archivos de certificados (`cert.pem`, `chain.pem`, `fullchain.pem`, `privkey.pem`) basándose en un patrón numérico.

4. **🔍 Comparación de Certificados:**
   - Verifica si el certificado descargado es más reciente que el local.
   - Si el certificado remoto es más reciente, reemplaza los certificados locales y envía una notificación por correo electrónico.

5. **📧 Notificaciones:**
   - Envía correos electrónicos a los administradores para notificar sobre la actualización de los certificados o si no se requiere actualización.

6. **🧹 Limpieza:**
   - Elimina archivos temporales y el archivo comprimido descargado.

## ⚙️ Configuración

### ✉️ Opciones de Notificación

- **Activar/Desactivar Envío de Correos:**
  ```bash
  ENVIAR_CORREO=false
  ```

- **Activar/Desactivar Ejecución del Script de Copia de Certificados:**
  ```bash
  EJECUTAR_SCRIPT_COPIA=true
  ```

- **Personalización de Asunto y Mensaje de Correo:**
  ```bash
  ASUNTO_NOT1="Asunto de Notificación 1"
  MESSAGE_NOT1="Mensaje de Notificación 1"

  ASUNTO_NOT2="Asunto de Notificación 2"
  MESSAGE_NOT2="Mensaje de Notificación 2"
  ```

### ⏰ Configuración del Cron Job

1. Edita el crontab:
   ```bash
   nano /etc/crontab
   ```

2. Agrega la siguiente línea para programar la ejecución diaria del script:
   ```bash
   0 0 * * * /url/local/bin/descargar_certificado_infomed.sh 2>&1
   ```

3. Reinicia el servicio cron:
   ```bash
   /etc/init.d/cron restart
   ```

---

[🔙 Volver al Proyecto Principal](../)

<p align="center">
Desarrollado con ❤️
</p>
