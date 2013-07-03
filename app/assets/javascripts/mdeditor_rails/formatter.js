(function () {
    var converter = new Markdown.Converter()
    var enki_formatter
    var EnkiFormatter = function () {
      Markdown.Extra.init(converter, {extensions: ["tables", "fenced_code_gfm", "def_list"], highlighter: "prettify"});
    }

    EnkiFormatter.prototype.format = function(scope, target, text) {
      target.html(converter.makeHtml(text));
      scope.find('.prettyprint').each(function(){
        $(this).addClass('linenums');
      });
      prettyPrint();
      scope.find('table').each(function() {
        $(this).addClass('table table-striped table-bordered');
      });
    };

    Markdown.EnkiFormatter = function() {
      if ( !enki_formatter ) {
        enki_formatter = new EnkiFormatter()
      }
      return enki_formatter;
    }

}())