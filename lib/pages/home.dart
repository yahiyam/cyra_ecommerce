import 'dart:developer';

import 'package:cyra_ecommerce/constants.dart';
import 'package:cyra_ecommerce/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 60,
        title: const Text(
          'E-commerce',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Category',
              style: TextStyle(
                color: mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 12,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        log('clicked');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: mainColor.withAlpha(100),
                        ),
                        child: const Center(
                          child: Text(
                            'Category Name',
                            style: TextStyle(
                              color: mainColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Most searched products',
              style: TextStyle(
                color: mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                shrinkWrap: true,
                itemCount: 14,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      log('clicked');
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
                                child: const Image(
                                  image: NetworkImage(networkImage),
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
                                      "Shoes",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Rs. 2000',
                                      style: TextStyle(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
