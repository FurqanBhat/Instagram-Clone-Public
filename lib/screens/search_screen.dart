import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool showUsers = false;
  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          onFieldSubmitted: (val) {
            setState(() {
              showUsers = true;
            });
          },
          controller: _searchController,
          decoration: InputDecoration(
            labelText: "Search for a uses",
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .where('username', isGreaterThanOrEqualTo: _searchController.text)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return showUsers
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data!.docs[index].get('username')),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          snapshot.data!.docs[index].get('photoUrl'),
                        ),
                      ),
                    );
                  },
                )
              : FutureBuilder(
                  future: FirebaseFirestore.instance.collection('posts').get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return MasonryGridView.count(
                      itemCount: snapshot.data!.docs.length,
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 5,
                      crossAxisCount: 3,
                      itemBuilder: (context, index) {
                        return StaggeredGridTile.count(
                            crossAxisCellCount: index % 3==0 ? 2 : 1,
                            mainAxisCellCount:  index % 3==0 ? 2 : 1,
                            child: Image.network(
                                snapshot.data!.docs[index].get('postUrl')));
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
