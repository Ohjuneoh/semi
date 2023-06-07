package util;

public class StringUtils {

	/**
	 * 문자열을 전달받아서 정수로 변환해서 반환한다.
	 * @param text 숫자로 구성된 문자열
	 * @return 정수값, text가 null이거나 빈 문자열이거나 숫자가 아닌 문자열이 포함되어 있으면 0이 반환된다.
	 */
	public static int stringToInt(String text) {
		return stringToInt(text, 0);
	}
	
	/**
	 * 문자열을 전달받아서 정수로 변환해서 반환한다.
	 * @param text 숫자로 구성된 문자열
	 * @param defaultValue 기본값
	 * @return 정수값, text가 null이거나 빈 문자열이거나 숫자가 아닌 문자열이 포함되어 있으면 defaultValue이 반환된다.
	 */
	public static int stringToInt(String text, int defaultValue) {
		if (text == null) {
			return defaultValue;
		}
		if (text.isBlank()) {
			return defaultValue;
		}
		
		try {
			return Integer.parseInt(text);
		} catch (NumberFormatException ex) {
			return defaultValue;
		}
	}
	
}
