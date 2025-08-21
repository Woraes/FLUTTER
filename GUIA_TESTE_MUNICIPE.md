# Guia de Teste - Funcionalidades do Munícipe

## 🚀 Como Testar

### 1. Acesso à Aplicação
- A aplicação está rodando em: `http://localhost:XXXX` (porta dinâmica)
- Abra o navegador e acesse a URL mostrada no terminal
- ✅ **Status**: Aplicação funcionando corretamente

### 2. Login do Munícipe
- **Email**: Qualquer email válido (ex: `municipe@teste.com`)
- **Senha**: Qualquer senha (ex: `123456`)
- Clique em "Entrar"
- Aguarde 2 segundos (simulação de API)

### 3. Funcionalidades Disponíveis

#### 🏠 **Tela Inicial (Dashboard)**
- Mensagem de boas-vindas personalizada
- Cards de funcionalidades:
  - **Botão do Pânico** (FAB vermelho)
  - **Ocorrências de Trânsito**
  - **Canal da População**
- **Botão de perfil** no AppBar

#### 🚨 **Botão do Pânico**
- Clique no botão flutuante vermelho "PÂNICO"
- Confirmação de emergência
- Simulação de envio de localização
- Chamada para número de emergência

#### 📋 **Trânsito**
- **Aba "Minhas Ocorrências"**: Lista das ocorrências de trânsito reportadas pelo usuário
  - 3 ocorrências mock (Acidente, Semáforo quebrado, Buraco na via)
  - Filtros por status: Todas, Pendentes, Em Andamento, Resolvidas
  - Botão "Nova Ocorrência de Trânsito" (em desenvolvimento)
- **Aba "Mapa"**: Google Maps com localizações em tempo real
  - Marcadores azuis: Ocorrências do usuário
  - Marcadores coloridos: Reportes dos agentes de trânsito
  - Legenda explicativa dos tipos de marcadores
  - Informações detalhadas ao clicar nos marcadores

#### 📢 **Canal da População**
- 4 abas disponíveis:
  - **Denúncias Anônimas**: 2 exemplos mock
  - **Sugestões**: 1 exemplo mock
  - **Reclamações**: 1 exemplo mock
  - **Pesquisas**: 1 exemplo mock
- Botões "Nova Denúncia/Sugestão/etc." (em desenvolvimento)

#### 👤 **Perfil do Usuário**
- Informações pessoais editáveis (nome, email, telefone, CPF)
- Informações da conta (data de cadastro, último login, status)
- Estatísticas das ocorrências de trânsito
- Modo de edição com validação de formulário

### 4. Navegação
- **Barra inferior** com 3 seções:
  - Início (Dashboard)
  - Trânsito (Ocorrências + Mapa)
  - Canal
- **Botão de perfil** no AppBar (ícone de pessoa)
- **Abas na seção Trânsito**:
  - Minhas Ocorrências
  - Mapa (Google Maps)

### 5. Dados Mock Disponíveis

#### Ocorrências de Trânsito (do usuário):
1. **Acidente de Trânsito** - Resolvida
2. **Semáforo Quebrado** - Em Andamento
3. **Buraco na Via** - Pendente

#### Reportes dos Agentes de Trânsito (no mapa):
1. **Infração de Trânsito** - Veículo estacionado irregularmente (João Silva - AT001)
2. **Congestionamento** - Avenida Principal (Maria Santos - AT002)
3. **Acidente** - Moto e carro (Pedro Costa - AT003)

#### Denúncias Anônimas:
1. **Venda Irregular** - Em análise
2. **Desmatamento** - Pendente

#### Sugestões:
1. **Melhoria na Sinalização** - Em análise

#### Reclamações:
1. **Falta de Iluminação** - Pendente

#### Pesquisas:
1. **Satisfação com Transporte Público** - Ativa

## 🔧 Estrutura Técnica

### Arquivos Principais:
- `lib/main.dart` - Ponto de entrada
- `lib/presentation/citizen/citizen_home_page.dart` - Dashboard do munícipe
- `lib/presentation/citizen/occurrences_page.dart` - Página de ocorrências de trânsito
- `lib/presentation/citizen/population_channel_page.dart` - Canal da população
- `lib/presentation/citizen/citizen_profile_page.dart` - Perfil do munícipe
- `lib/presentation/panic_button/panic_button_page.dart` - Botão do pânico
- `lib/data/models/citizen_features.dart` - Modelos de dados

### Autenticação:
- Simulada no `AuthBloc`
- Retorna usuário tipo `citizen`
- Token JWT mock

## 🎯 Próximos Passos

1. **Integração com API Real**
   - Substituir dados mock por chamadas reais
   - Implementar JWT real
   - Conectar com PostgreSQL

2. **Funcionalidades em Desenvolvimento**
   - Formulários de nova ocorrência
   - Upload de imagens/vídeos
   - Geolocalização real
   - Notificações push

3. **Parte do Agente**
   - Dashboard específico para agentes
   - Chat interno
   - Relatórios
   - Escalas

## 📱 Compatibilidade
- ✅ Web (Chrome)
- ✅ Mobile (Android/iOS) - quando compilado
- ✅ Responsivo

## 🐛 Problemas Conhecidos
- Dados são mock (não persistem)
- Funcionalidades marcadas como "em desenvolvimento"
- Autenticação simulada
- ✅ **Corrigido**: Erro de setState no CitizenDashboardTab
- ✅ **Corrigido**: Diretórios de assets não encontrados
- ✅ **Corrigido**: Suporte web não configurado

---
*Desenvolvido para demonstração e apresentação ao superior*
