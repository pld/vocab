// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
Element.addMethods({
  // If element has text html1 replace with html2 and vice versa
  toggleHTML: function(element, html1, html2) {
    if (!(element = $(element))) return;
    (element.innerHTML == html1) ? element.update(element.innerHTML = html2) : element.update(element.innerHTML = html1)
    return element;
  }
})

displayAlphaHash: function() {
  "hello!";
}