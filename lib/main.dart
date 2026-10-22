import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


// ============================================================
// CONFIGURAÇÕES: troque pelos seus dados reais
// ============================================================
const String kNome = 'Giovanna Oliveira';
const String kGithub = 'https://github.com/giovanna333/P2_DWIII';
const String kDeploy = 'https://giovanna333.github.io/P2_DWIII/';
const String kLinkedin = 'https://www.linkedin.com/in/giovannasouza1/';
const String kEmail = 'mailto:giovanna.deoliveira06@gmail.com';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfólio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF4F46E5),
        brightness: Brightness.light,
      ),
      home: const HomePage(),
    );
  }
}

Future<void> abrirLink(String url) async {
  await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _projetosKey = GlobalKey();
  final _sobreKey = GlobalKey();
  final _contatoKey = GlobalKey();

  void _irPara(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _Cabecalho(
              onProjetos: () => _irPara(_projetosKey),
              onSobre: () => _irPara(_sobreKey),
              onContato: () => _irPara(_contatoKey),
            ),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      _CardDestaque(key: _projetosKey),
                      const SizedBox(height: 32),
                      const _AreaVisual(),
                      const SizedBox(height: 48),
                      _Secao(
                        key: _sobreKey,
                        titulo: '💡 O Problema e a Solução',
                        child: const _ProblemaSolucao(),
                      ),
                      const SizedBox(height: 48),
                      const _Secao(
                        titulo: '🛠️ Arquitetura e Tecnologias Utilizadas',
                        child: _Tecnologias(),
                      ),
                      const SizedBox(height: 48),
                      const _Secao(
                        titulo: '⚡ Características Principais',
                        child: _Features(),
                      ),
                      const SizedBox(height: 48),
                      const _Secao(
                        titulo: '📈 Resultados e Lições Aprendidas',
                        child: _Resultados(),
                      ),
                      const SizedBox(height: 48),
                      _CallToAction(key: _contatoKey),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
            const _Rodape(),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 1. CABEÇALHO
// ============================================================
class _Cabecalho extends StatelessWidget {
  final VoidCallback onProjetos;
  final VoidCallback onSobre;
  final VoidCallback onContato;

  const _Cabecalho({
    required this.onProjetos,
    required this.onSobre,
    required this.onContato,
  });

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Row(
            children: [
              Icon(Icons.code_rounded, color: cores.primary),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  kNome,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              TextButton(onPressed: onProjetos, child: const Text('Projetos')),
              TextButton(onPressed: onSobre, child: const Text('Sobre')),
              TextButton(onPressed: onContato, child: const Text('Contato')),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// 2. CARD DE DESTAQUE
// ============================================================
class _CardDestaque extends StatelessWidget {
  const _CardDestaque({super.key});

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(label: Text('Front-end')),
                Chip(label: Text('React')),
                Chip(label: Text('Out 2026')),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              '🎯 Desenvolvimento de um Dashboard E-commerce em Tempo Real',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Uma aplicação web escalável com atualizações ao vivo, gráficos '
              'interativos e foco total na experiência do usuário (UX).',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                OutlinedButton.icon(
                  onPressed: () => abrirLink(kGithub),
                  icon: const Icon(Icons.north_east),
                  label: const Text('Ver Código no GitHub'),
                ),
                FilledButton.icon(
                  onPressed: () => abrirLink(kDeploy),
                  icon: const Icon(Icons.auto_awesome),
                  label: const Text('Acessar Deploy em Produção'),
                  style: FilledButton.styleFrom(backgroundColor: cores.primary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 3. ÁREA VISUAL (mockup desenhado com widgets, sem imagens)
// ============================================================
class _AreaVisual extends StatelessWidget {
  const _AreaVisual();

  @override
  Widget build(BuildContext context) {
    final alturas = [0.35, 0.55, 0.45, 0.8, 0.65, 0.95, 0.7];
    return Container(
      height: 280,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF4F46E5), Color(0xFF9333EA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Vendas em tempo real',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final h in alturas)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: FractionallySizedBox(
                        heightFactor: h,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// Título de seção reutilizável
// ============================================================
class _Secao extends StatelessWidget {
  final String titulo;
  final Widget child;

  const _Secao({super.key, required this.titulo, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}

class _CardTexto extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String texto;

  const _CardTexto({
    required this.icone,
    required this.titulo,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icone, color: cores.primary, size: 32),
            const SizedBox(height: 12),
            Text(
              titulo,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              texto,
              style: TextStyle(height: 1.5, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 4. PROBLEMA E SOLUÇÃO
// ============================================================
class _ProblemaSolucao extends StatelessWidget {
  const _ProblemaSolucao();

  @override
  Widget build(BuildContext context) {
    const desafio = _CardTexto(
      icone: Icons.report_problem_outlined,
      titulo: 'O Desafio',
      texto: 'Lojistas precisavam monitorar vendas sem atualizar a página '
          'manualmente, perdendo tempo e informação importante.',
    );
    const solucao = _CardTexto(
      icone: Icons.lightbulb_outline,
      titulo: 'A Solução',
      texto: 'Criação de um pipeline de dados com WebSockets e renderização '
          'otimizada, mostrando cada venda assim que ela acontece.',
    );

    return LayoutBuilder(
      builder: (context, c) {
        if (c.maxWidth > 700) {
          return const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: desafio),
              SizedBox(width: 16),
              Expanded(child: solucao),
            ],
          );
        }
        return const Column(
          children: [desafio, SizedBox(height: 16), solucao],
        );
      },
    );
  }
}

// ============================================================
// 5. ARQUITETURA E TECNOLOGIAS
// ============================================================
class _Tecnologias extends StatelessWidget {
  const _Tecnologias();

  @override
  Widget build(BuildContext context) {
    const techs = [
      ['React.js', 'Componentização e ótimo ecossistema para interfaces reativas.'],
      ['Node.js', 'Servidor leve e ideal para conexões WebSocket em tempo real.'],
      ['Tailwind CSS', 'Estilização rápida, consistente e responsiva.'],
    ];
    return Column(
      children: [
        for (final t in techs)
          Card(
            elevation: 1,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              leading: CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.primaryContainer,
                child: Text(t[0][0]),
              ),
              title: Text(
                t[0],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(t[1]),
            ),
          ),
      ],
    );
  }
}

// ============================================================
// 6. CARACTERÍSTICAS PRINCIPAIS
// ============================================================
class _Features extends StatelessWidget {
  const _Features();

  @override
  Widget build(BuildContext context) {
    const itens = [
      [Icons.devices, '🎨 UI/UX Responsivo', 'Se adapta a qualquer tamanho de tela.'],
      [Icons.bar_chart, '📊 Gráficos Dinâmicos', 'Atualização a cada 500ms usando ApexCharts.'],
      [Icons.lock_outline, '🔒 Autenticação', 'Proteção de rotas com JWT.'],
    ];

    return LayoutBuilder(
      builder: (context, c) {
        const espaco = 16.0;
        final colunas = c.maxWidth > 800 ? 3 : (c.maxWidth > 520 ? 2 : 1);
        final largura = (c.maxWidth - espaco * (colunas - 1)) / colunas;
        return Wrap(
          spacing: espaco,
          runSpacing: espaco,
          children: [
            for (final i in itens)
              SizedBox(
                width: largura,
                child: _CardTexto(
                  icone: i[0] as IconData,
                  titulo: i[1] as String,
                  texto: i[2] as String,
                ),
              ),
          ],
        );
      },
    );
  }
}

// ============================================================
// 7. RESULTADOS E LIÇÕES APRENDIDAS
// ============================================================
class _Resultados extends StatelessWidget {
  const _Resultados();

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    Widget linha(IconData icone, String titulo, String texto) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icone, color: cores.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$titulo: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: texto),
                  ],
                ),
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        linha(Icons.speed, 'Desempenho',
            'Redução de 40% no tempo de carregamento inicial (LCP).'),
        linha(Icons.school_outlined, 'Aprendizado',
            'Implementação profunda de gerenciamento de estado global.'),
      ],
    );
  }
}

// ============================================================
// 8. CALL TO ACTION
// ============================================================
class _CallToAction extends StatelessWidget {
  const _CallToAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1B4B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            '🤝 Vamos trabalhar juntos?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Gostou do projeto? Estou disponível para novos desafios e contratos.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: () => abrirLink(kEmail),
                icon: const Icon(Icons.email_outlined),
                label: const Text('Enviar Mensagem por E-mail'),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF1E1B4B),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => abrirLink(kLinkedin),
                icon: const Icon(Icons.link),
                label: const Text('Conectar no LinkedIn'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white70),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================
// RODAPÉ
// ============================================================
class _Rodape extends StatelessWidget {
  const _Rodape();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Text(
        '© 2026 $kNome. Feito com Flutter.',
        style: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }
}