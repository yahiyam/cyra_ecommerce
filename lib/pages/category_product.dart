import 'package:cyra_ecommerce/pages/product_detail.dart';
import 'package:cyra_ecommerce/webservice/apis.dart';
import 'package:cyra_ecommerce/webservice/web_service.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class CategoryProductPage extends StatefulWidget {
  const CategoryProductPage({
    super.key,
    required this.catName,
    required this.catId,
  });
  final String catName;
  final int catId;

  @override
  State<CategoryProductPage> createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        title: Text(
          widget.catName,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      body: FutureBuilder(
        future: WebService().fetchCategoryProduct(widget.catId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StaggeredGridView.countBuilder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductDetailPage(product: product),
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: Container(
                              constraints: const BoxConstraints(
                                minHeight: 100,
                                maxHeight: 250,
                              ),
                              child: Image(
                                image: NetworkImage(
                                  '${Apis.mainUrl}/products${product.image!}',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    product.productname!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Rs. ${product.price!}',
                                    style: const TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
