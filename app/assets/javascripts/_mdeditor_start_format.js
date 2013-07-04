(function () {
    var converter = new Markdown.Converter()
    var Formatter = function () {
      Markdown.Extra.init(converter, {extensions: ["tables", "fenced_code_gfm", "def_list"], highlighter: "prettify"});
    }

    Formatter.prototype.format = function(scope, target, text) {
      target.html(converter.makeHtml(text));
      scope.find('.prettyprint').each(function(){
        $(this).addClass('linenums');
      });
      prettyPrint();
      scope.find('table').each(function() {
        $(this).addClass('table table-striped table-bordered');
      });
    };

    var fmtter
    var getFormatter = function() {
      if ( !fmtter ) fmtter = new Formatter()
      return fmtter;
    }
    MdeditorRails.start_format = function (scope, target, text) {
      getFormatter().format(scope, target, text)
    }
}())