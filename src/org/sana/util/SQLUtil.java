//$Id$
package org.sana.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.json.JSONArray;
import org.json.JSONObject;
import org.sana.tables.PRODUCTS;

public class SQLUtil {
	private final static Logger LOGGER = Logger.getLogger(SQLUtil.class.getName());

	public static boolean initDB() throws Exception {
		Connection con = null;
		Boolean result = Boolean.FALSE;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sana?characterEncoding=utf8", "root", "SanaDB#2020#Admin");
//			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sana","root","");
			Statement smt = con.createStatement();
			result = Boolean.TRUE;
		} catch (Exception e1) {
			LOGGER.log(Level.SEVERE, "Exception in initDB1 method!", e1);
			String message = e1.getMessage();
			if (message != null && message.startsWith("Unknown database")) {
				try {
					con = DriverManager.getConnection("jdbc:mysql://localhost:3306?characterEncoding=utf8", "root", "SanaDB#2020#Admin");
//					con = DriverManager.getConnection("jdbc:mysql://localhost:3306/","root","");
					Statement smt = con.createStatement();
					smt.executeUpdate("create database sana");
				} catch (Exception e) {
					LOGGER.log(Level.SEVERE, "Exception in initDB2 method!", e);
					int a = 1;
				}
				result = Boolean.TRUE;
			}
		} finally {
			if (con != null) {
				con.close();
			}
		}
		return result;
	}

	public static boolean loadTable() throws Exception {
		Connection con = null;
		Boolean result = Boolean.FALSE;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sana", "root", "SanaDB#2020#Admin");
//			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sana","root","");
			Statement smt = con.createStatement();
			// smt.executeUpdate("create table products(ID varchar(50) NOT NULL UNIQUE, NAME varchar(50), PRICE FLOAT, PATH varchar(100), TYPE varchar(25), SUBCATEGORY varchar(30), ORIENTATION
			// varchar(15), DESCRIPTION text, COLOR varchar(25))");
			smt.executeUpdate("create table products(ID varchar(50), NAME varchar(50), PRICE FLOAT, PATH text, TYPE varchar(25), SUBCATEGORY varchar(30), ORIENTATION varchar(15), DESCRIPTION text, COLOR varchar(25), IMAGES text, IS_SHOW_CASE_ITEM BOOLEAN DEFAULT FALSE)");

			smt.executeUpdate("create table sliderContent(ID int NOT NULL AUTO_INCREMENT PRIMARY KEY, PATH text, TITLE1 text, TITLE2 text)");

			smt.executeUpdate("create table blogs(ID int NOT NULL AUTO_INCREMENT PRIMARY KEY, DATE text,LIKE_URL text, POST_URL text, PATH text, TITLE1 text, TITLE2 text, TITLE3 text)");
			
			smt.executeUpdate("create table orders (id text, name text, email text, mobile varchar(15), date varchar(11), cart text)");
			
			smt.executeUpdate("create table instaFeed (ID int NOT NULL AUTO_INCREMENT PRIMARY KEY, path text, postURL text)");
			
			// Insert into DB from propertyFile starts
			// String insertquery = "insert into products values(";
			// String[] productsArray = DefaultValues.productArray;
			//
			// for(String product : productsArray) {
			// JSONArray item = new JSONArray(PropertyUtil.getValue(product));
			// for(int i=0;i<item.length();i++) {
			// JSONObject itemObj = item.getJSONObject(i);
			// smt.addBatch(insertquery + "'" + itemObj.get("id")+ "'" +","+ "'" +itemObj.get("name")+ "'" +","+itemObj.get("price")+","+ "'" +itemObj.get("path")+ "'" +","+ "'" +itemObj.get("type")+
			// "'" +","+ "'" +itemObj.get("subcategory")+ "'" +","+ "'" +itemObj.get("orientation")+ "'" +","+ "'" +itemObj.get("description")+ "'"+", "+ "'" +itemObj.get("color")+ "'" +");");
			// }
			// }
			// smt.executeBatch();
			// Insert into DB from propertyFile ends
			result = Boolean.TRUE;
		} catch (SQLException e) {
			LOGGER.log(Level.SEVERE, "SQLException in loadTable method!", e);
			String message = e.getMessage();
			if (message != null && message.endsWith("already exists")) {
				// con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sana","root","SanaDB#2020#Admin");
				// con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sana","root","");
				// Statement smt = con.createStatement();
				// smt.executeUpdate("drop table products");
				result = Boolean.FALSE;
			}
		} catch (Exception e1) {
			LOGGER.log(Level.SEVERE, "Exception in loadTable method!", e1);
		} finally {
			if (con != null) {
				con.close();
			}
		}
		return result;
	}

	public static JSONArray getProductsWithCriteria(String criteria, String type) {
		Connection con = null;
		JSONArray responseArray = new JSONArray();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sana", "root", "SanaDB#2020#Admin");
//			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sana","root","");
			Statement smt = con.createStatement();
			ResultSet rs = smt.executeQuery(criteria);
			JSONObject obj = null;
			while (rs.next()) {
				obj = new JSONObject();
				if (type == null) {
					obj.put("id", rs.getString(PRODUCTS.ID));
					obj.put("name", rs.getString(PRODUCTS.NAME));
					obj.put("price", rs.getString(PRODUCTS.PRICE));
					obj.put("path", rs.getString(PRODUCTS.PATH));
					obj.put("type", rs.getString(PRODUCTS.TYPE));
					obj.put("subcategory", rs.getString(PRODUCTS.SUBCATEGORY));
					obj.put("orientation", rs.getString(PRODUCTS.ORIENTATION));
					obj.put("description", rs.getString(PRODUCTS.DESCRIPTION));
					obj.put("color", rs.getString(PRODUCTS.COLOR));
					obj.put("images", rs.getString(PRODUCTS.IMAGES));
					obj.put("isShowCaseItem", rs.getString(PRODUCTS.IS_SHOW_CASE_ITEM));
				} else if (type.equals("blogs")) {
					obj.put("id", rs.getString(PRODUCTS.ID));
					obj.put("date", rs.getString("date"));
					obj.put("likeURL", rs.getString("LIKE_URL"));
					obj.put("path", rs.getString("path"));
					obj.put("postURL", rs.getString("POST_URL"));
					obj.put("title1", rs.getString("title1"));
					obj.put("title2", rs.getString("title2"));
					obj.put("title3", rs.getString("title3"));
				} else if (type.equals("sliderContent")) {
					obj.put("id", rs.getString("id"));
					obj.put("path", rs.getString("path"));
					obj.put("title1", rs.getString("title1"));
					obj.put("title2", rs.getString("title2"));
				} else if((type.equals("instaFeed"))) {
					obj.put("id", rs.getString("id"));
					obj.put("path", rs.getString("path"));
					obj.put("postURL", rs.getString("postURL"));
				}
				responseArray.put(obj);
			}
			rs.close();
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Exception in getProductsWithCriteria method!", e);
			return new JSONArray();
		} finally {
			try {
				if (con != null) {
					con.close();
				}
			} catch (Exception e) {
				LOGGER.log(Level.SEVERE, "Exception in getProductsWithCriteria finally method!", e);
				return new JSONArray();
			}
		}
		return responseArray;
	}

	public static int getRowsCount(String criteria) {
		Connection con = null;
		int rowsCount = 0;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sana", "root", "SanaDB#2020#Admin");
//			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sana","root","");
			Statement smt = con.createStatement();
			ResultSet rs = smt.executeQuery(criteria);
			rs.next();
			rowsCount = rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Exception in getRowsCount method!", e);
			return 0;
		} finally {
			try {
				if (con != null) {
					con.close();
				}
			} catch (Exception e) {
				LOGGER.log(Level.SEVERE, "Exception in getRowsCount finally method!", e);
				return 0;
			}
		}
		return rowsCount;
	}

	public static boolean isValidUser(String username, String password) {
		Connection con = null;
		boolean result = false;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sana", "root", "SanaDB#2020#Admin");
//			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sana","root","");
			Statement smt = con.createStatement();
			ResultSet rs = smt.executeQuery("select password from sanaadmin where id=\"" + username + "\"");
			rs.next();
			result = rs.getString("password").equals(password) ? true : false;
			rs.close();
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Exception in isValidUser method!", e);
			return result;
		} finally {
			try {
				if (con != null) {
					con.close();
				}
			} catch (Exception e) {
				LOGGER.log(Level.SEVERE, "Exception in isValidUser finally method!", e);
				return result;
			}
		}
		return result;
	}

	public static boolean executeCriteria(String criteria) {
		Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sana", "root", "SanaDB#2020#Admin");
//			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sana","root","");
			Statement smt = con.createStatement();
			smt.executeUpdate(criteria);
			return true;
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Exception in executeCriteria method!", e);
			return false;
		} finally {
			try {
				if (con != null) {
					con.close();
				}
			} catch (Exception e) {
				LOGGER.log(Level.SEVERE, "Exception in executeCriteria finally method!", e);
				return false;
			}
		}
	}
	
	public static JSONArray getInvoice(String criteria) {
		Connection con = null;
		JSONArray orders = new JSONArray();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sana", "root", "SanaDB#2020#Admin");
//			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sana","root","");
			Statement smt = con.createStatement();
			ResultSet rs = smt.executeQuery(criteria);
			JSONObject obj = null;
			while (rs.next()) {
				obj = new JSONObject();
				obj.put("id", rs.getString("id"));				
				obj.put("name", rs.getString("name"));
				obj.put("email", rs.getString("email"));
				obj.put("mobile", rs.getString("mobile"));
				obj.put("date", rs.getString("date"));
				obj.put("cart", rs.getString("cart"));
				orders.put(obj);
			}
			rs.close();
			return orders;
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Exception in executeCriteria method!", e);
			return orders;
		} finally {
			try {
				if (con != null) {
					con.close();
				}
			} catch (Exception e) {
				LOGGER.log(Level.SEVERE, "Exception in executeCriteria finally method!", e);
				return orders;
			}
		}
	}
}
