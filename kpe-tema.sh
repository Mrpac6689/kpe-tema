#!/bin/bash

# === Funções auxiliares ===

verificar_dependencias() {
  DEPENDENCIAS=("tar" "kstart5" "kquitapp5")
  for cmd in "${DEPENDENCIAS[@]}"; do
    if ! command -v "$cmd" &>/dev/null; then
      echo "❌ Dependência ausente: $cmd. Instale antes de continuar."
      exit 1
    fi
  done
}

limpar_temporarios() {
  [ -d "$BACKUP_DIR" ] && rm -rf "$BACKUP_DIR"
}

# === Menu Inicial ===
clear
cat << "EOF"
██╗  ██╗██████╗ ███████╗    ████████╗██╗  ██╗███████╗███╗   ███╗ █████╗ 
██║ ██╔╝██╔══██╗██╔════╝    ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔══██╗
█████╔╝ ██████╔╝█████╗         ██║   ███████║█████╗  ██╔████╔██║███████║
██╔═██╗ ██╔═══╝ ██╔══╝         ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══██║
██║  ██╗██║     ███████╗       ██║   ██║  ██║███████╗██║ ╚═╝ ██║██║  ██║
╚═╝  ╚═╝╚═╝     ╚══════╝       ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝
                                                                      
EOF

echo "🔧 Ferramenta CLI para backup e restauração de configurações visuais no KDE Plasma"
echo "💡 Preenche a lacuna do KDE Plasma 6, que atualmente não permite salvar/restaurar temas personalizados."
echo ""
echo "Autor: Michel R Paes  |  GitHub: @MrPaC6689"
echo "Turbinado por: ChatGPT ✨"
echo ""

echo "1) Salvar tema atual"
echo "2) Restaurar tema a partir de um backup"
echo "0) Sair"
read -p "Escolha uma opção: " OPCAO

if [[ "$OPCAO" == "0" ]]; then
  echo "👍 Saindo..."
  exit 0
fi

# === Caminhos personalizados ===
read -p "Digite o nome do arquivo tar.gz (sem espaços): " NOME_ARQUIVO
NOME_ARQUIVO="${NOME_ARQUIVO:-meu-tema-kde}.tar.gz"
ARQUIVO_FINAL="$HOME/$NOME_ARQUIVO"
BACKUP_DIR="$HOME/backup-plasma"
LOGFILE="$HOME/kde-tema-${OPCAO}.log"

verificar_dependencias
case "$OPCAO" in
  1)
    echo "📝 Iniciando backup..." | tee "$LOGFILE"
    limpar_temporarios
    mkdir -p "$BACKUP_DIR/.config"
    mkdir -p "$BACKUP_DIR/.local/share"

    echo "📁 Copiando arquivos essenciais..." | tee -a "$LOGFILE"

    CONFIGS=(
      "plasma-org.kde.plasma.desktop-appletsrc"
      "kdeglobals"
      "kglobalshortcutsrc"
      "kwinrc"
      "ksmserverrc"
      "plasmarc"
    )
    for config in "${CONFIGS[@]}"; do
      if [ -f "$HOME/.config/$config" ]; then
        cp "$HOME/.config/$config" "$BACKUP_DIR/.config/"
        echo "✔️ $config" | tee -a "$LOGFILE"
      fi
    done

    COPIAR_PASTAS=("plasma" "kscreen" "color-schemes" "icons" "wallpapers")
    for pasta in "${COPIAR_PASTAS[@]}"; do
      if [ -d "$HOME/.local/share/$pasta" ]; then
        cp -r "$HOME/.local/share/$pasta" "$BACKUP_DIR/.local/share/"
        echo "✔️ $pasta" | tee -a "$LOGFILE"
      fi
    done

    echo "📦 Compactando para $ARQUIVO_FINAL..."
    tar -czf "$ARQUIVO_FINAL" -C "$HOME" "backup-plasma" >> "$LOGFILE" 2>&1
    limpar_temporarios

    echo "✅ Backup concluído com sucesso!"
    ;;

  2)
    echo "📦 Iniciando restauração..." | tee "$LOGFILE"
    if [ ! -f "$ARQUIVO_FINAL" ]; then
      echo "❌ Arquivo não encontrado: $ARQUIVO_FINAL" | tee -a "$LOGFILE"
      exit 1
    fi

    read -p "⚠️ O conteúdo será extraído para: $HOME. Deseja continuar? (s/n): " CONFIRMA
    if [[ "$CONFIRMA" != "s" && "$CONFIRMA" != "S" ]]; then
      echo "❌ Cancelado pelo usuário." | tee -a "$LOGFILE"
      exit 1
    fi

    echo "🔍 Extraindo backup..."
    tar -xzf "$ARQUIVO_FINAL" -C "$HOME" >> "$LOGFILE" 2>&1

    if pgrep -x plasmashell > /dev/null; then
      echo "🔄 Reiniciando o Plasma..."
      kquitapp5 plasmashell >> "$LOGFILE" 2>&1
      sleep 2
      kstart5 plasmashell >> "$LOGFILE" 2>&1 &
      echo "✅ Plasma reiniciado." | tee -a "$LOGFILE"
    else
      echo "⚠️ Plasma não estava rodando." | tee -a "$LOGFILE"
    fi

    echo "✅ Restauração concluída!"
    ;;
  *)
    echo "❌ Opção inválida."
    exit 1
    ;;
esac
