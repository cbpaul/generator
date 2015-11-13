package ${basepackage}.utils;

import java.security.MessageDigest;

public class MD5Utils {
	
	
	
	
	
	
//	
//	fed1e048c4684d968c70d6e0cb90786acdf59b7aapp_key01f20f05fa0998fba85a62e4907908baa01e3a72birthday2013-02-26emailblairwu@163.comhobby电玩,音乐,郊游/户外,运动,教育/亲子nick哈儿677sex0user_id5800version1.0fed1e048c4684d968c70d6e0cb90786acdf59b7a
//	我的加密：caa5424788bb69e0381bb525efdcabd6
//	传入的加密：50ec2e3867160e216f6ae7fb2ba76f18
	
	

	// 测试主函数
	public static void main(String args[]) {
		String s = new String("ddaa哈儿app_keyfsddd");
		System.out.println("原始：" + s);
		System.out.println("MD5后：" + MD5(s));
	}
	
	
	
	
	/**
	 * MD5加码。32位小写
	 * */ 
	public static String MD5(String plainText) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(plainText.getBytes("utf-8"));
			byte b[] = md.digest();
			int i;
			StringBuffer buf = new StringBuffer("");
			for (int offset = 0; offset < b.length; offset++) {
				i = b[offset];
				if (i < 0)
					i += 256;
				if (i < 16)
					buf.append("0");
				buf.append(Integer.toHexString(i));
			}
			return  buf.toString();
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}
	
	
	
	/**
	 * 
	 * 可逆的加密算法
	 * */ 
	public static String KL(String inStr) {
		char[] a = inStr.toCharArray();
		for (int i = 0; i < a.length; i++) {
			a[i] = (char) (a[i] ^ 't');
		}
		String s = new String(a);
		return s;
	}

	
	/**
	 * 
	 * 加密后解密
	 * */ 
	public static String JM(String inStr) {
		char[] a = inStr.toCharArray();
		for (int i = 0; i < a.length; i++) {
			a[i] = (char) (a[i] ^ 't');
		}
		String k = new String(a);
		return k;
	}

	
	
	
	
	
	
	
	
	
	
	
}
