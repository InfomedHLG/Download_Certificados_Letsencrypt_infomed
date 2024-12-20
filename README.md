```markdown
# Playbook de Descarga y Gestión de Certificados Let's Encrypt

## Descripción
Este playbook de Ansible automatiza el proceso de descarga, actualización y gestión de certificados Let's Encrypt, incluyendo notificaciones por correo electrónico y Telegram.

## Funcionalidades Principales

### 1. Gestión de Certificados
- Descarga certificados desde un servidor FTP
- Compara las fechas de expiración entre certificados locales y remotos
- Actualiza automáticamente cuando encuentra versiones más recientes
- Mantiene un directorio local organizado con los certificados

### 2. Control de Versiones
- Integración automática con GitHub
- Clona/actualiza el repositorio cuando hay nuevos certificados
- Realiza commits con mensajes descriptivos incluyendo fechas de expiración
- Mantiene un historial de actualizaciones

### 3. Sistema de Notificaciones
- **Correo Electrónico:**
  - Envía notificaciones detalladas sobre actualizaciones
  - Incluye archivos comprimidos con los certificados
  - Soporta múltiples destinatarios (TO y BCC)

- **Telegram:**
  - Envía mensajes de estado en tiempo real
  - Comparte archivos comprimidos con los certificados
  - Formato HTML para mejor presentación

## Variables Principales
```yaml
final_cert_dir: Directorio destino de los certificados
send_email: Activar/desactivar notificaciones por correo
send_telegram: Activar/desactivar notificaciones por Telegram
```

## Requisitos
- Ansible 2.9 o superior
- Acceso a servidor FTP
- Credenciales de GitHub configuradas
- Bot de Telegram (para notificaciones)
- Servidor SMTP configurado

## Configuración
1. Ajustar las variables en el playbook según necesidades:
   - Credenciales SMTP
   - Token de Telegram
   - Datos del repositorio GitHub
   - Rutas de directorios

2. Asegurar permisos de escritura en directorios destino

## Ejecución
```bash
ansible-playbook download_certificados.yml
```

## Notas Importantes
- El playbook verifica automáticamente las fechas de expiración
- Solo actualiza cuando encuentra certificados más recientes
- Mantiene logs detallados de todas las operaciones
- Limpia automáticamente archivos temporales

## Mantenimiento
- Se recomienda revisar periódicamente los logs
- Verificar las notificaciones de correo/Telegram
- Actualizar credenciales según sea necesario
```


# Guía de Implementación del Playbook en SemaphoreUI

## 1. Configuración Inicial

### Crear Proyecto Nuevo
1. En el Dashboard, clic en "New Project"
2. Completar:
   - Nombre: "Gestión Certificados Let's Encrypt"
   - Descripción: "Automatización de descarga y gestión de certificados SSL"

### Configurar Repositorio
1. Ir a "Environment"
2. Añadir repositorio:
   - Tipo: Git
   - URL: `https://github.com/tu-usuario/tu-repo.git`
   - Branch: `main`
   - Credenciales Git (si es privado)

## 2. Configuración del Inventario

1. Ir a "Inventory" → "Add Inventory"
2. Crear nuevo inventario:
```ini
[all]
servidor-certificados ansible_host=tu.servidor.com ansible_user=usuario
```

## 3. Configuración de Variables

### Variables de Entorno
1. Ir a "Environment" → "Add Environment"
2. Crear nuevo ambiente con las siguientes variables:

```yaml
# Directorios
final_cert_dir: /home/Descarga-Certificados
temp_dir: /tmp/repo

# GitHub
token: "tu-token-github"
host: "github.local.softnet.cu"
user: "tu-usuario"
repo: "download_certificados_LetsEncrypt-Infomed"
BRANCH: "main"

# Notificaciones
send_email: "true"
send_telegram: "true"

# SMTP
smtp_server: "smtp.dominio.com"
smtp_port: 25
smtp_user: "tu-correo@dominio.com"
smtp_password: "tu-contraseña"
from_email: "tu-correo@dominio.com"
to_email: "destinatario@dominio.com"
bcc_email: "copia@dominio.com"

# Telegram
telegram_bot_token: "tu-token-bot"
telegram_chat_id: "tu-chat-id"
```

## 4. Configuración de la Tarea

1. Ir a "Tasks" → "Add Task"
2. Configurar nueva tarea:
   - Nombre: "Actualización Certificados SSL"
   - Playbook: `download_certificados.yml`
   - Inventario: Seleccionar el creado anteriormente
   - Environment: Seleccionar el creado con las variables

## 5. Configuración de Programación

1. Ir a "Schedule" → "Add Schedule"
2. Configurar:
   - Nombre: "Actualización Diaria Certificados"
   - Tipo: Cron
   - Expresión: `0 0 * * *` (ejecutar diariamente a medianoche)
   - Task: Seleccionar la tarea creada

## 6. Configuración de Acceso SSH

1. Ir a "Keys" → "Add Key"
2. Añadir clave SSH:
   - Tipo: SSH Key
   - Nombre: "Access-Certificados"
   - Contenido: Tu clave privada SSH

## 7. Configuración de Notificaciones

1. Ir a "Notifications" → "Add"
2. Configurar alertas para:
   - Éxito de tarea
   - Fallo de tarea
   - Seleccionar canales (email/telegram)

## 8. Prueba y Verificación

1. Ejecutar tarea manualmente:
   - Ir a "Tasks"
   - Seleccionar la tarea
   - Clic en "Run"

2. Verificar logs:
   - Monitorear salida en tiempo real
   - Verificar estados de las tareas
   - Confirmar notificaciones

## 9. Monitoreo

### Dashboard Principal
- Estado de las últimas ejecuciones
- Tiempo de ejecución
- Logs de errores

### Logs Detallados
1. Ir a "Tasks" → "History"
2. Revisar:
   - Estado de ejecuciones
   - Tiempo de procesamiento
   - Errores específicos

## Notas Importantes

- **Permisos**: Asegurar que el usuario tiene permisos suficientes
- **Backup**: Mantener respaldo de configuraciones
- **Seguridad**: Revisar periódicamente accesos y tokens
- **Monitoreo**: Configurar alertas para fallos críticos



