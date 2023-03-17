package org.zerock.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.io.File;
import java.util.UUID;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

/**
 * Handles requests for the application home page.
 */
@Controller
public class UploadController {
   
   private static final Logger logger = LoggerFactory.getLogger(UploadController.class);
   
   @Resource(name = "uploadPath")
   private String uploadPath;

   private String originalName;
   
   @RequestMapping(value = "/uploadForm", method = RequestMethod.GET)
   public void uploadForm() {
      
   }
   @RequestMapping(value = "/uploadForm", method = RequestMethod.POST)
   public void uploadForm(MultipartFile file, Model model)throws Exception{
      logger.info("originalName: " + file.getOriginalFilename());
      logger.info("size: " + file.getSize());
      logger.info("contentType: " + file.getContentType());
      
      String savedName = uploadFile(file.getOriginalFilename(), file.getBytes());
      
      model.addAttribute("savedName", savedName);
   }
   
   @RequestMapping(value = "/uploadAjax", method = RequestMethod.GET)
   private String uploadFile(String originalFilename, byte[] fileData) throws Exception{
      UUID uid = UUID.randomUUID();
      String savedName = uid.toString() + "_" + originalName;
      File target = new File (uploadPath, savedName);
      FileCopyUtils.copy(fileData, target);
      return savedName;
   }
   
}