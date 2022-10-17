package common;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESedeKeySpec;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class DES {
	
	String key = "jsp_web_test_key_value09";	
	/*24byte des3*/
	
	public String encrypt(String data) throws Exception {
		
		if(data == null || "".equals(data)) {
			return "";
		}
		
		String result = "";
		
		//암호화 객체 생성 DES3 = DESede/ECB/PKCS5Padding / DES = DES/ECB/PKCS5Padding
		Cipher cipher = Cipher.getInstance("DESede/ECB/PKCS5Padding");
		
		DESedeKeySpec desKeySpec = new DESedeKeySpec(key.getBytes());
		
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DESede");
		
		SecretKey desKey = keyFactory.generateSecret(desKeySpec);
		
		cipher.init(Cipher.ENCRYPT_MODE, desKey);
		
		byte[] inputBytes = data.getBytes("UTF-8");
		byte[] outputBytes = cipher.doFinal(inputBytes);
		
		BASE64Encoder encoder = new BASE64Encoder();
		result = encoder.encode(outputBytes);
				
		return result;
	}
	
	public String decrypt(String data) throws Exception {
		
		if(data == null || "".equals(data)) {
			return "";
		}
		
		String result = "";
		
		Cipher cipher = Cipher.getInstance("DESede/ECB/PKCS5Padding");
		
		DESedeKeySpec desKeySpec = new DESedeKeySpec(key.getBytes());
		
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DESede");
		
		SecretKey desKey = keyFactory.generateSecret(desKeySpec);
		
		cipher.init(Cipher.DECRYPT_MODE, desKey);
		
		BASE64Decoder decoder = new BASE64Decoder();
		byte[] inputBytes = decoder.decodeBuffer(data);		
		byte[] outputBytes = cipher.doFinal(inputBytes);
		
		result = new String(outputBytes,"UTF-8");
		
		return result;
	}
	
}
