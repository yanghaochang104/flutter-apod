import 'package:flutter/material.dart';

// 定義頁面筆記模式
enum NoteType {
  text,
  editable,
}

class AstroPicture extends StatefulWidget {
  final String title;
  final String pictureUrl;
  final String desc;
  final String note;
  final bool isFavorite;

  const AstroPicture(
      {super.key,
      required this.title,
      required this.pictureUrl,
      required this.desc,
      this.note = '',
      this.isFavorite = false});

  @override
  State<AstroPicture> createState() => _AstroPictureState();
}

class _AstroPictureState extends State<AstroPicture> {
  final TextEditingController _controller = TextEditingController();
  NoteType _noteType = NoteType.editable;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.note;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceScreen = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
        ),
        Stack(
          children: [
            SizedBox(
              width: deviceScreen.width,
              child: widget.pictureUrl.isNotEmpty
                  ? Image.network(widget.pictureUrl, frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) {
                        return child;
                      }
                      return AnimatedOpacity(
                        opacity: frame == null ? 0 : 1,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeOut,
                        child: child,
                      );
                    })
                  : SizedBox(
                      width: deviceScreen.width,
                      height: deviceScreen.width,
                      child: const Center(
                          child: Text(
                        '圖片載入錯誤',
                        style: TextStyle(color: Colors.red, fontSize: 30),
                      )),
                    ),
            ),
            widget.pictureUrl.isNotEmpty
                ? Positioned(
                    top: 10.0,
                    right: 10.0,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white24),
                        onPressed: () {
                          print('add to favorite');
                        },
                        child: widget.isFavorite
                            ? Icon(
                                Icons.favorite,
                                color: Colors.pink[200],
                              )
                            : const Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.white,
                              )),
                  )
                : Container(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            widget.desc,
            style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
          ),
        ),
        _noteType == NoteType.text
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(_controller.text))),
                  Container(
                      width: 100,
                      padding: const EdgeInsets.all(10),
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            fixedSize: const Size(50, 50),
                          ),
                          onPressed: () {
                            setState(() {
                              _noteType = NoteType.editable;
                            });
                          },
                          child: const Icon(Icons.edit)))
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 100),
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(10),
                            border: InputBorder.none,
                          ),
                          maxLines: 5,
                          minLines: 3,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    padding: const EdgeInsets.all(10),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        fixedSize: const Size(50, 50),
                      ),
                      onPressed: () {
                        setState(() {
                          _noteType = NoteType.text;
                        });
                      },
                      child: const Icon(
                        Icons.save,
                      ),
                    ),
                  )
                ],
              ),
      ]),
    );
  }
}
