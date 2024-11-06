
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:proj_pokedex/domain/pokemon.dart';
import 'package:proj_pokedex/repository/repository_imp.dart';
import 'package:provider/provider.dart';

import '../widgets/pokecard.dart';


class HomeMaterial extends StatefulWidget{
  const HomeMaterial({super.key});
  @override
  State<HomeMaterial> createState() => _HomeMaterialState();
}

class _HomeMaterialState extends State<HomeMaterial> {
  late final PagingController<int, Pokemon> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(
        (pageKey) async {
          final repositoryImp = Provider.of<RepositoryImp>(context, listen: false);
          try{
            final pokemons = await repositoryImp.getPokemons(page: pageKey, limit: 20).timeout(const Duration(seconds: 10));
            _pagingController.appendPage(pokemons, pageKey+1);
          }catch(e){
            _pagingController.error(e);
          }
        }
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
      ),
      body: PagedListView(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Pokemon>(
              itemBuilder: (BuildContext context, Pokemon pokemon, int index) => PokeCard(pokemon: pokemon),
          )
      ),
    );
  }
}