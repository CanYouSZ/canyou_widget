import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// 加载缓存
/// 缓存文件大小的字符串, 携带单位(B, K, M, G, T)
Future<String> loadCache() async {
  try {
    final Directory tempDir = await getTemporaryDirectory();
    final double value = await _getTotalSizeOfFilesInDir(tempDir);
    /*tempDir.list(followLinks: false,recursive: true).listen((file){
      //打印每个缓存文件的路径
      print(file.path);
    });*/
    // print('临时目录大小: ' + value.toString());
    return _renderSize(value);
  } catch (err) {
    print('获取缓存异常: $err');
    return '0.00B';
  }
}

/// 递归方式 计算文件的大小
Future<double> _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
  double total = 0;
  try {
    if (file is File) {
      final int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      // 判断文件夹是否存在
      if (!file.existsSync()) {
        return total;
      }
      // 递归其他文件夹
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children)
        total += await _getTotalSizeOfFilesInDir(child);
      return total;
    }
    return total;
  } catch (e) {
    print('计算文件大小异常: $e');
    return total;
  }
}

Future<bool> clearCache() async {
  try {
    final Directory tempDir = await getTemporaryDirectory();
    // 删除缓存目录
    await delDir(tempDir);
    // 删除缓存成功后, 保留缓存目录
    await tempDir.create();
    return true;
  } catch (e) {
    print('清除缓存异常: $e');
    return false;
  } finally {
    // 此处隐藏加载loading
    // Toast.cancelToast();
  }
}

///递归方式删除目录
Future<FileSystemEntity?> delDir(FileSystemEntity file) async {
  try {
    if (file.existsSync()) {
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        for (final FileSystemEntity child in children) {
          await delDir(child);
        }
      }
      return await file.delete();
    }
  } catch (e) {
    print('递归删除文件目录异常: $e');
    return Future<FileSystemEntity?>.value(null);
  }
}

///格式化文件大小
String _renderSize(double value) {
  final List<String> unitArr = <String>['B', 'K', 'M', 'G', 'T'];
  int index = 0;
  // 下标不超过数组下标(最大单位T)
  while (value > 1024 && index < unitArr.length - 1) {
    index++;
    value = value / 1024;
  }
  final String size = value.toStringAsFixed(2);
  return size + unitArr[index];
}
