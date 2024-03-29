<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%
JSONArray cart = new JSONArray();
float total = 0;
if(request.getAttribute("cart")!=null){
	cart = (JSONArray)request.getAttribute("cart");
}
%>
<style>
.fa{
	cursor:pointer;	
}
</style>
<script>
function editCart(id){
	  var quanntitybox = $('#'+id);
	  if(!parseInt(quanntitybox.val()) || parseInt(quanntitybox.val()) < 0){
		  quanntitybox.val(100);
	  }
	  addToCart(id, '', quanntitybox.val(), true, true);
}
function updateValue(operation, id){
	  var quanntitybox = $('#'+id);
	  if(operation==='+'){
		  quanntitybox.val(parseInt(quanntitybox.val())+100);
	  }else if(operation==='-'){
		  if(quanntitybox.val()>100){
			  quanntitybox.val(parseInt(quanntitybox.val())-100);
		  }
	  }
}
</script>
<div id="cartPage" style="min-height: 1200px;">
 <!-- breadcrumb start -->
 <div class="breadcrumb-area">
     <div class="container">
         <div class="row">
             <div class="col-md-12 text-left">
                 <ul class="breadcrumb">
                     <li><a href="/home">Home</a><span> - </span></li>
                     <li class="active">shopping cart</li>
                 </ul>
             </div>
         </div>
     </div>
 </div> 
 <!-- breadcrumb end -->
 <!-- cart start -->
 <div class="cart-area">
     <div class="container">          
         <div class="row">
             <div class="col-xs-12">   
                 <div class="cart_list table-responsive" style="margin-bottom: 0;border: 0;">
                     <table class="table_cart table-bordered" style="border: 1px solid #dddddd;">
                         <thead>
                             <tr>
                                 <th class="id">#</th>
                                 <th class="product">Image</th>
                                 <th class="description">Product Name</th>
                                 <th class="quantity">Quantity</th>
                                 <th class="value">Price</th>
                                 <th class="action">Remove</th>
                             </tr>
                         </thead>
                         <tbody>
                         	<%if(cart.length()>0){
                         	for(int i=0;i<cart.length();i++){JSONObject obj = cart.getJSONObject(i);total+=Float.parseFloat(obj.get("totalPrice")+"");%>
                             <tr>
                                 <td class="id"><%=i+1%></td>
                                 <td class="product_img"><a href="#"><img alt="cart" src="<%=obj.get("path")%>" style="max-height: 200px;"></a></td>
                                 <td class="product_des">
                                     <h3><a href="#"><%=obj.get("name")%></a></h3>
                                 </td>
                                 <td class="id">
                                 	<div>
                                 		<i class="fa fa-minus p10" onclick="updateValue('-', '<%=obj.get("id")%>');editCart('<%=obj.get("id")%>');" aria-hidden="true"></i>
                                 		<input type="text" id="<%=obj.get("id")%>" onblur="editCart('<%=obj.get("id")%>');" style="width:50px" class="noselect" value="<%=obj.get("count")%>"></input>
                                 		<i class="fa fa-plus p10" aria-hidden="true" onclick="updateValue('+', '<%=obj.get("id")%>');editCart('<%=obj.get("id")%>');"></i>
                                 	</div>
                                 </td>
                                 <td class="p_value">Rs. <%=obj.get("totalPrice")%></td>
                                 <td class="p_action">
                                     <a onclick="removeFromCart('<%=obj.get("id")%>','<%=obj.get("name")%>');"><i class="fa fa-trash"></i></a>
                                 </td>
                             </tr>
                            <%}}else{%>
                             <tr>
                             	<td colspan="6" style="padding: 2%;">No items in your cart</td>
                             </tr>
                            <%} %>
                         </tbody>
                     </table>
                 </div>
             </div>
         </div>
         <div class="row">
             <div class="col-lg-5 col-md-4 col-sm-12" style="width: 235px;float: left;">           
                 <a href="/homepage" class="continue-shopping" style="margin: 0;">continue shopping</a>
             </div>   
             <%if(cart.length()>0){%> 
             <div class="col-lg-7 col-md-8 col-sm-12" style="float:right;width: 330px;">      
                 <div class="total text-right" style="padding: 28px 30px;margin-top: 0;">
                     <h2>subtotal <span>Rs. <%=Math.round(total*100.0)/100.0%></span></h2>
                     <h2 class="strong">grandtotal <span>Rs. <%=Math.round(total*100.0)/100.0%></span></h2>
                     <a class="continue-shopping" id="go" rel="leanModal" onclick="showPopup();">Proceed to Enquire</a>
                 </div>
             </div>    
             <%}%>
         </div>
         
         
         <div id="proceedToEnquirePopUp">
         	  <a class="fa fa-close" style="float: right;margin-right: 8px;margin-top: 6px;" onclick="closePopup();"></a>
              <div class="proceedToEnquireClass">
                  <div class="section-heading">
                      <h3>Please fill in to proceed</h3>
                  </div>  
                  <div class="contact-form">
                      <div class="leave-a-comment">
                          <div class="leave_comment">
                              <form action="mail.php" method="post">
                                  <div class="name_email_form clearfix">
                                      <div class="left_comment">
                                          <input type="text" name="name" placeholder="Name">
                                      </div>
                                      <div class="left_comment">
                                          <input type="email" name="email" placeholder="Email">
                                      </div>
                                      <div class="left_comment">
                                          <input type="tel" name="number" placeholder="Mobile Number">
                                      </div>
                                      <div class="left_comment">
                                          <a class="continue-shopping" onclick="proceedToEnquire();"><span class="loader" style="float: left;"></span><span id="processText" style="line-height: 24px;">Proceed</span></a>
                                      </div>
                                      <div class="orderSuccess" style="display:none;padding-bottom: 60px;">
                                          <p style="color: #303030;font-size: 18px;">Your order has been placed successfully.<br/>Check your email for order details.</p>
                                      </div>
                                      <div class="orderSuccess" style="display:none;">
                                          <a class="continue-shopping" href="/homepage">OK</a>
                                      </div>
                                  </div>    
                              </form>
                          </div>
                      </div>
                  </div>
              </div>    
		</div>
         
     </div>
 </div>
 </div>
 <div id="backgroundDiv"></div>