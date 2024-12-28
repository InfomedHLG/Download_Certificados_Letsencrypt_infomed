## 🔐 Automatización para la Descarga de Certificados de Let's Encrypt

# 🎯 Guía de Implementación Detallada usando SemaphoreUI

### 1️⃣ Configuración Inicial

#### 🆕 Crear Nuevo Proyecto
1. Dashboard → `+ New Project`
   ```yaml
   Name: "Gestión Certificados Let's Encrypt"
   ```
   <a href="./img/01NewProyect.png"><img src="./img/01NewProyect.png" width="100" height="100" alt="Crear Nuevo Proyecto"></a>

### 2️⃣ 🔑 Gestión de Claves SSH

1. `Key Store`

*Esto es comentario: Aquí añadiremos el acceso al repositorio git, así como el acceso al servidor donde se desplegará el playbook*

# Acceso al repositorio git

1. `Key Store` → `+ New Key`

   ```plaintext
   Key Name: "Gestión Certificados Let's Encrypt"
   Type: 
      - SSH Key
      - Login with password
      - None
   Escogemos en - `Login with password` nos aparecerá los datos
      - Login (optional)
      - password
   ```
   y le damos en create

   <a href="./img/02.1NewKey.png"><img src="./img/02.1NewKey.png" width="100" height="100" alt="Nuevo Key"></a>
   <a href="./img/02.2LoginWithPassword.png"><img src="./img/02.2LoginWithPassword.png" width="100" height="100" alt="Login with Password"></a>

*Esto es comentario: Ahora añadimos el acceso al servidor donde se desplegará el playbook*   

2. `+ New Key`

   ```plaintext
   Key Name: "Access Server"
   Type: 
      - SSH Key
      - Login with password
      - None
   Escogemos en - `SSH Key` nos aparecerá los datos
      - username (optional)
      - passphrase (optional)
      - Private Key
   ```
   ```plaintext
   # Contenido ejemplo
   -----BEGIN OPENSSH PRIVATE KEY-----
   [Tu clave privada SSH]
   -----END OPENSSH PRIVATE KEY-----
   ```

   y le damos en `create`

   <a href="./img/02.3SSHKey.png"><img src="./img/02.3SSHKey.png" width="100" height="100" alt="SSH Key"></a>

#### 3️⃣ 🔗 Configurar Repositorio Git

*Esto es comentario: Aquí configuraremos el repositorio git donde se encuentra el playbook*

1. `Repository` → `+ New Repository`
   ```yaml
   Name: Gestión Certificados Let's Encrypt
   URL or Path: https://github.com/usuario/repo.git
   Branch: main 
   Access Key: (Aquí escogemos el que creamos en "Key Store" Gestión Certificados Let's Encrypt)
   ```

   <a href="./img/03NewRepository.png"><img src="./img/03NewRepository.png" width="100" height="100" alt="Nuevo Repositorio"></a>

### 4️⃣ Gestión de Inventario

1. `Inventory` → `+ New Inventory`
   ```yaml
   Name: Server-Ansible
   User Credentials: (Aquí nos saldrá los que creamos en Key Store)
   Sudo Credentials (Optional): 
   Type:
        - Static
        - Static YAML
        - File
   ```

*Esto es comentario: Aquí en mi caso uso `Static`*

   ```ini
   [Server-Ansible]
   IP-SERVER:PUERTO ansible_ssh_common_args='-o StrictHostKeyChecking=no'
   ```

y le damos en `create`

   <a href="./img/04NewInventory.png"><img src="./img/04NewInventory.png" width="100" height="100" alt="Nuevo Inventario"></a>

### 5️⃣ 🌍 Configuración de Environment

1. `Variable Groups` → `+ New Groups`
   ```yaml
   Group Name: "variables Gestión Certificados Let's Encrypt"
   Variables: 
   - Extra variables
     - Table (Aquí podemos agregar una a una las variables)
     - Json  (Aquí podemos importar el fichero variables.json que se encuentra en el repositorio)

   - Environment variables 
   ```

   <a href="./img/05.1NewGroupsEditVariableGroup.png"><img src="./img/05.1NewGroupsEditVariableGroup.png" width="100" height="100" alt="Nuevo Grupo de Variables"></a>
   <a href="./img/05.2NewGroupsEditVariableGroupDatos.png"><img src="./img/05.2NewGroupsEditVariableGroupDatos.png" width="100" height="100" alt="Editar Grupo de Variables"></a>

2. 🔧 Ejemplo del fichero Variables.json:
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
3. Para manejar los datos sensibles como son passwords y token, en la misma sección de Environment: en la pestaña Secrets
  
   ```yaml
   Group Name: "variables Gestión Certificados Let's Encrypt"
   Secrets: 
   - Extra variables 
     - + 

   - Environment variables
     - + (Aquí le damos clic en el + y vamos añadiendo los datos sensibles)
   ```

   <a href="./img/05.3NewGroupsEditVariableGroupSecrets.png"><img src="./img/05.3NewGroupsEditVariableGroupSecrets.png" width="100" height="100" alt="Editar Grupo de Variables Secretas"></a>
   <a href="./img/05.3.3NewGroupsEditVariableGroupSecretsDatos.png"><img src="./img/05.3.3NewGroupsEditVariableGroupSecretsDatos.png" width="100" height="100" alt="Datos de Variables Secretas"></a>

### 🔒 Configuración de Environment variables

1. `Environment` → `Secrets` → `+ Add Secret`
   ```yaml
    GIT_TOKEN: 1234567890abcdef1234567890abcdef12345678
    EMAIL_SMTP_PASSWORD: examplepassword123	
    TELEGRAM_BOT_TOKEN: 123456789:ABCdefGhIjKLmnopQRsTUvWxYz12345678
    TELEGRAM_CHAT_ID: -9876543210
   ```

### 6️⃣ 📝 Configuración de Task Templates

1. `Task Templates` → `+ New Task Templates → New template 'Ansible Playbook'`
   ```yaml
   Name: "Gestión Certificados Let's Encrypt"
   Description: 
   Playbook Filename: (Aquí le pondremos el nombre del playbook a ejecutar, en este caso se llama `download_certificados.yml`)
   Inventory: (Escogemos el creado en la sección Inventory `Server-Ansible`)
   Repository: (Escogemos el creado en la sección Repository `Gestión Certificados Let's Encrypt`)
   Variable Groups: (Escogemos el creado en la sección Variable Groups `variables Gestión Certificados Let's Encrypt`)   
   ```

   <a href="./img/06.1NewTemplateAnsiblePlaybook.png"><img src="./img/06.1NewTemplateAnsiblePlaybook.png" width="100" height="100" alt="Nuevo Template Ansible Playbook"></a>
   <a href="./img/06.2NewTemplateAnsiblePlaybookDatos.png"><img src="./img/06.2NewTemplateAnsiblePlaybookDatos.png" width="100" height="100" alt="Datos del Template Ansible Playbook"></a>

### 7️⃣ ⏰ Programación de Tareas

1. `Schedule` → `+ New Schedule`
   ```yaml
   Name: Task - Gestión Certificados Let's Encrypt
   Template: (Escogemos el creado en la sección Task Templates `Gestión Certificados Let's Encrypt`)
   Show cron format: (Activamos esta opción para ponerlo en formato cron)
   Cron Expression: "0 0 * * *"
   Enable: (Marcamos para activarla)
   ```

   <a href="./img/07Schedule.png"><img src="./img/07Schedule.png" width="100" height="100" alt="Programación de Tareas"></a>

### 9️⃣ ✅ Pruebas y Verificación

#### 🖐️ Ejecución Manual
1. `Tasks` → `Templates` → `Gestión Certificados Let's Encrypt`
2. Click en `Run`

#### 📊 Monitoreo
1. `Dashboard`:
   - Estado de ejecución
   - Tiempo transcurrido
   - Logs en tiempo real

2. `Task History`:
   - Resultados anteriores
   - Estadísticas
   - Logs detallados

---

[🔙 Volver al Proyecto Principal](./)

<p align="center">
Desarrollado con ❤️
</p>

