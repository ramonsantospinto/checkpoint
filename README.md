# 🎮 CheckPoint

Track your Steam journey. Know exactly where you stand.

CheckPoint is a modern Flutter application that integrates with the Steam Web API to help players monitor their current game, total playtime, achievement progress, and completion percentage — all in a clean and focused experience.

Built with Clean Architecture and designed for scalability.

---

## 🚀 What is CheckPoint?

Steam shows data.

CheckPoint gives you clarity.

Instead of navigating multiple Steam pages, CheckPoint centralizes:

- 🎮 Current game status
- ⏱ Total playtime
- 🏆 Achievement progress
- 📊 Completion percentage
- 🔐 Secure Steam authentication

---

## 🏗 Architecture

CheckPoint is built using:

- **Flutter**
- **Clean Architecture**
- **Feature-based modular structure**
- **Provider (State Management)**
- **Dio (Networking)**
- **Mason (Feature scaffolding)**
- **Firebase Cloud Functions (Secure Steam API Proxy)**

Project structure:

lib/
core/
features/
auth/
library/
achievements/


The architecture was designed to scale as a production-ready application.

---

## 🔐 Security

The Steam Web API key is never exposed in the mobile application.

All Steam API requests are handled through a secure backend proxy built with Firebase Cloud Functions.

Authentication is performed via Steam OpenID.

---

## 🧱 Code Generation with Mason

CheckPoint uses Mason bricks to generate new features following Clean Architecture standards.

Example:

```bash
mason make feature_clean_provider --feature_name achievements

This ensures consistency, scalability, and maintainability.

👨‍💻 Author

Ramon Santos

Flutter Developer
Architecture-focused, scalable application design.



---

# 🇧🇷 README — Versão Produto Real

```markdown
# 🎮 CheckPoint

Acompanhe sua jornada na Steam. Saiba exatamente onde você está.

CheckPoint é um aplicativo Flutter moderno integrado à Steam Web API que ajuda jogadores a acompanhar o jogo atual, horas jogadas, progresso de conquistas e porcentagem de conclusão — tudo em uma experiência limpa e focada.

Construído com Clean Architecture e pensado para escalar como produto real.

---

## 🚀 O que é o CheckPoint?

A Steam mostra dados.

O CheckPoint entrega clareza.

Em vez de navegar por várias páginas, o CheckPoint centraliza:

- 🎮 Status do jogo atual
- ⏱ Total de horas jogadas
- 🏆 Progresso de conquistas
- 📊 Percentual de conclusão
- 🔐 Autenticação segura via Steam

---

## 🏗 Arquitetura

O projeto utiliza:

- **Flutter**
- **Clean Architecture**
- **Estrutura modular por feature**
- **Provider (Gerenciamento de Estado)**
- **Dio (Requisições HTTP)**
- **Mason (Geração de Features)**
- **Firebase Cloud Functions (Proxy Seguro da Steam API)**

Estrutura:

lib/
core/
features/
auth/
library/
achievements/


A arquitetura foi projetada para escalar como aplicação de produção.

---

## 🔐 Segurança

A Steam Web API Key nunca é exposta no aplicativo mobile.

Todas as requisições à Steam são feitas através de um backend seguro utilizando Firebase Cloud Functions.

A autenticação é realizada via Steam OpenID.

---

## 🧱 Geração de Código com Mason

O CheckPoint utiliza Mason bricks para gerar novas features seguindo o padrão de Clean Architecture.

Exemplo:

```bash
mason make feature_clean_provider --feature_name achievements
Isso garante consistência, organização e escalabilidade.