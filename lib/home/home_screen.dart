import 'package:demologin/detail_screen/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:demologin/home/nav.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:demologin/home/image_model.dart';
import 'package:demologin/home/image_view_model.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<ImageModel> _imagesModels = [];
  late ImageViewModel _imageViewModel;

  @override
  void initState() {
    super.initState();
    _imageViewModel = ImageViewModel();
    _imageViewModel.loadImages().then((_) {
      setState(() {
        _imagesModels.addAll(_imageViewModel.images);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Navigate(),
        appBar: _appBar(),
        body: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.cyan[50],
          child: Stack(children: [_girdView(), _buttonAdd()]),
        ));
  }

  _appBar() {
    return AppBar(
      flexibleSpace: const Padding(
        padding: EdgeInsets.only(top: 0, left: 30),
        child: Row(
          children: [
            SizedBox(
              width: 30,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("Image", style: TextStyle(fontSize: 20)))
          ],
        ),
      ),
      backgroundColor: Colors.cyan,
    );
  }

  _buttonAdd() {
    return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 16, bottom: 16),
          child: FloatingActionButton(
              onPressed: () {
                _requestPermissionAndPickImage();
              },
              backgroundColor: Colors.lightBlue,
              child: const Icon(
                CupertinoIcons.add,
                color: Colors.white,
              )),
        ));
  }

  _girdView() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.95,
        ),
        itemCount: _imagesModels.length,
        itemBuilder: (context, index) {
          return _itemBuilder(index);
        },
      ),
    );
  }

  _itemBuilder(index) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0, 2),
            blurRadius: 4.0,
          )
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                InkWell(
                    onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                        imageModel: _imagesModels[index],
                                      )))
                        },
                    child: Image.file(
                      File(_imagesModels[index].path),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )),
                Container(
                    padding: const EdgeInsets.all(5),
                    width: 25,
                    height: 25,
                    child: GestureDetector(
                      onTap: () => {deleteImage(_imagesModels[index])},
                      child: const Center(
                          child: Icon(
                        CupertinoIcons.delete_simple,
                        size: 15,
                      )),
                    ))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.bottomLeft,
                  child: InkWell(
                    onTap: () =>
                        {showDialogEditName(context, _imagesModels[index])},
                    child: const Icon(
                      CupertinoIcons.pen,
                      size: 15,
                    ),
                  )),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: SelectableText(
                    _imagesModels[index].name,
                    style: const TextStyle(fontSize: 10),
                  )),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Text(('${_imagesModels[index].size ~/ 1024} KB'),
                      style: const TextStyle(fontSize: 10)))
            ],
          )
        ],
      ),
    );
  }

  void showDialogEditName(BuildContext context, ImageModel imageModel) {
    final TextEditingController controller =
        TextEditingController(text: imageModel.name);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text("Edit Image name",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                  const SizedBox(height: 20.0),
                  TextField(
                      controller: controller,
                      style: const TextStyle(color: Colors.grey),
                      decoration: const InputDecoration(
                          hintText: "Enter new name",
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26)))),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 100, // Set the desired width for both buttons
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 100, // Set the same width as the Cancel button
                        child: ElevatedButton(
                          onPressed: () {
                            imageModel.name = controller.text;
                            editNameImage(imageModel);
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            "Oke",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  void editNameImage(ImageModel imageModel) {
    setState(() {
      _imageViewModel.editNameImage(imageModel);
    });
  }

  void deleteImage(ImageModel imageModel) {
    setState(() {
      _imageViewModel.deleteImage(imageModel);
    });
  }

  Future<void> _requestPermissionAndPickImage() async {
    if (Platform.isAndroid) {
      final plugin = DeviceInfoPlugin();
      final android = await plugin.androidInfo;

      PermissionStatus status;
      if (android.version.sdkInt >= 33) {
        // Request permission for photos
        status = await Permission.photos.status;
        if (status.isDenied) {
          status = await Permission.photos.request();
        }
      } else {
        // Request permission for storage
        status = await Permission.storage.status;
        if (status.isDenied) {
          status = await Permission.storage.request();
        }
      }

      if (status.isGranted) {
        final XFile? image =
            await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          final File file = File(image.path);
          final int size = await file.length();
          int currentId = _imagesModels.length;
          final ImageModel imageModel = ImageModel(
              id: currentId++,
              name: image.name,
              path: image.path,
              size: size.toDouble());
          setState(() {
            _imageViewModel.addImage(imageModel);
            _imagesModels.add(imageModel);
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Permission denied. Cannot pick images.')),
        );
      }
    }
  }
}
