#!/bin/bash

set -e

PKG_NAME="kde-tema-manager"
VERSION="1.0.0"
ARCH="all"
OUTPUT_DIR="dist"
DEB_NAME="${PKG_NAME}_${VERSION}_${ARCH}.deb"

echo "📦 Gerando pacote .deb para ${PKG_NAME}..."

# Ajustar permissões
chmod 755 ${PKG_NAME}/DEBIAN/postinst
chmod 755 ${PKG_NAME}/DEBIAN/postrm
chmod 755 ${PKG_NAME}/opt/kde-tema/kde-tema.sh
chmod 644 ${PKG_NAME}/usr/share/applications/kde-tema.desktop

# Criar diretório de saída
mkdir -p ${OUTPUT_DIR}

# Construir o pacote
dpkg-deb --build ${PKG_NAME} ${OUTPUT_DIR}/${DEB_NAME}

echo "✅ Pacote criado em ${OUTPUT_DIR}/${DEB_NAME}"
