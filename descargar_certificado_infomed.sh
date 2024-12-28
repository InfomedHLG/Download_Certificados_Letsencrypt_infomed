#!/bin/bash
# V4 - 23-12-2024 : 10:20PM
# Salvador Sanchez Sanchez - ssanchezhlg@gmail.com

# Descargar el archivo le.tar.gz desde la URL especificada
URL="http://ftp.dominio.cu/ruta-certificados/le.tar.gz"

# Define la variable para el dominio
DOMINIO="dominio.cu"

# Ruta de los certificados
# RUTA_CERTIFICADOS="/mnt/DataStore01/DockerStore/s3/data/ssl"
RUTA_CERTIFICADOS="ruta/certificados"

# Ruta temporal para la copia de los ceritificados
RUTA_TEMPORAL_CERTIFICADOS="/tmp"

# Variable para activar o desactivar la ejecución del script de copia de certificados
EJECUTAR_SCRIPT_COPIA=true

# Variable para activar o desactivar el envío de correos
ENVIAR_CORREO=true

# Ruta del segundo script para ejecutar si los certificados fueron actualizados
ScriptCopiaServidores="/usr/local/bin/copiar_certificados.sh"

## Notificacion
# Fecha para el envio de correo
DATE=$(date +%d-%m-%Y)

## Lista de discucion admin-red donde estaran todos los admins
# DESTINATARIOS_NOT1="certificados-lets-encrypt@listas.hlg.sld.cu,root@hlg.sld.cu"
DESTINATARIOS_NOT1="usuario@dominio.cu,usuario2@dominio.cu"

## Postmaster para notificar
DESTINATARIOS_NOT2="usuario@dominio.cu"













# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # # #                                           NO MODIFICAR DE AQUI HACIA ABAJO                                                          # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Eliminar ficheros temporales al iniciar
rm $RUTA_TEMPORAL_CERTIFICADOS/*.pem

# Descargar fichero
wget $URL

# Descomprimir el archivo en la ruta $RUTA_TEMPORAL_CERTIFICADOS
tar -xvf le.tar.gz -C $RUTA_TEMPORAL_CERTIFICADOS

for file in "$RUTA_TEMPORAL_CERTIFICADOS/etc/letsencrypt/archive/$DOMINIO/cert"*.pem; do
    if [[ $file =~ cert([1-9]|[1-9][0-9]|100)\.pem$ ]]; then
        last_cert=$file
    fi
done

for file in "$RUTA_TEMPORAL_CERTIFICADOS/etc/letsencrypt/archive/$DOMINIO/chain"*.pem; do
    if [[ $file =~ chain([1-9]|[1-9][0-9]|100)\.pem$ ]]; then
        last_chain=$file
    fi
done

for file in "$RUTA_TEMPORAL_CERTIFICADOS/etc/letsencrypt/archive/$DOMINIO/fullchain"*.pem; do
    if [[ $file =~ fullchain([1-9]|[1-9][0-9]|100)\.pem$ ]]; then
        last_fullchain=$file
    fi
done

for file in "$RUTA_TEMPORAL_CERTIFICADOS/etc/letsencrypt/archive/$DOMINIO/privkey"*.pem; do
    if [[ $file =~ privkey([1-9]|[1-9][0-9]|100)\.pem$ ]]; then
        last_privkey=$file
    fi
done

if [[ $last_cert =~ cert([1-9]|[1-9][0-9]|100)\.pem$ ]]; then
    new_name="cert.pem"
    mv "$last_cert" "$RUTA_TEMPORAL_CERTIFICADOS/$new_name"
fi

if [[ $last_chain =~ chain([1-9]|[1-9][0-9]|100)\.pem$ ]]; then
    new_name="chain.pem"
    mv "$last_chain" "$RUTA_TEMPORAL_CERTIFICADOS/$new_name"
fi

if [[ $last_fullchain =~ fullchain([1-9]|[1-9][0-9]|100)\.pem$ ]]; then
    new_name="fullchain.pem"
    mv "$last_fullchain" "$RUTA_TEMPORAL_CERTIFICADOS/$new_name"
fi

if [[ $last_privkey =~ privkey([1-9]|[1-9][0-9]|100)\.pem$ ]]; then
    new_name="privkey.pem"
    mv "$last_privkey" "$RUTA_TEMPORAL_CERTIFICADOS/$new_name"
fi

# Eliminar el archivo le.tar.gz
rm le.tar.gz

# Eliminar la carpeta descomprimida
rm -rf ${RUTA_TEMPORAL_CERTIFICADOS:?}/etc

# Parte 2: Comparar y copiar certificados
temp_cert_folder="/tmp"

# Verificar si el certificado 'cert.pem' se descargó correctamente
if [ -f "$temp_cert_folder/cert.pem" ]; then
    # Obtener la fecha de vencimiento del certificado 'cert.pem' descargado
    remote_cert_expiration_date=$(openssl x509 -noout -dates -in "$temp_cert_folder/cert.pem" | grep "notAfter" | awk -F'=' '{print $2}')

    if [ -f "$RUTA_CERTIFICADOS/cert.pem" ]; then
        # Obtener la fecha de vencimiento del certificado 'cert.pem' local
        local_cert_expiration_date=$(openssl x509 -noout -dates -in "$RUTA_CERTIFICADOS/cert.pem" | grep "notAfter" | awk -F'=' '{print $2}')

        echo "Fecha del certificado descargado: $remote_cert_expiration_date"
        echo "Fecha del certificado local: $local_cert_expiration_date"

        if [[ $(date -d "$local_cert_expiration_date" +%s) -lt $(date -d "$remote_cert_expiration_date" +%s) ]]; then
            # El certificado local es más antiguo, copiamos todos los archivos .pem desde la carpeta temporal
            rm "$RUTA_CERTIFICADOS"/*.pem
            cp "$temp_cert_folder"/*.pem "$RUTA_CERTIFICADOS/"
            echo "Los certificados locales estaban más antiguos, se han actualizado."
            
            if [ "$ENVIAR_CORREO" = true ]; then
                # Enviar Preparar los datos para enviar el correo
                ASUNTO_NOT1="Notificación de Actualización de Certificados - Let's Encrypt - $DATE"            
                MESSAGE_NOT1="Estimados usuarios, estamos notificando que los ceritificados Let's Encrypt se han actualizado\\n\\n\\n Fecha Vencimiento del Certificado Actual: $local_cert_expiration_date \n Fecha Vencimiento del Nuevo Certificado: $remote_cert_expiration_date\\n\\n\n Puede proceder a descargar el mismo desde la url\n\n https://ftp.dominio.cu/ruta-certificados/ \n\n\nEste script se ejecuta de forma automática todos los días, al detectar nuevas versiones de los certificados se descargarán de forma automática.\n\n\nAsistente virtual - Nodo Infomed Holguín\nEsta dirección electrónica está protegida contra spam bots"    
                
                # Enviar notificación por correo
                echo -e "$MESSAGE_NOT1" | mailx -a "Content-Type: text/plain; charset=UTF-8" -r "postmaster@hlg.sld.cu" -s "$ASUNTO_NOT1" $DESTINATARIOS_NOT1
            fi

            if [ "$EJECUTAR_SCRIPT_COPIA" = true ]; then
                # Ejecutando la copia de certificados
                echo "Ejecutando script de copia de Certificados a los Servidores."
                $ScriptCopiaServidores
            else
                echo "La ejecución del script de copia de certificados está desactivada."
            fi
        else
            echo "Los certificados locales son iguales o más recientes, no se han actualizado."
            
            if [ "$ENVIAR_CORREO" = true ]; then
                # Enviar notificación por correo
                ASUNTO_NOT2="Notificación de Actualización de Certificados - Let's Encrypt - $DATE"
                MESSAGE_NOT2="Estimados usuarios, Los certificados locales son iguales o más recientes, no se han actualizado.\\n\\n\\n Fecha Vencimiento del Certificado Actual: $local_cert_expiration_date \n Fecha Vencimiento del Nuevo Certificado: $remote_cert_expiration_date\n\n\n\n\nAsistente virtual - Nodo Infomed Holguín\nEsta dirección electrónica está protegida contra spam bots"    
                echo -e "$MESSAGE_NOT2" | mailx -a "Content-Type: text/plain; charset=UTF-8" -r "postmaster@hlg.sld.cu" -s "$ASUNTO_NOT2" $DESTINATARIOS_NOT2
            fi
        fi
    else
        # No existe un certificado 'cert.pem' en la carpeta local, copiamos todos los archivos .pem desde la carpeta temporal
        cp "$temp_cert_folder"/*.pem "$RUTA_CERTIFICADOS/"
        echo "Los certificados locales no existían, se han copiado desde la URL."
    fi
else
    echo "No se pudo descargar 'cert.pem' desde la URL."
fi

# Eliminando ficheros temporales
rm "$temp_cert_folder"/*.pem