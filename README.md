# Meli Project
## 📄 Índice

* [Paleta de Colores](#paleta-de-colores)
* [Prototipo de Baja Fidelidad](#prototipo-de-baja-fidelidad)
* [Prototipos de Fidelidade Media y Análisis de Componentes](#prototipos-de-fidelidade-media-y-análisis-de-componentes)
* [Flujo da Aplicación](#flujo-da-aplicación)
* [Overview](#overview)
* [Manejo de Escenarios](#manejo-de-escenarios)
* [Meli Project](#meli-project)
    * [Requisitos](#requisitos)
* [Arquitectura do Proyeto](#arquitectura-do-proyeto)
    * [Logs e Observabilidade do Projeto](#logs-e-observabilidade-do-projeto)
    * [Bibliotecas Utilizadas](#bibliotecas-utilizadas)
* [Melhorias](#melhorias)


### Paleta de colores 
> Paleta de cores
<img width="678" height="220" alt="paleta-cores" src="https://github.com/user-attachments/assets/edbe135a-79ed-4181-a824-b2d9c6f860e4" />

### Prototipo de baja fidelidad
>  Protótipo de baixa fidelidade
<img width="1387" height="665" alt="prototipo" src="https://github.com/user-attachments/assets/7f8daece-3bea-4487-ba4f-d8fff4b508b2" />

### Prototipos de fidelidade media y análisis de componentes
> Protótipo de média fidelidade e análise de componentes 
<img width="1443" height="638" alt="prototipo-e-componentes" src="https://github.com/user-attachments/assets/530815f4-cae5-48bc-a2cb-a6457a8b11e3" />

### Flujo da aplicación
> Fluxo do app
<img width="1763" height="340" alt="fluxograma" src="https://github.com/user-attachments/assets/0cfa1f3a-6c9f-414e-aae0-2581bc27caf6" />

### Overview
<img width="3353" height="1789" alt="overview" src="https://github.com/user-attachments/assets/4967d9f0-3843-46f7-ab34-26005f33f57e" />

### Manejo de escenarios
> Tratamento de cenários
<img width="3353" height="1789" alt="casos" src="https://github.com/user-attachments/assets/0c387745-cb25-406b-a6b6-fcb44ea371d6" />

# Meli Project 
Este proyecto fue desarrollado con el objetivo de ofrecer un "buscador" de productos de Mercado Libre. La app cuenta con los siguientes requisitos principales:
> Esse projeto foi desenvolvido com o objetivo de disponibilizar um "buscador" de produtos do mercado livre. O app conta com os seguintes principais requisitos:

## Requisitos

| Tipo                     | Descrição                                                                 | Issue                                            | 
|--------------------------|---------------------------------------------------------------------------|--------------------------------------------------|
| Funcional                | Campo de busca                                                            | https://github.com/biaduque/MeliProject/issues/1 | 
| Funcional                | Visualização dos resultados da busca (lista)                              | https://github.com/biaduque/MeliProject/issues/2 | 
| Funcional                | Visualização do detalhe de um produto                                     | https://github.com/biaduque/MeliProject/issues/4 |
| Não Funcional            | O sistema deve possuir a tela adaptada à rotação da visualização          | https://github.com/biaduque/MeliProject/issues/6 |
| Não Funcional            | O sistema deve tratar erros inesperados (logs)                            | https://github.com/biaduque/MeliProject/issues/7 |
| Não Funcional            | O sistema deve fornecer feedbacks de erro ao usuário                      | https://github.com/biaduque/MeliProject/issues/8 |
| Não Funcional            | Testes unitários                                                          | https://github.com/biaduque/MeliProject/issues/9 | 


> ⚠️ **Atenção** ⚠️
> Debido a problemas encontrados en la conexión con la API de Mercado Libre, el proyecto actualmente está utilizando un mock (mediante un archivo .json). Los problemas encontrados están documentados en el archivo: [utilizar-token.pdf](https://github.com/user-attachments/files/21537136/utilizar-token.pdf)

# Arquitectura do proyeto
> Arquitetura do projeto

### VIPER + Coordinator
**View**: Camada da UI (View e ViewController).
**Interactor**: Contém a lógica de negócio (responsável por obter e persistir dados, invocar o **Worker**).
**Presenter**: Atua como intermediário entre View e Interactor/Router, formatando dados para a View e recebe eventos dela a serem exibidos ao usuário.
**Entity**: Modelos de dados (Item, SearchResult, etc.) que populam as telas
**Router**: Lida com a lógica de navegação e a criação de módulos

**Coordinator**: Desacopla a ViewController da responsabilidade de navegação. Orquestra a instância das ViewControllers e lida com o tipo de ViewController a ser exibida [(VC nativa ou VC+Webview)](https://github.com/biaduque/MeliProject/blob/main/MeliProject/App/Coordinator/MeliProjectCoordinator.swift)

## Logs e observabilidade do projeto
La observabilidad del proyecto fue desarrollada con la herramienta Firebase, que permite al administrador de la aplicación monitorear accesos a pantallas, clics, fallos (crashs) y errores en la app.
> A observabilidade do projeto foi desenvolvida com a ferramenta Firebase, que permite ao administrador do app acompanhar acessos de tela, cliques, crashs e erros na aplicação
<img width="1249" height="608" alt="Captura de Tela 2025-07-31 às 14 08 40" src="https://github.com/user-attachments/assets/45340d93-061f-44b2-9c67-27a6bc1fb127" />

## Bibliotecas utilizadas
Para este proyecto se utilizaron las siguientes bibliotecas:
> Para este projeto, as seguintes libs foram utilizadas:

* [UIKit](https://developer.apple.com/documentation/uikit): Framework Swift para desenvolvimento de apps
* [Snapkit](https://github.com/SnapKit/SnapKit): Lib para construção de constraints
* [RXSwif](https://github.com/ReactiveX/RxSwift): Lib para desenvolvimento de programação reativa
* [Kingfisher](https://github.com/onevcat/Kingfisher): Lib para download de imagens através de uma URL, realiza o controle de cache e liberação de memória (após encerramento do app) através do '''NSCache''' (MemoryCache) e '''DiskStorage''' (armazenamento em disco)
* [Firebase](https://github.com/firebase/firebase-ios-sdk):Lib para realizar o disparo de logs e acompanhamento em tempo real 

# Melhorias 
* Adicionar fluxo de login (WIP) branch [feat/token-auth](https://github.com/biaduque/MeliProject/pull/16) para utilizar token para a consulta nas APIs do Meli : https://github.com/biaduque/MeliProject/issues/17
* Finalizar cobertura de testes unitários (WIP devido à arquivos de autenticação que estão criados porém ainda não finalizados)
* Adicionar resultados de busca através da localização do usuário: https://github.com/biaduque/MeliProject/issues/18
* Adicionar CI/CD no projeto com o uso de github actions: https://github.com/biaduque/MeliProject/issues/19

