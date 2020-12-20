<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Tool</title>
  <script src="/js/jquery-1.12.3.min.js"></script>
  <script src="js/bootstrap-notify.min.js"></script>
  <script src="/js/crypto-js.js"></script>
  <script>
  	function login() {
  		var encrypted1 = $("#encrypted1").val();
  		var encrypted2 = $("#encrypted2").val();
  		if(encrypted1!=undefined && encrypted2!=undefined && encrypted1!="" && encrypted2!=""){
  			encrypted1 = CryptoJS.SHA1(encrypted1).toString();
  	  		encrypted2 = CryptoJS.SHA1(encrypted2).toString();
  			$.post("/CMS",{"encrypted1":encrypted1,"encrypted2":encrypted2})
  					.done(function(){
  						window.location.reload();
  					})
  		  			.fail(function(xhr, status, error) {
	  		  			$.notify({
		   					title: '<strong>Invalid username/password!</strong>',
		   				},{
		   					type: 'danger',
		   				    animate: {
		   						enter: 'animated fadeInRight',
		   						exit: 'animated fadeOutRight'
		   					},
		   					placement: {
		   						from: 'top'
		   					}
		   				});
    				});
  		}
	}
  </script>
  <style>
	.login-page {
	  width: 360px;
	  padding: 8% 0 0;
	  margin: auto;
	}
	.form {
	  position: relative;
	  background: #ffffff;
	  max-width: 360px;
	  margin: 0 auto 100px;
	  padding: 45px;
	  text-align: center;
	}
	.form input {
	  font-family: "Roboto", sans-serif;
	  outline: 0;
	  background: #f2f2f2;
	  width: 100%;
	  border: 0;
	  margin: 0 0 15px;
	  padding: 15px;
	  box-sizing: border-box;
	  font-size: 14px;
	}
	.form button {
	  font-family: "Roboto", sans-serif;
	  outline: 0;
	  background: #808080;
	  width: 100%;
	  border: 0;
	  padding: 15px;
	  color: #ffffff;
	  font-size: 14px;
	}
	
	body {
	  background: #808080;
	}
	
	.topnav {
	  overflow: hidden;
	  background-color: #9a004e;
	}
	.topnav a {
	  display: block;
	  color: #f2f2f2;
	  text-align: center;
	  padding: 14px 16px;
	  text-decoration: none;
	  font-size: 25px;
	  border-right: solid 1px #fff;
	}
	.topnav a:hover {
	  background-color: #ddd;
	  color: black;
	}
	.topnav a.active {
	  background-color: black;
	  color: white;
	}
	ul {
	  list-style-type: none;
	  margin: 0;
	  padding: 0;
	  width: 200px;
	  background-color: black;
	}
	li a {
	  display: block;
	  color: white;
	  padding: 8px 16px;
	  text-decoration: none;
	  border-bottom: solid 1px #fff;
	  font-size: 25px;
	}
	.content:hover {
	  background-color: maroon;
	  color: white;
	}
	#left {
	  position: relative;
	  left: 0;
	  width: 200px;
	}
	#right {
	  position: relative;
	  right: 0;
	  width: 60%;
	}
	.search_drop_down {
	  margin: 10px 0px;
	}
	.select-hidden {
	  display: none;
	  visibility: hidden;
	  padding-right: 10px;
	}
	.select {
	  cursor: pointer;
	  display: inline-block;
	  position: relative;
	  font-size: 16px;
	  color: #000;
	  width: 190px;
	  height: 40px;
	}
	.select-styled {
	  position: relative;
	  top: 0;
	  right: 0;
	  bottom: 0;
	  left: 0;
	  border-color: #fff;
	  background-color: #fff;
	  padding: 8px 15px;
	  -moz-transition: all 0.2s ease-in;
	  -o-transition: all 0.2s ease-in;
	  -webkit-transition: all 0.2s ease-in;
	  transition: all 0.2s ease-in;
	}
	.select-styled:after {
	  content: "";
	  width: 0;
	  height: 0;
	  border: 7px solid transparent;
	  border-color: #fff transparent transparent transparent;
	  position: absolute;
	  top: 16px;
	  right: 10px;
	}
	.select-styled:hover {
	  background-color: rgba(154, 0, 78, 0.32);
	}
	.select-styled:active,
	.select-styled.active {
	  background-color: rgba(154, 0, 78, 0.32);
	}
	.select-styled:active:after,
	.select-styled.active:after {
	  top: 9px;
	  border-color: transparent transparent #fff transparent;
	}
	.select-options {
	  display: none;
	  position: absolute;
	  top: 100%;
	  right: 0;
	  left: 0;
	  z-index: 999;
	  margin: 0;
	  padding: 0;
	  list-style: none;
	  background-color: #ab3326;
	}
	.select-options li {
	  margin: 0;
	  padding: 12px 0;
	  text-indent: 15px;
	  border-top: 1px solid #962d22;
	  -moz-transition: all 0.15s ease-in;
	  -o-transition: all 0.15s ease-in;
	  -webkit-transition: all 0.15s ease-in;
	  transition: all 0.15s ease-in;
	}
	.select-options li:hover {
	  color: #c0392b;
	  background: #fff;
	}
	.select-options li[rel="hide"] {
	  display: none;
	}
	.search {
	  width: 30%;
	  border: 1px solid #ccc;
	  float: right;
	  /* height: 30px; */
	
	  padding: 10px;
	}
	.product_box {
	  background-color: #fff;
	  padding: 5px;
	  display: flex;
	  align-items: center;
	  border-bottom: 1px black solid;
	  height: 150px;
	}
	.single_1 {
	  width: 25%;
	  height: 100%;
	  margin: 2px;
	}
	.single_2 {
	  width: 25%;
	  height: 100%;
	  text-align: center;
	  display: flex;
	  align-items: center;
	}
	.single_3 {
	  width: 25%;
	  height: 100%;
	  text-align: center;
	  display: flex;
	  align-items: center;
	}
	.single_4 {
	  width: 25%;
	  height: 100%;
	  display: flex;
	  align-items: center;
	}
	.single_4 img {
	  margin-left: auto;
	  margin-right: auto;
	  display: block;
	  width: 80px;
	  height: 80px;
	}
	.single_4 input {
	  margin-left: auto;
	  margin-right: auto;
	  display: block;
	  width: 80px;
	  height: 80px;
	}
	.product_box label {
	  font-weight: 700;
	}
	.single_3 input {
	  width: 50px;
	  font-weight: 700;
	  text-align: center;
	  padding: 2px;
	  margin: 10px;
	}
	.quantity_sec {
	  margin-left: auto;
	  margin-right: auto;
	  display: block;
	}
	.container {
	  width: 100%;
	  height: 100%;
	  position: relative;
	}
	.container img {
	  width: 100%;
	  object-fit: contain;
	  height: 100%;
	}
	.prod_desc {
	  margin-left: auto;
	  margin-right: auto;
	  display: block;
	}
	.pdt_name {
	  background-color: black;
	  color: #fff;
	  width: 100px;
	  padding: 5px;
	}
	.pdt_details_2_col {
	  margin: 10px 0px;
	  font-weight: 700;
	  font-style: italic;
	}
	.brand_name {
	  width: 50%;
	  margin-left: 10px;
	  color: #357a8c;
	}
	.brand {
	  width: 50%;
	  margin-right: 10px;
	}
	.discount {
	  float: right;
	  position: absolute;
	  left: 0px;
	  bottom: 0px;
	  z-index: 1000;
	  padding: 5px;
	  background-color: rgba(154, 0, 78, 0.73);
	  font-weight: bold;
	  width: 100%;
	  color: #000;
	}
	.discount_text {
	  position: relative;
	  display: table-cell;
	  text-align: center;
	  vertical-align: middle;
	  color: #fff;
	  font-weight: 900;
	  margin-left: 20px;
	  padding-left: 41px;
	}
	
	.discount_badge {
	  height: 25px;
	  width: 100px;
	  display: table-cell;
	  text-align: center;
	  vertical-align: middle;
	  border-radius: 10%;
	  background: #ffffff;
	  color: #da0b74;
	  font-weight: 900;
	}
  </style>
</head>
<body>
  <div class="login-page">
    <div class="form">
      <input type="text" id="encrypted1" placeholder="username" />
      <input type="password" id="encrypted2" placeholder="password" />
      <button id="login" type="button" onclick="login()">Login</button></br>
    </div>
  </div>
</body>
</html>