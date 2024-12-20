

# 🔐 Automatización de Certificados Let's Encrypt
> Sistema automatizado para gestión y distribución de certificados SSL

[![Ansible Compatible](https://img.shields.io/badge/Ansible-2.9+-green.svg)](https://docs.ansible.com/ansible/latest/index.html)
[![SemaphoreUI](https://img.shields.io/badge/SemaphoreUI-Compatible-blue.svg)](https://www.ansible-semaphore.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 📋 Contenido
- [Descripción General](#-descripción-general)
- [Características](#-características)
- [Requisitos](#-requisitos)
- [Implementación en SemaphoreUI](#-implementación-en-semaphoreui)
- [Mantenimiento](#-mantenimiento)

## 🎯 Descripción General

Sistema integral para la gestión automatizada de certificados Let's Encrypt, incluyendo descarga, actualización y distribución, con notificaciones multicanal.

## ✨ Características

### 🔄 Gestión de Certificados
- Descarga automática desde FTP
- Comparación inteligente de fechas de expiración
- Actualización automática de certificados
- Sistema de organización estructurado

### 📦 Control de Versiones
- Integración GitHub automatizada
- Sistema de versionado inteligente
- Commits descriptivos automatizados
- Historial completo de cambios

### 📬 Notificaciones

#### 📧 Email
- Alertas detalladas
- Adjuntos comprimidos
- Soporte multi-destinatario

#### 📱 Telegram
- Alertas en tiempo real
- Compartición de archivos
- Mensajes formateados HTML

## 🛠 Requisitos

| Componente | Versión/Requisito |
|------------|-------------------|
| Ansible    | ≥ 2.9            |
| FTP        | Acceso Server    |
| GitHub     | Credenciales     |
| Telegram   | Bot Token        |
| SMTP       | Servidor Config  |



## 🎯 Guía Detallada de Implementación en SemaphoreUI

### 1️⃣ Configuración Inicial

#### Crear Nuevo Proyecto
1. Dashboard → `+ New Project`
   ```yaml
   Name: "Gestión Certificados Let's Encrypt"
   Description: "Sistema automatizado de gestión SSL"
   ```

#### Configurar Repositorio Git
1. `Environment` → `Repository`
   ```yaml
   Type: Git
   URL: https://github.com/usuario/repo.git
   Branch: main
   Auth Method: SSH Key
   ```

### 2️⃣ Gestión de Inventario

1. `Inventory` → `+ Add`
   ```ini
   [certificados]
   servidor-ssl ansible_host=servidor.ejemplo.com ansible_user=admin
   ```

### 3️⃣ Configuración de Environment

1. `Environment` → `+ Add Environment`
   ```yaml
   Name: "Prod-Certificados"
   Type: Production
   ```

2. Variables del Environment:
   ```yaml
   # Directorios
   final_cert_dir: /home/Descarga-Certificados
   temp_dir: /tmp/repo

   # GitHub
   token: "{{ vault.github_token }}"
   host: "github.ejemplo.com"
   user: "{{ vault.github_user }}"
   repo: "certificados-ssl"
   BRANCH: "main"

   # Notificaciones
   send_email: "true"
   send_telegram: "true"

   # SMTP
   smtp_server: "{{ vault.smtp_server }}"
   smtp_port: 25
   smtp_user: "{{ vault.smtp_user }}"
   smtp_password: "{{ vault.smtp_password }}"
   from_email: "{{ vault.from_email }}"
   to_email: "{{ vault.to_email }}"
   bcc_email: "{{ vault.bcc_email }}"

   # Telegram
   telegram_bot_token: "{{ vault.telegram_token }}"
   telegram_chat_id: "{{ vault.telegram_chat_id }}"
   ```

### 4️⃣ Configuración de Task Templates

1. `Tasks` → `+ Add Template`
   ```yaml
   Name: "Actualización SSL"
   Playbook: download_certificados.yml
   Environment: Prod-Certificados
   Inventory: certificados
   Repository: ssl-repo
   ```

### 5️⃣ Programación de Tareas

1. `Schedule` → `+ Add Schedule`
   ```yaml
   Name: "Actualización Diaria SSL"
   Template: "Actualización SSL"
   Cron Expression: "0 0 * * *"
   Time Zone: UTC
   ```

### 6️⃣ Gestión de Claves SSH

1. `Keys` → `+ Add Key`
   ```yaml
   Name: "SSH-Certificados"
   Type: SSH Key
   ```
   ```bash
   # Contenido ejemplo
   -----BEGIN OPENSSH PRIVATE KEY-----
   [Tu clave privada SSH]
   -----END OPENSSH PRIVATE KEY-----
   ```

### 7️⃣ Configuración de Notificaciones

1. `Notifications` → `+ Add`
   ```yaml
   # Email
   Type: Email
   Template: "Task {{ task.name }} {{ status }}"
   Recipients: ["admin@ejemplo.com"]

   # Telegram
   Type: Telegram
   Bot Token: "{{ vault.telegram_token }}"
   Chat ID: "{{ vault.telegram_chat_id }}"
   ```

### 8️⃣ Vault Management

1. `Settings` → `Vault`
   ```yaml
   # Credenciales Sensibles
   github_token: "tu-token"
   smtp_password: "tu-password"
   telegram_token: "bot-token"
   ```

### 9️⃣ Pruebas y Verificación

#### Ejecución Manual
1. `Tasks` → `Templates` → `Actualización SSL`
2. Click en `Run`

#### Monitoreo
1. `Dashboard`:
   - Estado de ejecución
   - Tiempo transcurrido
   - Logs en tiempo real

2. `Task History`:
   - Resultados anteriores
   - Estadísticas
   - Logs detallados


---



# 🔐 Automatización de Certificados Let's Encrypt
> Sistema automatizado para gestión y distribución de certificados SSL

[![Ansible Compatible](https://img.shields.io/badge/Ansible-2.9+-green.svg)](https://docs.ansible.com/ansible/latest/index.html)
[![SemaphoreUI](https://img.shields.io/badge/SemaphoreUI-Compatible-blue.svg)](https://www.ansible-semaphore.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 📋 Contenido
- [Descripción General](#-descripción-general)
- [Características](#-características)
- [Requisitos](#-requisitos)
- [Implementación en SemaphoreUI](#-implementación-en-semaphoreui)
- [Mantenimiento](#-mantenimiento)

## 🎯 Descripción General

Sistema integral para la gestión automatizada de certificados Let's Encrypt, incluyendo descarga, actualización y distribución, con notificaciones multicanal.

## ✨ Características

### 🔄 Gestión de Certificados
- Descarga automática desde FTP
- Comparación inteligente de fechas de expiración
- Actualización automática de certificados
- Sistema de organización estructurado

### 📦 Control de Versiones
- Integración GitHub automatizada
- Sistema de versionado inteligente
- Commits descriptivos automatizados
- Historial completo de cambios

### 📬 Notificaciones

#### 📧 Email
- Alertas detalladas
- Adjuntos comprimidos
- Soporte multi-destinatario

#### 📱 Telegram
- Alertas en tiempo real
- Compartición de archivos
- Mensajes formateados HTML

## 🛠 Requisitos

| Componente | Versión/Requisito |
|------------|-------------------|
| Ansible    | ≥ 2.9            |
| FTP        | Acceso Server    |
| GitHub     | Credenciales     |
| Telegram   | Bot Token        |
| SMTP       | Servidor Config  |



## 🎯 Guía Detallada de Implementación en SemaphoreUI

### 1️⃣ Configuración Inicial

#### Crear Nuevo Proyecto
1. Dashboard → `+ New Project`
   ```yaml
   Name: "Gestión Certificados Let's Encrypt"
   Description: "Sistema automatizado de gestión SSL"
   ```

#### Configurar Repositorio Git
1. `Environment` → `Repository`
   ```yaml
   Type: Git
   URL: https://github.com/usuario/repo.git
   Branch: main
   Auth Method: SSH Key
   ```

### 2️⃣ Gestión de Inventario

1. `Inventory` → `+ Add`
   ```ini
   [certificados]
   servidor-ssl ansible_host=servidor.ejemplo.com ansible_user=admin
   ```

### 3️⃣ Configuración de Environment

1. `Environment` → `+ Add Environment`
   ```yaml
   Name: "Prod-Certificados"
   Type: Production
   ```

2. Variables del Environment:
   ```yaml
   # Directorios
   final_cert_dir: /home/Descarga-Certificados
   temp_dir: /tmp/repo

   # GitHub
   token: "{{ vault.github_token }}"
   host: "github.ejemplo.com"
   user: "{{ vault.github_user }}"
   repo: "certificados-ssl"
   BRANCH: "main"

   # Notificaciones
   send_email: "true"
   send_telegram: "true"

   # SMTP
   smtp_server: "{{ vault.smtp_server }}"
   smtp_port: 25
   smtp_user: "{{ vault.smtp_user }}"
   smtp_password: "{{ vault.smtp_password }}"
   from_email: "{{ vault.from_email }}"
   to_email: "{{ vault.to_email }}"
   bcc_email: "{{ vault.bcc_email }}"

   # Telegram
   telegram_bot_token: "{{ vault.telegram_token }}"
   telegram_chat_id: "{{ vault.telegram_chat_id }}"
   ```

### 4️⃣ Configuración de Task Templates

1. `Tasks` → `+ Add Template`
   ```yaml
   Name: "Actualización SSL"
   Playbook: download_certificados.yml
   Environment: Prod-Certificados
   Inventory: certificados
   Repository: ssl-repo
   ```

### 5️⃣ Programación de Tareas

1. `Schedule` → `+ Add Schedule`
   ```yaml
   Name: "Actualización Diaria SSL"
   Template: "Actualización SSL"
   Cron Expression: "0 0 * * *"
   Time Zone: UTC
   ```

### 6️⃣ Gestión de Claves SSH

1. `Keys` → `+ Add Key`
   ```yaml
   Name: "SSH-Certificados"
   Type: SSH Key
   ```
   ```bash
   # Contenido ejemplo
   -----BEGIN OPENSSH PRIVATE KEY-----
   [Tu clave privada SSH]
   -----END OPENSSH PRIVATE KEY-----
   ```

### 7️⃣ Configuración de Notificaciones

1. `Notifications` → `+ Add`
   ```yaml
   # Email
   Type: Email
   Template: "Task {{ task.name }} {{ status }}"
   Recipients: ["admin@ejemplo.com"]

   # Telegram
   Type: Telegram
   Bot Token: "{{ vault.telegram_token }}"
   Chat ID: "{{ vault.telegram_chat_id }}"
   ```

### 8️⃣ Vault Management

1. `Settings` → `Vault`
   ```yaml
   # Credenciales Sensibles
   github_token: "tu-token"
   smtp_password: "tu-password"
   telegram_token: "bot-token"
   ```

### 9️⃣ Pruebas y Verificación

#### Ejecución Manual
1. `Tasks` → `Templates` → `Actualización SSL`
2. Click en `Run`

#### Monitoreo
1. `Dashboard`:
   - Estado de ejecución
   - Tiempo transcurrido
   - Logs en tiempo real

2. `Task History`:
   - Resultados anteriores
   - Estadísticas
   - Logs detallados


---

<p align="center">
Desarrollado con ❤️ por el Equipo de Infraestructura
</p>
<p align="center">
<sub>¿Encontraste un error? ¡Abre un issue!</sub>
</p>

