class Apis {
  static const String login = "http://bootcamp.cyralearnings.com/login.php";
// Arguments:
// username
// password
// Method : POST

  static const String register =
      "http://bootcamp.cyralearnings.com/registration.php(username,password)";
// Arguments:
// username
// name
// phone
// address
// password
// Method : POST

  static const String getCategories =
      "http://bootcamp.cyralearnings.com/getcategories.php(view_category.php)";
// Arguments:catid
// Method : POST

  static const String getCategoryProducts =
      "http://bootcamp.cyralearnings.com/get_category_products.php";
// Arguments:catid
// Method : POST

  static const String viewOfferproducts =
      ' http://bootcamp.cyralearnings.com/view_offerproducts.php';
// Method : POST

  static const String order = 'http://bootcamp.cyralearnings.com/order.php';
//

  static const String getOrderDetails =
      'http://bootcamp.cyralearnings.com/get_orderdetails.php';
// Arguments:username
// Method : POST

  static const String getUser =
      'http://bootcamp.cyralearnings.com/get_user.php';
// Arguments:username
// Method : POST
}
