<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String apiURL = request.getParameter("api");

    if (apiURL != null && !apiURL.isEmpty()) {
        try {
            URL url = new URL(apiURL);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod(request.getMethod());
            
            // Pass headers
            java.util.Enumeration<String> headers = request.getHeaderNames();
            while (headers.hasMoreElements()) {
                String headerName = headers.nextElement();
                if(!headerName.equalsIgnoreCase("host") && !headerName.equalsIgnoreCase("connection")) {
                    connection.setRequestProperty(headerName, request.getHeader(headerName));
                }
            }

            // Pass request body if POST
            if (request.getMethod().equalsIgnoreCase("POST") || request.getMethod().equalsIgnoreCase("PUT")) {
                connection.setDoOutput(true);
                InputStream is = request.getInputStream();
                OutputStream os = connection.getOutputStream();
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = is.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }
                os.flush();
                os.close();
                is.close();
            }

            int responseCode = connection.getResponseCode();
            response.setStatus(responseCode);

            // Pass response headers
            for (java.util.Map.Entry<String, java.util.List<String>> header : connection.getHeaderFields().entrySet()) {
                if (header.getKey() != null && !header.getKey().equalsIgnoreCase("Transfer-Encoding")) {
                    for (String value : header.getValue()) {
                        response.addHeader(header.getKey(), value);
                    }
                }
            }

            // Copy response body
            InputStream is = responseCode >= 400 ? connection.getErrorStream() : connection.getInputStream();
            if(is != null) {
                OutputStream os = response.getOutputStream();
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = is.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }
                os.flush();
                os.close();
                is.close();
            }

        } catch (Exception e) {
            response.setStatus(500);
            out.print("{\"error\":\"Proxy Request Failed: " + e.getMessage() + "\"}");
        }
    } else {
        response.setStatus(400);
        out.print("{\"error\":\"API parameter is missing\"}");
    }
%>
