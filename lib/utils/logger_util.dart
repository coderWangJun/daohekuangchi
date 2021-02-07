import 'package:dh/common/constants.dart';

class LogUtil {
	static const String _TAG_DEFAULT = "###com###";

	static String tagDefault = _TAG_DEFAULT;

	static void init({String tag = _TAG_DEFAULT}) {
		tag = tag;
	}

	static void e(Object object, {String tag}) {
		_printLog(tag, '  e  ', object);
	}

	static void v(Object object, {String tag}) {
		if (Constants.isDebug) {
			_printLog(tag, '  v  ', object);
		}
	}

	static void _printLog(String tag, String stag, Object object) {
		StringBuffer sb = StringBuffer();
		sb.write((tag == null || tag.isEmpty) ? tagDefault : tag);
		sb.write(stag);
		sb.write(object);
		print(sb.toString());
	}
}