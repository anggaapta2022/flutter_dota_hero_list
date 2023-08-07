part of './pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  List listRoles = [
    'All',
    'Carry',
    'Support',
    'Nuker',
    'Disabler',
    'Durable',
    'Escape',
    'Pusher',
    'Initiator',
  ];
  String roleSelected = "All";
  var items = [];
  List filteredHeroes = [];

  void _filterHeroes(String query) {
    var heroProvider = Provider.of<HeroProvider>(context, listen: false);
    setState(() {
      if (query.isEmpty && roleSelected == "All") {
        filteredHeroes = heroProvider.dataHeroes;
      } else if (query.isEmpty && roleSelected != "All") {
        filteredHeroes = heroProvider.dataHeroes.where((hero) {
          final roles = hero['roles'];
          return roles.contains(roleSelected);
        }).toList();
      } else {
        filteredHeroes = heroProvider.dataHeroes.where((hero) {
          final name = hero['localized_name'].toString().toLowerCase();
          return name.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var heroProvider = Provider.of<HeroProvider>(context, listen: false);
      heroProvider.loading = true;
      heroProvider.getDataHeroes().whenComplete(() {
        setState(() {
          items.addAll(heroProvider.dataHeroes);
          filteredHeroes = heroProvider.dataHeroes;
        });
      });
      Timer(const Duration(seconds: 2), () {
        heroProvider.loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var heroProvider = Provider.of<HeroProvider>(context);
    Widget sectionTop() {
      return Container(
        margin: const EdgeInsets.only(bottom: 25, left: 24, right: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 205,
              child: Text(
                "Learn your\nFavorite HERO",
                style: whiteTextStyle.copyWith(fontSize: 28, fontWeight: bold),
                textScaleFactor: context.textscale,
              ),
            ),
            Image.asset(
              "assets/logo.png",
              width: 55,
              height: 55,
            ),
          ],
        ),
      );
    }

    Widget sectionFilterChip() {
      return Container(
        width: context.width * 1,
        margin: const EdgeInsets.only(bottom: 25),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: listRoles
                .map(
                  (item) => GestureDetector(
                    onTap: () {
                      setState(() {
                        roleSelected = item;
                        if (roleSelected == "All") {
                          filteredHeroes = heroProvider.dataHeroes;
                        } else {
                          filteredHeroes =
                              heroProvider.dataHeroes.where((hero) {
                            final roles = hero['roles'];
                            return roles.contains(roleSelected);
                          }).toList();
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 17),
                      margin: EdgeInsets.only(
                          left: listRoles.indexOf(item) == 0 ? 24 : 0,
                          right: listRoles.indexOf(item) == listRoles.length - 1
                              ? 24
                              : 10),
                      decoration: BoxDecoration(
                        color: roleSelected == item ? cOrange : null,
                        border: Border.all(
                            color:
                                roleSelected == item ? cTransparent : cOrange,
                            width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          item,
                          style: whiteTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight:
                                roleSelected == item ? semiBold : regular,
                          ),
                          textScaleFactor: context.textscale,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
    }

    Widget sectionSearch() {
      return Container(
        margin: const EdgeInsets.only(left: 24, right: 24, bottom: 20),
        child: TextFormField(
          // controller: searchController,
          onChanged: _filterHeroes,
          cursorColor: cOrange,
          style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: medium),
          decoration: InputDecoration(
            hintText: "Search your hero",
            hintStyle:
                greyTextStyle.copyWith(fontSize: 14, fontWeight: regular),
            contentPadding: const EdgeInsets.all(10),
            suffixIcon: Icon(
              Icons.search,
              size: 24,
              color: cOrange,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: cOrange),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: cOrange),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
    }

    Widget sectionContent() {
      Widget sectionContentError() {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/error.png',
                width: 228,
                height: 226,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Something wrong",
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
                textScaleFactor: context.textscale,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Please try again",
                style: greyTextStyle.copyWith(fontSize: 12, fontWeight: medium),
                textScaleFactor: context.textscale,
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  heroProvider.loading = true;
                  heroProvider.getDataHeroes().whenComplete(() {
                    Timer(const Duration(seconds: 2), () {
                      heroProvider.loading = false;
                    });
                  });
                },
                child: Container(
                  width: 150,
                  height: 30,
                  decoration: BoxDecoration(
                    color: cOrange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Retry",
                      style: whiteTextStyle.copyWith(
                          fontSize: 14, fontWeight: bold),
                      textScaleFactor: context.textscale,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }

      return Container(
        width: context.width * 1,
        height: context.height * 1,
        margin: const EdgeInsets.only(left: 24, right: 24),
        child: heroProvider.loading
            ? Center(
                child: CircularProgressIndicator(
                  color: cOrange,
                ),
              )
            : heroProvider.statusGetHero == "Berhasil"
                ? SingleChildScrollView(
                    child: StaggeredGrid.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 20,
                      children: filteredHeroes
                          .map((item) => StaggeredGridTile.count(
                                crossAxisCellCount: 2,
                                mainAxisCellCount: 1.2,
                                child: GestureDetector(
                                  onTap: () {
                                    context.push(DetailPage(item: item));
                                  },
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        width: context.width * 1,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: FadeInImage(
                                            placeholder: const AssetImage(
                                                'assets/loading.png'),
                                            image: NetworkImage(
                                                "$baseUrl${item['img']}"),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          height: 40,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                            color: cBlack.withOpacity(0.45),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 110,
                                                    child: Text(
                                                      item['localized_name'],
                                                      style: whiteTextStyle
                                                          .copyWith(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  semiBold),
                                                      textScaleFactor:
                                                          context.textscale,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                    child: Text(
                                                      item['roles']
                                                          .toString()
                                                          .replaceAll("[", "")
                                                          .replaceAll("]", ""),
                                                      style: greyTextStyle
                                                          .copyWith(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  regular),
                                                      textScaleFactor:
                                                          context.textscale,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 10,
                                                    height: 10,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: item['primary_attr'] ==
                                                              "str"
                                                          ? cOrange
                                                          : item['primary_attr'] ==
                                                                  "agi"
                                                              ? cGreen
                                                              : item['primary_attr'] ==
                                                                      "int"
                                                                  ? cBlue
                                                                  : cWhite, // Ganti dengan warna yang Anda inginkan
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    item['primary_attr']
                                                        .toUpperCase(),
                                                    style:
                                                        whiteTextStyle.copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                regular),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  )
                : sectionContentError(),
      );
    }

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTop(),
            sectionFilterChip(),
            sectionSearch(),
            Expanded(child: sectionContent()),
          ],
        ),
      ),
    );
  }
}
