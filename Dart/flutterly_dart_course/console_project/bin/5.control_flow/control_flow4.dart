//! assert statement
// it is used to disrupt the normal flow of a running app
// if the boolean condition inside it is false
//! assert statements are only used in debug mode.
//! when running in production mode, all assert statements are removed
// used only for debugging during development

void main(List<String> args) {

  var list = [];
  assert(list.isNotEmpty, 'List must not be empty!'); // if condition is false, an exception is thrown

}
