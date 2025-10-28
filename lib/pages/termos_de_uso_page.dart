import 'package:flutter/material.dart';

class TermosDeUsoPage extends StatelessWidget {
  const TermosDeUsoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Termos de Uso – FALASP',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  '15 de outubro de 2025',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 16),

                Text(
                  'Bem-vindo ao FALASP. Estes Termos de Uso (“Termos”) regulam o uso deste aplicativo e dos serviços associados. '
                  'Ao usar o FALASP você concorda com estes Termos. Se não concordar, não use o aplicativo.\n',
                ),

                _SectionTitle('1. O que é o FALASP'),
                Text(
                  'O FALASP é uma plataforma comunitária para registro e validação colaborativa de perturbações de sossego (ex.: barulho). '
                  'O aplicativo permite que usuários registrem ocorrências em um mapa em tempo real e que vizinhos dentro de um raio de impacto participem de confirmações anônimas.\n',
                ),

                _SectionTitle('2. Caráter informativo das denúncias'),
                Text(
                  'As denúncias e validações realizadas no FALASP não constituem notificação oficial a autoridades. '
                  'Não são boletim de ocorrência, auto de infração, ordem judicial ou medida administrativa. '
                  'Para registrar uma ocorrência oficial, procure os canais competentes (ex.: polícia, prefeitura).\n',
                ),

                _SectionTitle('3. Cadastro e conta'),
                Text(
                  '• Login via conta Google.\n'
                  '• As denúncias e validações são anônimas, mas exigem autenticação.\n'
                  '• O usuário é responsável por manter a segurança da sua conta.\n',
                ),

                _SectionTitle('4. Privacidade e dados'),
                Text(
                  'Coletamos apenas dados necessários: localização, metadados e informações técnicas. '
                  'A localização é usada apenas para determinar o raio de impacto e o modo ronda. '
                  'Relatórios agregados e anônimos podem ser compartilhados com terceiros.\n',
                ),

                _SectionTitle('5. Uso aceitável'),
                Text(
                  'Você concorda em não usar o FALASP para:\n'
                  '• Fazer denúncias falsas;\n'
                  '• Assediar ou difamar indivíduos;\n'
                  '• Automatizar ou manipular resultados;\n'
                  '• Inserir conteúdo ilegal ou ofensivo.\n',
                ),

                _SectionTitle('6. Mecanismos anti-manipulação'),
                Text(
                  'O servidor utiliza algoritmos para detectar padrões suspeitos e pode aplicar pesos diferentes '
                  'às validações conforme o histórico de confiabilidade do usuário.\n',
                ),

                _SectionTitle('7. Limitação de responsabilidade'),
                Text(
                  'O FALASP é fornecido "no estado em que se encontra". Não garantimos precisão, continuidade ou disponibilidade dos dados. '
                  'O uso é de responsabilidade do usuário.\n',
                ),

                _SectionTitle('8. Conteúdo e propriedade'),
                Text(
                  'O conteúdo enviado pelos usuários continua sendo de sua titularidade, mas o FALASP recebe licença para exibir e agregar os dados '
                  'para funcionamento e melhorias do serviço.\n',
                ),

                _SectionTitle('9. Moderação e remoção'),
                Text(
                  'Reservamo-nos o direito de remover conteúdo que viole estes Termos ou a legislação aplicável.\n',
                ),

                _SectionTitle('10. Modo ronda'),
                Text(
                  'O modo ronda mantém a tela ativa e acompanha a posição em tempo real. '
                  'O usuário pode desativar a qualquer momento. '
                  'Não nos responsabilizamos por consumo de bateria ou dados decorrentes do uso.\n',
                ),

                _SectionTitle('11. Idade mínima'),
                Text(
                  'O uso é permitido a maiores de 16 anos. Menores devem usar com consentimento de pais ou responsáveis.\n',
                ),

                _SectionTitle('12. Alterações dos Termos'),
                Text(
                  'Podemos atualizar estes Termos periodicamente. O uso contínuo implica aceitação das novas condições.\n',
                ),

                _SectionTitle('13. Lei aplicável'),
                Text(
                  'Estes Termos são regidos pelas leis do Brasil. O foro competente será o da sede da empresa operadora do FALASP.\n',
                ),

                _SectionTitle('14. Contato'),
                Text(
                  'Dúvidas, sugestões ou solicitações: contato@falasp.app\n',
                ),

                _SectionTitle('15. Disposições finais'),
                Text(
                  'Se qualquer cláusula for considerada inválida, as demais permanecem em vigor. '
                  'Estes Termos constituem o acordo integral entre você e o FALASP.\n',
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

/// Widget auxiliar pra manter o padrão visual dos títulos de seção
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
