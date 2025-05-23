import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cozykart/core/utils/lang_helper.dart';
import 'package:cozykart/features/shop/presentation/cubit/product_cubit.dart';
import 'package:cozykart/features/shop/presentation/cubit/product_state.dart';
import 'package:cozykart/generated/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/HomeScreen';

  final List<String> bannerImages = const [
    'assets/images/slider1.jpg',
    'assets/images/slider2.jpg',
    'assets/images/slider3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    context.read<ProductCubit>().getBestPriceProducts();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 180.h,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
            items:
                bannerImages.map((url) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset(
                      url,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                }).toList(),
          ),
          SizedBox(height: 24.h),
          Text(
            S.of(context).bestPrice,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 24.h),
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return SizedBox(
                  height: 400.h,
                  child: const Center(child: CircularProgressIndicator()),
                );
              } else if (state is BestPriceProductsLoaded) {
                final bestProducts = state.bestPriceProducts;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: bestProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                    childAspectRatio: 3 / 4,
                  ),
                  itemBuilder: (context, index) {
                    final product = bestProducts[index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.network(
                            product.image,
                            height: 120.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          product.localizedName(context) is Map
                              ? getLocalizedValue(
                                product.localizedName(context)
                                    as Map<String, dynamic>?,
                                context,
                              )
                              : product.localizedName(context).toString(),

                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "EGP ${product.price}",
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                      ],
                    );
                  },
                );
              } else if (state is ProductError) {
                return Text("Error: ${state.message}");
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
