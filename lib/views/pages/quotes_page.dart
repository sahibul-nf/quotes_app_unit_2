import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quotes_app_unit_2/controllers/quote_controller.dart';
import 'package:quotes_app_unit_2/repositories/quotes_repository.dart';
import 'package:quotes_app_unit_2/views/themes/typography.dart';
import 'package:quotes_app_unit_2/views/widgets/icon_solid_light.dart';

import '../widgets/quote_card.dart';
import 'quote_detail_page.dart';

class QuotesPage extends ConsumerWidget {
  const QuotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // panggil controller provider
    final randomQuotes = ref.watch(getRandomQuotesProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            centerTitle: false,
            backgroundColor: Colors.white,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: IconSolidLight(
                  icon: PhosphorIcons.regular.magnifyingGlass,
                  onTap: () {
                    QuotesRepository().getRandomQuotes();
                  },
                ),
              ),
            ],
            title: Text("Quotes", style: MyTypography.h2),
            expandedHeight: 116,
            elevation: 0,
            floating: true,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              expandedTitleScale: 1.0,
              titlePadding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 16,
              ),
              title: Text(
                "Quotes",
                style: MyTypography.h2,
              ),
            ),
          ),

          // tampilin data ke Widget
          randomQuotes.when(
            data: (quotesData) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        right: 16,
                        left: 16,
                        bottom: 16,
                        top: index == 0 ? 100 : 0,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const QuoteDetailPage(
                                content:
                                    "The best way to get started is to quit talking and begin doing. The best way to get started is to quit talking and begin doing. The best way to get started is to quit talking and begin doing.",
                                author: "Rick Riordan",
                                authorAvatar: "assets/img_avatar.png",
                                authorJob:
                                    "Co-Founder of The Walt Disney Company",
                              ),
                            ),
                          );
                        },
                        child: QuotesCard(
                          content: quotesData[index].content ?? "",
                          author: quotesData[index].author ?? "author",
                          authorAvatar: "assets/img_avatar.png",
                          authorJob: "authorJob",
                        ),
                      ),
                    );
                  },
                  childCount: 10,
                ),
              );
            },
            error: (error, _) {
              return SliverToBoxAdapter(
                child: Text(error.toString()),
              );
            },
            loading: () {
              return const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
