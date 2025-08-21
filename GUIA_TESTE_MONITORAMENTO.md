# Guia de Teste - Dashboard de Monitoramento Interno

## 🚀 Como Testar

### 1. Acesso à Aplicação
- A aplicação está rodando em: `http://localhost:XXXX` (porta dinâmica)
- Abra o navegador e acesse a URL mostrada no terminal
- ✅ **Status**: Aplicação funcionando corretamente

### 2. Login do Usuário Interno
- **Email**: Qualquer email contendo "admin" ou "agente" (ex: `admin@itaguai.gov.br` ou `agente@monitoramento.com`)
- **Senha**: Qualquer senha (ex: `123456`)
- Clique em "Entrar"
- Aguarde 2 segundos (simulação de API)
- **Resultado**: Será direcionado para o Dashboard de Monitoramento

### 3. Funcionalidades do Dashboard

#### 🎛️ **Sidebar (Menu Lateral)**
- **Logo "PI"**: Sistema Itaguaí - Segurança Pública
- **Botão de colapso**: Clique para expandir/recolher a sidebar
- **Botão do Pânico**: 
  - Caixa vermelha com aviso
  - Botão "EMERGÊNCIA" para ativação
  - Funcionalidade de emergência simulada

#### 📋 **Menu de Navegação**
1. **Dashboard** - Página atual (destacada)
2. **Mapa Geral** - Visualização do mapa
3. **Emergências** - Contador: 5 (mostra lista de emergências ativas)
4. **Trânsito** - Contador: 12 (mostra situação do trânsito)
5. **Segurança** - Funcionalidade em desenvolvimento
6. **Defesa Civil** - Contador: 2 (mostra ocorrências da defesa civil)
7. **Ouvidoria** - Funcionalidade em desenvolvimento
8. **Equipes** - Funcionalidade em desenvolvimento
9. **Relatórios** - Funcionalidade em desenvolvimento
10. **Configurações** - Funcionalidade em desenvolvimento

#### 🗺️ **Mapa Principal**
- **Localização**: Itaguaí, RJ
- **Marcadores coloridos**:
  - 🔴 **Vermelho**: Emergências (acidentes, incêndios)
  - 🟠 **Laranja**: Trânsito (congestionamentos, semáforos)
  - 🔵 **Azul**: Segurança (patrulhas, viaturas)
  - 🟢 **Verde**: Defesa Civil (alagamentos, deslizamentos)
- **Legenda**: Canto superior direito
- **Controles**: Zoom in/out, localização atual

#### 📊 **Header Principal**
- **Título**: "Prefeitura de Itaguaí - Segurança Pública"
- **Subtítulo**: "Sistema de Monitoramento Geral"
- **Status**: Botão verde "Ativo"
- **Notificações**: Ícone com contador "3"
- **Perfil**: Ícone de usuário
- **Opções**: Menu de três pontos

#### 🚨 **Status do Sistema**
- **Indicador verde**: "Sistema Online"
- **Mensagem**: "Todas as funcionalidades ativas"

### 4. Funcionalidades Interativas

#### **Botão do Pânico**
- Clique no botão "EMERGÊNCIA"
- **Resultado**: Dialog de emergência ativada
- **Simulação**: Notificação para todas as equipes

#### **Notificações**
- Clique no ícone de sino (contador "3")
- **Resultado**: Lista de notificações recentes

#### **Perfil do Usuário**
- Clique no ícone de pessoa
- **Resultado**: Informações do usuário logado

#### **Menu de Opções**
- Clique no ícone de três pontos
- **Resultado**: Opções de logout, ajuda, sobre

#### **Itens do Menu**
- Clique em qualquer item do menu lateral
- **Resultado**: Dialog com informações específicas da seção

### 5. Dados Mock Disponíveis

#### **Emergências Ativas (5)**:
1. **Acidente na BR-101** - Há 5 minutos
2. **Incêndio no Centro** - Há 12 minutos

#### **Situação do Trânsito (12)**:
1. **Congestionamento - BR-101** - 2 km de extensão
2. **Semáforo quebrado - Centro** - Em manutenção

#### **Defesa Civil (2)**:
1. **Alagamento - Rua das Flores** - Equipe no local
2. **Deslizamento - Morro do Céu** - Área isolada

#### **Marcadores no Mapa**:
- **Emergência**: Acidente na BR-101, km 45
- **Trânsito**: Congestionamento na Rodovia Rio-Santos
- **Segurança**: Viatura em patrulha - Centro
- **Defesa Civil**: Alagamento na Rua das Flores

### 6. Navegação e Interface

#### **Responsividade**:
- ✅ Sidebar colapsável
- ✅ Mapa responsivo
- ✅ Interface adaptável

#### **Cores e Temas**:
- **Primária**: Azul (#1976D2)
- **Emergência**: Vermelho
- **Trânsito**: Laranja
- **Segurança**: Azul
- **Defesa Civil**: Verde

#### **Interações**:
- ✅ Hover nos botões
- ✅ Seleção de menu
- ✅ Dialogs informativos
- ✅ Marcadores clicáveis no mapa

### 7. Testes Específicos

#### **Teste de Colapso da Sidebar**:
1. Clique no ícone de seta na sidebar
2. **Resultado**: Sidebar deve recolher/expandir
3. Verifique se os ícones permanecem visíveis

#### **Teste do Mapa**:
1. Clique nos marcadores coloridos
2. **Resultado**: Informações detalhadas devem aparecer
3. Teste zoom in/out
4. Teste botão de localização

#### **Teste de Menu**:
1. Clique em cada item do menu
2. **Resultado**: Dialogs específicos devem abrir
3. Verifique contadores nos itens

### 8. Compatibilidade

- ✅ **Web**: Chrome, Firefox, Safari, Edge
- ✅ **Responsivo**: Desktop, tablet, mobile
- ✅ **Navegadores**: Todos os principais

### 9. Próximos Passos

#### **Funcionalidades em Desenvolvimento**:
- [ ] Segurança (gestão de viaturas)
- [ ] Ouvidoria (denúncias e reclamações)
- [ ] Equipes (gestão de pessoal)
- [ ] Relatórios (estatísticas e análises)
- [ ] Configurações (preferências do sistema)

#### **Melhorias Futuras**:
- [ ] Tempo real com WebSocket
- [ ] Integração com APIs reais
- [ ] Notificações push
- [ ] Geolocalização em tempo real
- [ ] Chat interno entre operadores

---

## 🎯 Objetivo do Dashboard

Este dashboard foi desenvolvido para o **pessoal interno de monitoramento** da Prefeitura de Itaguaí, permitindo:

- **Monitoramento em tempo real** de emergências
- **Gestão de equipes** e recursos
- **Visualização geográfica** de ocorrências
- **Controle centralizado** da segurança pública
- **Comunicação integrada** entre setores

*Desenvolvido para demonstração e apresentação ao superior*
