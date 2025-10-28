import 'package:flutter/material.dart';

class PoliticaPrivacidadePage extends StatelessWidget {
  const PoliticaPrivacidadePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text('Política de Privacidade'),
        backgroundColor: Colors.white,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Política de Privacidade – FALASP',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  '15 de outubro de 2025',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 16),

                Text(
                  'Esta Política de Privacidade descreve como o FALASP coleta, utiliza, armazena e protege as informações dos usuários. '
                  'Ao utilizar o aplicativo, você concorda com esta política.\n',
                ),

                _SectionTitle('1. Informações que coletamos'),
                Text(
                  'O FALASP coleta apenas os dados necessários para o funcionamento adequado do serviço:\n\n'
                  '• Localização aproximada (para calcular o raio de impacto e exibir denúncias próximas);\n'
                  '• Dados de uso e desempenho do aplicativo;\n'
                  '• Informações básicas da conta Google usada para login (ID, nome e e-mail);\n'
                  '• Dados técnicos do dispositivo, como sistema operacional e modelo, para diagnóstico de falhas.\n',
                ),

                _SectionTitle('2. Finalidade do uso dos dados'),
                Text(
                  'As informações coletadas são usadas para:\n\n'
                  '• Exibir e validar denúncias em tempo real;\n'
                  '• Garantir o funcionamento correto do modo ronda;\n'
                  '• Prevenir fraudes e manipulações de denúncias;\n'
                  '• Melhorar a qualidade e precisão do sistema;\n'
                  '• Enviar comunicações essenciais sobre o uso do app.\n',
                ),

                _SectionTitle('3. Armazenamento e segurança'),
                Text(
                  'Os dados são armazenados em servidores seguros, com criptografia em trânsito (HTTPS) e mecanismos de controle de acesso. '
                  'Somente sistemas automatizados e colaboradores autorizados têm acesso aos dados quando necessário para manutenção e operação.\n',
                ),

                _SectionTitle('4. Compartilhamento de informações'),
                Text(
                  'O FALASP não compartilha informações pessoais identificáveis com terceiros, exceto:\n\n'
                  '• Quando exigido por lei, ordem judicial ou solicitação de autoridade competente;\n'
                  '• De forma agregada e anônima, para fins de pesquisa, estatísticas ou colaboração com órgãos públicos.\n',
                ),

                _SectionTitle('5. Dados de localização'),
                Text(
                  'A localização é usada apenas durante o uso do aplicativo para identificar ocorrências próximas e definir o raio de impacto. '
                  'O FALASP não rastreia o usuário fora do contexto de uso ativo e não armazena o histórico detalhado de deslocamento.\n',
                ),

                _SectionTitle('6. Anonimato e denúncias'),
                Text(
                  'Todas as denúncias e validações são processadas de forma anônima. '
                  'O sistema nunca associa a identidade da conta ao conteúdo da denúncia. '
                  'Os dados são agregados para formar indicadores comunitários de ruído e perturbação.\n',
                ),

                _SectionTitle('7. Direitos do usuário'),
                Text(
                  'Você pode, a qualquer momento:\n\n'
                  '• Solicitar a exclusão da sua conta e dados pessoais;\n'
                  '• Revogar permissões de localização;\n'
                  '• Solicitar acesso ou correção de dados armazenados.\n\n'
                  'Essas solicitações podem ser feitas por e-mail em contato@falasp.app.\n',
                ),

                _SectionTitle('8. Retenção dos dados'),
                Text(
                  'Os dados são mantidos apenas pelo tempo necessário para as finalidades descritas nesta política. '
                  'Após a exclusão da conta, dados pessoais são removidos de forma segura, preservando apenas registros agregados e anônimos.\n',
                ),

                _SectionTitle('9. Cookies e tecnologias semelhantes'),
                Text(
                  'O FALASP não utiliza cookies no aplicativo móvel. Caso futuramente sejam implementados cookies ou tecnologias de rastreamento, '
                  'essa política será atualizada e o usuário será informado.\n',
                ),

                _SectionTitle('10. Alterações nesta Política'),
                Text(
                  'Podemos atualizar esta Política de Privacidade periodicamente. '
                  'A data de vigência será sempre informada no topo do documento. '
                  'O uso contínuo do aplicativo após alterações implica aceitação das novas condições.\n',
                ),

                _SectionTitle('11. Contato'),
                Text(
                  'Dúvidas, solicitações ou reclamações relacionadas à privacidade podem ser enviadas para:\n'
                  '📧 contato@falasp.app\n',
                ),

                SizedBox(height: 24),
                Center(
                  child: Text(
                    '© 2025 FALASP. Todos os direitos reservados.',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget para manter consistência dos títulos de seção
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
