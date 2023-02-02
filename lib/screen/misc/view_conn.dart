import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:rootnode/app/constant/font.dart';
import 'package:rootnode/data_source/remote_data_store/response/res_conn.dart';
import 'package:rootnode/helper/switch_route.dart';
import 'package:rootnode/helper/utils.dart';
import 'package:rootnode/model/conn.dart';
import 'package:rootnode/model/user.dart';
import 'package:rootnode/repository/conn_repo.dart';
import 'package:rootnode/screen/misc/view_profile.dart';
import 'package:rootnode/widgets/placeholder.dart';
import 'package:rootnode/widgets/user_card.dart';

class ViewConnScreen extends StatefulWidget {
  const ViewConnScreen({super.key, required this.user});
  final User user;

  @override
  State<ViewConnScreen> createState() => _ViewConnScreenState();
}

class _ViewConnScreenState extends State<ViewConnScreen> {
  final _connRepo = ConnRepoImpl();

  final List<Connection> conns = [];
  int currentPage = 1;

  _getInitialConns() async {
    currentPage = 1;

    MyConnsResponse? res =
        await _connRepo.getMyConns(page: currentPage, refresh: 1);
    if (res != null) {
      currentPage++;
      conns.clear();
      conns.addAll(res.conns!);
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _getInitialConns();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFF111111),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            stretchTriggerOffset: 10,
            stretch: true,
            pinned: true,
            leadingWidth: 40,
            expandedHeight: 200,
            collapsedHeight: 120,
            backgroundColor: const Color(0xFF111111),
            title: Text("Back", style: RootNodeFontStyle.header),
            flexibleSpace: FlexibleSpaceBar(
              title: const SizedBox(height: 60, child: DummySearchField()),
              titlePadding: const EdgeInsets.only(top: 10, bottom: 10),
              collapseMode: CollapseMode.parallax,
              stretchModes: const [StretchMode.zoomBackground],
              background: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    UserCard(user: widget.user),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white10, width: 2),
                      ),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runSpacing: 5,
                        spacing: 5,
                        direction: Axis.horizontal,
                        children: [
                          Text(
                              Utils.humanizeNumber(widget.user.connsCount ?? 0),
                              style: RootNodeFontStyle.body),
                          Text("CONNS", style: RootNodeFontStyle.label),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              expandedTitleScale: 1,
              centerTitle: true,
            ),
            leading: IconButton(
              icon: const Icon(Boxicons.bx_chevron_left,
                  color: Colors.white70, size: 40),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          SliverList(
            delegate: conns.isNotEmpty
                ? SliverChildBuilderDelegate(
                    (context, index) => GestureDetector(
                          onTap: () => switchRouteByPush(
                              context,
                              ProfileScreen(
                                  id: conns[index].node!.id!,
                                  user: widget.user)),
                          child: Container(
                            height: 80,
                            color: Colors.white10,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            margin: EdgeInsets.only(
                                bottom: 5, top: index == 0 ? 5 : 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                UserCard(user: conns[index].node!),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black12),
                                  child: Text(
                                      "${Utils.getTimeAgo(conns[index].createdAt!)} ago",
                                      style: RootNodeFontStyle.label),
                                )
                              ],
                            ),
                          ),
                        ),
                    childCount: conns.length)
                : SliverChildListDelegate.fixed(_generateDummyListTile()),
          ),
        ],
      ),
    );
  }

  List<Container> _generateDummyListTile() {
    return List<Container>.generate(
        6,
        (index) => Container(
              height: 80,
              color: Colors.white10,
              padding: const EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 5, top: index == 0 ? 5 : 0),
            ));
  }
}
