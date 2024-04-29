## 雾霾探测系统设计

### 一、任务
雾霾的频繁出现已严重的影响到人们的出行，对人们的健康造成了重大影响。因此，能在出行前查看雾霾的指数，并采取相应的措施来把雾霾的影响降到最小就显得尤为重要。本系统在分析多种因子的影响下，设计一款手机端雾霾app探测系统。

### 二、要求
1. 定位功能：将定位城市保存在服务器端，并同时显示在客户端。
	定位使用flutter的geolocator实现
	不过定位的城市的数据只保存在客户端里边了
2. 界面设计：包含显示天气和空气质量指数的动态显示。
	天气和空气质量都用文字显示了，动画啥的没做，略有点单调
3. 天气详情和空气质量指数：定位后的城市在服务器端获取后，传给天气详情界面，通过所传城市用百度天气api获取对应的天气详情和空气质量指数，并保存在服务器端。
	数据来源使用了OpenWeatherAPI，数据保存在服务端倒是把代码写好了，就是写客户端的时候没用上
4. 完成报告。
5. 界面元素包括：天气和空气质量指数，温度湿度折线图
	折线图只做了空气质量的显示，因为api直接返回的数据太多了所以横轴直接用数据编号没用时间日期

## 方案设计与论证
完成要求1-4
### 架构
服务端go+gin+gorm实现，客户端flutter+
  flutter_map: ^4.0.0
  latlong2: ^0.8.2
  http: ^0.13.6
  provider: ^6.1.2
  shared_preferences: ^2.2.2
  charts_flutter: ^0.12.0
  geolocator: ^11.0.0
实现，为典型的C/S架构，客户端负责发送经纬度数据，服务端负责根据经纬度数据，从OpenWeather服务器获取天气信息和空气质量信息。

## 结果与分析
1. 定位功能
	如上，使用flutter的geoLocator库实现
	
```dart
	            FloatingActionButton(
              onPressed: () async {
                Position position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high);
                setState(() {
                  selectedPosition =
                      LatLng(position.latitude, position.longitude);
                  selectedMarker = Marker(
                    point: selectedPosition,
                    builder: (context) => const Icon(
                      Icons.location_on,
                      size: 50,
                      color: Colors.red,
                    ),
                  );
                });
              },
              child: const Icon(Icons.gps_fixed),
            ),
```

2. 界面设计
	使用MaterialDesignUI3设计，首页添加城市列表，点击首页右下角添加城市，第二屏在点击首页城市后显示点击的城市的天气详情。第三屏可以设置默认值以外的服务器url，便于调试开发。
3. 天气质量指数
	使用OpenWeather的数据，空气质量请求了历史7天的数据，天气只请求了当前的值。
4. 编码测试
	项目使用Test-Driven Develop模式开发，以单元测试为开发指引，提升开发效率的同时保证了代码质量。
	兼容性方面，Flutter可以生成Windows,Linux,Android,iOS,Web和MacOS这六个端的目标软件，具备良好的跨平台能力。服务端使用Golang作为开发语言，可以设置多种体系架构为编译目标，也有良好的兼容性。