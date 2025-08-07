# Pokedex Dell

Um app Pokedex em Flutter usando a [PokeAPI](https://pokeapi.co) e Firebase para autenticação.  
Construído como teste técnico para vaga de Flutter Developer.

![Demonstração do App](lib/app/assets/run_pikachu.gif)

---

## Sumário

- [Funcionalidades](#funcionalidades)
- [Demonstração](#demonstração)
- [Começando](#começando)
    - [Pré-requisitos](#pré-requisitos)
    - [Instalação](#instalação)
    - [Configuração do Firebase](#configuração-do-firebase)
- [Uso](#uso)
- [Estrutura de Pastas](#estrutura-de-pastas)
- [Dependências](#dependências)
- [Problemas Conhecidos e Melhorias](#problemas-conhecidos-e-melhorias)

---

## Funcionalidades

- 🔐 **Autenticação**
    - Cadastro e login por e-mail/senha
    - Login com Google via Firebase
- 📜 **Scroll Infinito**
    - Carrega Pokémon em páginas de 20 itens conforme o usuário rola
- 🔎 **Filtros**
    - Por tipo de Pokémon
    - Por nome ou ID exato
- 📇 **Detalhes do Pokémon**
    - Nome, sprite e tipos
    - Descrição (flavor text)
    - Atributos base e fraquezas
    - Habilidades
    - Cadeia de evolução
    - Lista de movimentos
- 🚪 **Logout** na tela principal
- 🏳️‍🌈 App todo em inglês por padrão

---

## Demonstração

![Demonstração do App](lib/app/assets/run_pikachu.gif)

---

## Começando

### Pré-requisitos

- [Flutter SDK ≥3.8.1](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- Projeto Firebase com Android e iOS configurados
- IDE: Android Studio, Xcode ou VS Code com plugin Flutter

### Instalação

1. **Clone o repositório**

    ```bash
    git clone https://github.com/your-username/pokedex_dell.git
    cd pokedex_dell
    ```
2. **Instale as dependências**

    ```bash
    flutter pub get
    ```

### Configuração do Firebase

1. No [Console do Firebase](https://console.firebase.google.com), crie um projeto.
2. Habilite **Authentication** → **Email/Password** & **Google**.
3. **Android**
    - Adicione app Android com o package name.
    - Baixe `google-services.json` e coloque em `android/app/`.
4. **iOS**
    - Adicione app iOS com seu bundle ID.
    - Baixe `GoogleService-Info.plist` e coloque em `ios/Runner/`.
5. **Recompile**

    ```bash
    flutter clean
    flutter run
    ```
## Uso

1. Rode no emulador ou dispositivo real:

    ```bash
    flutter run
    ```
2. Cadastre-se ou faça login (e-mail/senha ou Google).
3. Navegue pela lista de Pokémon; role para carregar mais.
4. Use os filtros no topo: por tipo ou por nome/ID exato.
5. Toque em um card para ver detalhes completos.
6. Faça logout pelo botão na tela principal.  

## Estrutura de Pastas

```plaintext
lib/
├── app/
│   ├── assets/              # GIFs & imagens
│   ├── core/
│   │   └── services/        # Serviços PokeAPI & Firebase
│   ├── models/              # Classes de modelo
│   ├── modules/
│   │   ├── auth/            # Controladores, views e widgets do auth
│   │   └── pokedex/         # Controladores, views e widgets da pokedex
│   ├── utils/
    ├── app_module.dart      # Configuração do Flutter Modular
│   └── app_widget.dart      # Widget principal
└── main.dart                # Ponto de entrada
```

## Dependências

- **Gerenciamento de Estado**:
    - [mobx](https://pub.dev/packages/mobx) & [flutter_mobx](https://pub.dev/packages/flutter_mobx)
- **Roteamento & DI**: [flutter_modular](https://pub.dev/packages/flutter_modular)
- **HTTP**: [dio](https://pub.dev/packages/dio)
- **Firebase**: `firebase_core`, `firebase_auth`, `google_sign_in`
- **Cache de Imagens**: [cached_network_image](https://pub.dev/packages/cached_network_image)
- **Fontes & Ícones**: `google_fonts`, `font_awesome_flutter`, `flutter_svg`
- **Splash & Launcher**: `flutter_native_splash`, `flutter_launcher_icons`
- **Extração de Paleta**: [palette_generator](https://pub.dev/packages/palette_generator)

_Veja a lista completa em [`pubspec.yaml`](pubspec.yaml)._

## Problemas Conhecidos e Melhorias

- **Carregamento de Imagens**: sem cache persistente; sprites recarregam a cada visualização.
- **Tratamento de Erros**: falta exibição amigável de erros em falha de login.
- **Padrões MobX**: primeiro projeto com MobX — padrões podem ser refinados.
- **Duplicação de Código**: métodos repetidos; refatoração recomendada.
- **Persistencia do login**: o login é necessário sempre ao entrar no app.
- **Suporte Offline**: sem armazenamento local de dados da API.
- **Testes**: baixa cobertura; adicionar testes unitários e de widget.  
