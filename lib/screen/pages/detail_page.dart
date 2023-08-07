part of './pages.dart';

class DetailPage extends StatefulWidget {
  final dynamic item;
  const DetailPage({super.key, required this.item});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List similarHeroes = [];
  void findSimilarHeroes() {
    var heroProvider = Provider.of<HeroProvider>(context, listen: false);
    similarHeroes.clear();
    for (var hero in heroProvider.dataHeroes) {
      List<String> roles = List<String>.from(hero['roles']);
      int matchingRolesCount = 0;

      for (var role in roles) {
        if (widget.item['roles'].contains(role) &&
            widget.item['localized_name'] != hero['localized_name']) {
          matchingRolesCount++;
        }
      }

      if (matchingRolesCount >= widget.item['roles'].length &&
          widget.item['localized_name'] != hero['localized_name']) {
        similarHeroes.add(hero);
      }
    }
    print("isi heroes similar: $similarHeroes");
    print("isi heroes similar: ${similarHeroes.length}");
  }

  @override
  void initState() {
    super.initState();
    findSimilarHeroes();
  }

  @override
  Widget build(BuildContext context) {
    Widget sectionTop() {
      return Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: context.width * 1,
              height: 194,
              margin: const EdgeInsets.only(bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: FadeInImage(
                  fit: BoxFit.fill,
                  placeholder: const AssetImage('assets/loading.png'),
                  image: NetworkImage("$baseUrl${widget.item['img']}"),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: cOrange.withOpacity(0.75),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.item['roles']
                    .toString()
                    .replaceAll("[", "")
                    .replaceAll("]", ""),
                style:
                    whiteTextStyle.copyWith(fontSize: 14, fontWeight: medium),
                textScaleFactor: context.textscale,
              ),
            )
          ],
        ),
      );
    }

    Widget sectionContent() {
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.item['localized_name'],
              style:
                  whiteTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
              textScaleFactor: context.textscale,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Hero Stats",
              style: customTextStyle.copyWith(
                  fontSize: 14, fontWeight: medium, color: cOrange),
              textScaleFactor: context.textscale,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: context.width * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Primary Attr",
                        style: greyTextStyle.copyWith(
                            fontSize: 12, fontWeight: regular),
                        textScaleFactor: context.textscale,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.item['primary_attr'].toString().toUpperCase(),
                        style: whiteTextStyle.copyWith(
                            fontSize: 14, fontWeight: semiBold),
                        textScaleFactor: context.textscale,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Base Health",
                        style: greyTextStyle.copyWith(
                            fontSize: 12, fontWeight: regular),
                        textScaleFactor: context.textscale,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.item['base_health'].toString(),
                        style: whiteTextStyle.copyWith(
                            fontSize: 14, fontWeight: semiBold),
                        textScaleFactor: context.textscale,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Attack Range",
                        style: greyTextStyle.copyWith(
                            fontSize: 12, fontWeight: regular),
                        textScaleFactor: context.textscale,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.item['attack_range'].toString(),
                        style: whiteTextStyle.copyWith(
                            fontSize: 14, fontWeight: semiBold),
                        textScaleFactor: context.textscale,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Base Str",
                        style: greyTextStyle.copyWith(
                            fontSize: 12, fontWeight: regular),
                        textScaleFactor: context.textscale,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/str.png',
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.item['base_str'].toString(),
                            style: whiteTextStyle.copyWith(
                                fontSize: 14, fontWeight: semiBold),
                            textScaleFactor: context.textscale,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Base Agi",
                        style: greyTextStyle.copyWith(
                            fontSize: 12, fontWeight: regular),
                        textScaleFactor: context.textscale,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/agi.png',
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.item['base_agi'].toString(),
                            style: whiteTextStyle.copyWith(
                                fontSize: 14, fontWeight: semiBold),
                            textScaleFactor: context.textscale,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Base Int",
                        style: greyTextStyle.copyWith(
                            fontSize: 12, fontWeight: regular),
                        textScaleFactor: context.textscale,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/int.png',
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.item['base_int'].toString(),
                            style: whiteTextStyle.copyWith(
                                fontSize: 14, fontWeight: semiBold),
                            textScaleFactor: context.textscale,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Attack Type",
                        style: greyTextStyle.copyWith(
                            fontSize: 12, fontWeight: regular),
                        textScaleFactor: context.textscale,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.item['attack_type'].toString(),
                        style: whiteTextStyle.copyWith(
                            fontSize: 14, fontWeight: semiBold),
                        textScaleFactor: context.textscale,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Base Mana",
                        style: greyTextStyle.copyWith(
                            fontSize: 12, fontWeight: regular),
                        textScaleFactor: context.textscale,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.item['base_mana'].toString(),
                        style: whiteTextStyle.copyWith(
                            fontSize: 14, fontWeight: semiBold),
                        textScaleFactor: context.textscale,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Move Speed",
                        style: greyTextStyle.copyWith(
                            fontSize: 12, fontWeight: regular),
                        textScaleFactor: context.textscale,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.item['move_speed'].toString(),
                        style: whiteTextStyle.copyWith(
                            fontSize: 14, fontWeight: semiBold),
                        textScaleFactor: context.textscale,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Similar Heroes",
                        style: greyTextStyle.copyWith(
                            fontSize: 12, fontWeight: regular),
                        textScaleFactor: context.textscale,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 100,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: similarHeroes
                                .map((similarItem) => Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 60,
                                            height: 60,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                              child: FadeInImage(
                                                fit: BoxFit.fill,
                                                placeholder: const AssetImage(
                                                    'assets/loading.png'),
                                                image: NetworkImage(
                                                    "$baseUrl${similarItem['img']}"),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: 65,
                                            child: Text(
                                              similarItem['localized_name'],
                                              style: whiteTextStyle.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: medium),
                                              textScaleFactor:
                                                  context.textscale,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 24,
            color: cWhite,
          ),
        ),
        title: Image.network(
          "$baseUrl${widget.item['icon']}",
          width: 32,
          height: 32,
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 30, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTop(),
            sectionContent(),
          ],
        ),
      ),
    );
  }
}
