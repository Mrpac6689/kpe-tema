# 🎨 KDE Tema Manager (KPE THEME)

**Gerenciador de Tema para KDE Plasma 6**  
Backup e restauração das configurações visuais do Plasma — preenchendo a lacuna que ainda existe no KDE 6.x!

![Screenshot](https://raw.githubusercontent.com/MrPaC6689/kde-thema/main/docs/screenshot.png)

---

## 🔧 O que é?

O **KPE Theme** é uma ferramenta em shell script com interface CLI interativa que permite:

- 🔹 Fazer **backup** das configurações visuais do KDE Plasma (cores, painéis, ícones, esquema de cores, etc.)
- 🔹 Restaurar essas configurações em um clique
- 🔹 Empacotado como `.deb` com integração total ao menu do KDE
- 🔹 Ideal para quem reinstala o sistema e não quer perder suas personalizações

---

## ✨ Funcionalidades

- Backup limpo apenas do necessário (`.config`, `color-schemes`, `icons`, `wallpapers`)
- Restauração automática com reinício do Plasma
- Interface interativa no terminal via Konsole
- Ícone e entrada de menu com `.desktop`
- Pacote `.deb` com pós-instalação e remoção automatizadas
- Compatível com KDE Plasma 5 e 6

---

## 📦 Instalação

Baixe e instale o `.deb` mais recente:

```bash
sudo dpkg -i kde-tema-manager.deb
```

Ou clone o projeto e gere localmente:

```bash
git clone https://github.com/MrPaC6689/kde-thema.git
cd kde-thema
chmod +x build.sh
./build.sh
sudo dpkg -i dist/kde-tema-manager_1.0.0.deb
```

---

## 🚀 Uso

Após instalar, você pode:

- Abrir o aplicativo pelo menu: **"Gerenciador de Tema KDE"**
- Ou pelo terminal:

```bash
kde-tema
```

---

## 🧽 Desinstalação

```bash
sudo dpkg -r kde-tema-manager
```

---

## 🛠️ Estrutura Interna

```
/opt/kde-tema/kde-tema.sh        # Script principal
/usr/local/bin/kde-tema          # Link simbólico criado automaticamente
/usr/share/applications/         # Entrada de menu (.desktop)
/usr/share/icons/hicolor/        # Ícones em múltiplos tamanhos
```

---

## 🧑‍💻 Autor

Desenvolvido por **Michel R. Paes**  
📎 GitHub: [@MrPaC6689](https://github.com/MrPaC6689)  
🧠 Potencializado por: ChatGPT  

---

## 📝 Licença

Este projeto está licenciado sob a [MIT License](LICENSE).
