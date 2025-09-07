import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sim_flights_tracker/core/state/provider/providers.dart';
import 'package:sim_flights_tracker/core/theme/colors.dart';
import 'package:sim_flights_tracker/core/theme/spacing.dart';
import 'package:sim_flights_tracker/core/utils.dart';
import 'package:sim_flights_tracker/presentation/widget/custom_divider.dart';
import 'package:sim_flights_tracker/presentation/widget/loader.dart';

import '../widget/navigation/custom_appbar.dart';

class DonationScreen extends ConsumerWidget {
  const DonationScreen({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context);
    var purchaseInProgress = ref.watch(appConfigProvider.select((state) => state.purchaseInProgress));

    return Scaffold(
      appBar: CustomAppBar(title: Text('Support the app')),
      body: switch (purchaseInProgress) {
        true => const SftLoader(message: 'Processing. Please wait...'),
        false => FutureBuilder(
          future: getProductDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SftLoader();
            }

            if(snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                var productDetails = snapshot.data ?? [];

                var statusList = productDetails.map((p) => p.id);
                log(statusList.toString());

                return ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Row(
                        children: [
                          Image.asset('assets/sft_transparent.png', width: 100,),
                          Expanded(
                            child: Text(
                              'Love using the app? Help me keep improving it by making a contribution below. Your support goes a long way.',
                              style: theme.textTheme.bodySmall,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                    customDivider(),
                    for (var product in productDetails)
                      GestureDetector(
                        onTap: () {
                          ref.read(appConfigProvider.notifier).updatePurchaseInProgress(true);
                          buyProduct(product);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: Spacing.halfPaddingInset,
                          margin: Spacing.halfMarginInset,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: SftColors.lightGreen,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.title.replaceAll('(Sim Flights Tracker)', ''), style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold, color: SftColors.lightGreen),),
                              Text(product.description, style: theme.textTheme.bodySmall),
                              customDivider(),
                              Text(product.price, style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, color: Colors.grey)),
                            ],
                          ),
                        ),
                      )
                    ,
                    customDivider(),
                    Container(
                      padding: Spacing.standardPaddingInset,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Contributions here are handled by Google Play. If you believe a donation was made in error or if you require a refund, please read the article below:',
                            style: theme.textTheme.bodySmall,
                          ),
                          GestureDetector(
                            onTap: () => openBrowser('https://support.google.com/googleplay/answer/2479637'),
                            child: Text('https://support.google.com/googleplay/answer/2479637', style: TextStyle(color: SftColors.lightGreen),),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('No Data'),
                );
              }
            }

            return SftLoader();
          },
        ),
      }
    );
  }
}