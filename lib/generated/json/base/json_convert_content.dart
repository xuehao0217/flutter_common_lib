// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter_common_lib/entity/banner_entity_entity.dart';
import 'package:flutter_common_lib/generated/json/banner_entity_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {
			case BannerEntity:
				return bannerEntityEntityFromJson(data as BannerEntity, json) as T;
			case BannerEntityData:
				return bannerEntityDataFromJson(data as BannerEntityData, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case BannerEntity:
				return bannerEntityEntityToJson(data as BannerEntity);
			case BannerEntityData:
				return bannerEntityDataToJson(data as BannerEntityData);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (BannerEntity).toString()){
			return BannerEntity().fromJson(json);
		}	else if(type == (BannerEntityData).toString()){
			return BannerEntityData().fromJson(json);
		}	
		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(<BannerEntity>[] is M){
			return data.map<BannerEntity>((e) => BannerEntity().fromJson(e)).toList() as M;
		}	else if(<BannerEntityData>[] is M){
			return data.map<BannerEntityData>((e) => BannerEntityData().fromJson(e)).toList() as M;
		}
		throw Exception("not fond");
	}

  static M fromJsonAsT<M>(json) {
    if (json is List) {
      return _getListChildType<M>(json);
    } else {
      return _fromJsonSingle<M>(json) as M;
    }
  }
}