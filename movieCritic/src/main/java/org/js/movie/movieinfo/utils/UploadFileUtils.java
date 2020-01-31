package org.js.movie.movieinfo.utils;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;

import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;

@Slf4j
public class UploadFileUtils {
  
	static final int THUMB_WIDTH = 300;
	static final int THUMB_HEIGHT = 300;
	 
	public static String fileUpload(String uploadPath, String fileName, byte[] fileData, String ymdPath) 
					throws Exception {
	
	  UUID uid = UUID.randomUUID();
	  
	  String newFileName = uid + "_" + fileName;
	  String imgPath = uploadPath + ymdPath;  //로그 확인 결과 \ 하나가 겹침 servlet-ctx.xml에서 맨 마지막 \ 제거함
	   
	  log.info("imgPath : " + imgPath);
	  log.info("newFileName: " + newFileName);
	  
	  File target = new File(imgPath, newFileName);
	  
	  log.info("File target : " + target);
	  FileCopyUtils.copy(fileData, target);
	  
	  String thumbFileName = "s_" + newFileName;
	  log.info("path 확인: " + imgPath + File.separator + newFileName);
	  File image = new File(imgPath + File.separator + newFileName);
	
	  File thumbnail = new File(imgPath + File.separator + "s" + File.separator + thumbFileName);
	
	  if (image.exists()) {
	   thumbnail.getParentFile().mkdirs();
	   Thumbnails.of(image).size(THUMB_WIDTH, THUMB_HEIGHT).toFile(thumbnail);
	  }
	  return newFileName;
	 }
	
	 public static String calcPath(String uploadPath) {
		 
		 log.info("uploadPath :" + uploadPath);
	  Calendar cal = Calendar.getInstance();
	  log.info(" 오늘 날짜 :" +cal);
	  String yearPath = File.separator + cal.get(Calendar.YEAR);
	  String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
	  String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
	  log.info("날짜 path.. :" + yearPath + monthPath + datePath);
	  
	  log.info("폴더 만들기 전");
	  makeDir(uploadPath, yearPath, monthPath, datePath);  //폴더 만듬
	  makeDir(uploadPath, yearPath, monthPath, datePath + "\\s");
	  log.info("폴더 만든 후");
	  return datePath;
	 }
	
	 
	 
	 private static void makeDir(String uploadPath, String... paths) {
	
		 if (new File(paths[paths.length - 1]).exists()) {
		  
		  return; 
		  }
	
	  for (String path : paths) {
	   File dirPath = new File(uploadPath + path);
	   log.info("dirPath 확인 : " + dirPath);
	
	   if (!dirPath.exists()) {
	    dirPath.mkdir();
	   }
	  }
	 }
}