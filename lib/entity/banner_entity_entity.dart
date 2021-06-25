import 'package:flutter_common_lib/generated/json/base/json_convert_content.dart';

class BannerEntity with JsonConvert<BannerEntity> {
	List<BannerEntityData> data;
	int errorCode;
	String errorMsg;
}

class BannerEntityData with JsonConvert<BannerEntityData> {
	String desc;
	int id;
	String imagePath;
	int isVisible;
	int order;
	String title;
	int type;
	String url;
}
