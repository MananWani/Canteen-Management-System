package com.crimsonlogic.cms.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * @author abdulmanan
 *
 */
@MultipartConfig
@WebServlet("/AddImageServlet")
public class AddImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int MAX_FILE_SIZE = 30 * 1024;   
    

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("In do post method of Add Image servlet.");
		Part file=request.getPart("image");
		if (file.getSize() > MAX_FILE_SIZE) {
            response.sendRedirect("admin/additem.jsp?error=maxSize");
            return;
        }
		
		String imageFileName=file.getSubmittedFileName();  
		System.out.println("Selected Image File Name : "+imageFileName);
		String uploadPath="E:\\Milestone 1\\CanteenManagementSystem\\WebContent\\images\\"+imageFileName;  
		System.out.println("Upload Path : "+uploadPath);
		
		try
		{
		
		FileOutputStream fos=new FileOutputStream(uploadPath);
		InputStream is=file.getInputStream();
		
		byte[] data=new byte[is.available()];
		is.read(data);
		fos.write(data);
		is.close();
		fos.close();
		
		response.sendRedirect("admin/additem.jsp?success=imageAdded");
		}
		
		catch(IOException e)
		{
			System.out.println(e.getMessage());
		}
	}

}

