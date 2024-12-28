# 🔐 Automatización para la Descarga de Certificados de Let's Encrypt
> Sistema automatizado para gestión y distribución de certificados SSL

[![Ansible Compatible](https://img.shields.io/badge/Ansible-2.9+-green.svg)](https://docs.ansible.com/ansible/latest/index.html)
[![SemaphoreUI](https://img.shields.io/badge/SemaphoreUI-Compatible-blue.svg)](https://www.ansible-semaphore.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)


## 📑 Tabla de Contenidos

<details open>
<summary>Expandir / Colapsar</summary>

## 📑 Índice

1. [🎯 Descripción General](#-descripción-general)
2. [✨ Características](#-características)
3. [🛠 Requisitos](#-requisitos)
4. [📡 Implementación con SemaphoreUI](docs/readme_implementación_semaphoreui.md)
5. [📜 Implementación con Playbook](docs/readme_ejecutar_playbook.md)
6. [💡 Implementación con Script Bash](docs/readme_ejecutar_script_bash.md) [📥 Descargar Script](descargar_certificado_infomed.sh)
7. [📡 Implementación para el uso de MTA](docs/readme_implementación_mta.md)

</details>

## 🎯 Descripción General

Este script esta diseñado para la automatización de la gestión de certificados Let's Encrypt, desde el ftp de infomed, para no tener que estar descargando los certificados manualmente, cuando los mismos se venzan.

## ✨ Características

### 🔄 Gestión de Certificados
- Descarga automática desde FTP
- Comparación inteligente de fechas de expiración
- Actualización automática de certificados

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



---


<p align="center">
Desarrollado con ❤️
</p>

