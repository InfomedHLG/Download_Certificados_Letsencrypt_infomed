

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

## 🚀 Implementación en SemaphoreUI

### 1️⃣ Configuración del Proyecto
```yaml
Nombre: "Gestión Certificados Let's Encrypt"
Descripción: "Sistema Automatizado SSL"
Repositorio: git@github.com:usuario/repo.git
Branch: main
```

### 2️⃣ Variables de Entorno
```yaml
# Directorios
final_cert_dir: /home/Descarga-Certificados
temp_dir: /tmp/repo

# GitHub
token: "**********************"
host: "github.example.com"
user: "usuario"
repo: "certificados-ssl"

# Notificaciones
smtp_server: "smtp.ejemplo.com"
telegram_bot_token: "bot123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11"
```

### 3️⃣ Programación
```cron
# Ejecución Diaria
0 0 * * * # Medianoche
```

## 🔍 Monitoreo

### Dashboard
- 📊 Métricas en tiempo real
- 📈 Estadísticas de ejecución
- 🔔 Sistema de alertas

### Logs
- 📝 Registro detallado
- 🔄 Histórico de operaciones
- ⚠️ Alertas de errores

## 🛡️ Seguridad

- 🔐 Gestión de permisos
- 💾 Sistema de backups
- 🔑 Rotación de credenciales

## 📚 Documentación Adicional

Para más detalles, consulte:
- [Wiki del Proyecto](wiki/)
- [Guía de Troubleshooting](docs/troubleshooting.md)
- [Manual de Usuario](docs/user-manual.md)

## 🤝 Soporte

Para soporte técnico:
- 📧 Email: soporte@ejemplo.com
- 💬 Canal Telegram: @soporteSSL
- 📝 Issues: GitHub Issues

---

<p align="center">
  Desarrollado con ❤️ por el Equipo de Infraestructura
</p>

<p align="center">
  <sub>¿Encontraste un error? ¡Abre un issue!</sub>
</p>
