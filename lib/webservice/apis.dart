class Apis {
  static const String mainUrl = 'http://bootcamp.cyralearnings.com/';

  static const String login = "${mainUrl}login.php";
// Arguments: // username // password

  static const String register = "${mainUrl}registration.php";
// Arguments: // username // name // phone // address // password

  static const String getCategories = "${mainUrl}getcategories.php";
// Arguments:catid

  static const String getCategoryProducts =
      "${mainUrl}get_category_products.php";
// Arguments:catid

  static const String viewOfferproducts = '${mainUrl}view_offerproducts.php';
//

  static const String order = '${mainUrl}order.php';
//

  static const String getOrderDetails = '${mainUrl}get_orderdetails.php';
// Arguments:username

  static const String getUser = '${mainUrl}get_user.php';
// Arguments:username
}
