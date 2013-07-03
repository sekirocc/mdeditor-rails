new function($) {
  $.fn.autogrow = function(callback) {
   $(this).each(function() {
      var t = $(this), origHeight = t.height();
      t.css("lineHeight");
      var tempDiv = $("<div></div>").css({position: "absolute",top: -1e4,left: -1e4,width: $(this).width(),fontSize: t.css("fontSize"),fontFamily: t.css("fontFamily"),lineHeight: t.css("lineHeight"),resize: "none"}).appendTo(document.body); 
      var setHeight = function() {
          var replacedHtml = this.value.replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/&/g, "&amp;").replace(/\n/g, "<br/>");
          tempDiv.html(replacedHtml);
          $(this).css("height", Math.max(tempDiv.height() + 30, origHeight))
          if (callback) callback()
      };
      $(this).keyup(setHeight).keydown(setHeight)
      setHeight.apply(this)
   })
 }
}(jQuery);

(function () {

    var sanConverter = Markdown.getSanitizingConverter();
    // tell the converter to use Markdown Extra for tables, fenced_code_gfm, def_list
    Markdown.Extra.init(sanConverter, {extensions: ["tables", "fenced_code_gfm", "def_list"], highlighter: "prettify"});
    var mdEditor = new Markdown.Editor(sanConverter, null, { strings: Markdown.local.zh });

    mdEditor.hooks.chain("onPreviewRefresh", function () {
        $('.prettyprint').each(function(){
            $(this).addClass('linenums');
        });
        prettyPrint(); // print code syntax for code snippet if there is.
        $('table').each(function() {
            $(this).addClass('table table-striped table-bordered');
        });
    });
    function popupEditorDialog(title, body, imageClass, placeholder) {
        $('#editorDialog').find('.modal-body input').val("");
        $('#editorDialog').find('.modal-body input').attr("placeholder", placeholder);
        $('#editorDialog').find('#editorDialog-title').text(title);
        $('#editorDialog').find('.modal-body p').text(body);
        $('#editorDialog').find('.modal-body i').removeClass().addClass(imageClass);
        $('#editorDialog').modal({keyboard : true});
    }

    // // Custom insert link dialog
    // mdEditor.hooks.set("insertLinkDialog", function(callback) {
    //     popupEditorDialog('链接', '请输入链接地址', 'icon-link icon-2x', 'http://example.com/ "可选标题"');
    //     editorDialogCallback = callback;
    //     return true; // tell the editor that we'll take care of getting the link url
    // });

    // // Custom insert image dialog
    // var editorDialogCallback = null;
    // mdEditor.hooks.set("insertImageDialog", function(callback) {
    //     popupEditorDialog('图片', '请输入图片地址', 'icon-picture icon-2x', 'http://example.com/images/diagram.jpg "可选标题"');
    //     editorDialogCallback = callback;
    //     return true; // tell the editor that we'll take care of getting the image url
    // });

    $('#editorDialog').on('hidden', function(){
        if (editorDialogCallback) {
            var url = $('#editorDialog-confirm').data('url');
            if (url) {
                $('#editorDialog-confirm').removeData('url');
                editorDialogCallback(url);
            } else {
                editorDialogCallback(null);
            }
        }
    });

    $('#editorDialog-confirm').click(function(event) {
        var url = $('#editorDialog').find('.modal-body input').val();
        if (url) {
            $(this).data('url', url);
        }
        $('#editorDialog').modal('hide');
    });

    $('#editorDialog').on('shown', function(){
        $('#editorDialog').find('.modal-body input').focus();
    });


    // Make preview if it's inactive in 500ms to reduce the calls in onPreviewRefresh chains above and cpu cost.
    documentContent = undefined;
    var previewWrapper;
    previewWrapper = function(makePreview) {
        var debouncedMakePreview = _.debounce(makePreview, 500);
        return function() {
            if(documentContent === undefined) {
                makePreview();
                documentContent = '';
            } else {
                debouncedMakePreview();
            }
        };
    };

    // start editor.
    mdEditor.run(previewWrapper);

    // Load awesome font to button
    $('#wmd-bold-button > span').addClass('icon-bold muted');
    $('#wmd-italic-button > span').addClass('icon-italic muted');
    $('#wmd-link-button > span').addClass('icon-link muted');
    $('#wmd-quote-button > span').addClass('icon-quote-left muted');
    $('#wmd-code-button > span').addClass('icon-code muted');
    $('#wmd-image-button > span').addClass('icon-picture muted');
    $('#wmd-olist-button > span').addClass('icon-list-ol muted');
    $('#wmd-ulist-button > span').addClass('icon-list-ul muted');
    $('#wmd-heading-button > span').addClass('icon-list-alt muted');
    $('#wmd-hr-button > span').addClass('icon-minus muted');
    $('#wmd-undo-button > span').addClass('icon-undo muted');
    $('#wmd-redo-button > span').addClass('icon-repeat muted');

    var SwitchHtml = '<div class="switch switch-small wmd-toggle-preview editing"  \
        data-on-label="预览" data-off-label="编辑" data-on="success" data-off="warning" >  \
            <input type="checkbox" checked />  \
        </div> '
    $(SwitchHtml).css('top', '0px').insertAfter($('#wmd-button-bar'));
    $(SwitchHtml).css('bottom', '0px').insertAfter($('#wmd-button-bar'));

    // change color when hovering.
    $('.wmd-button-row').hover(function() {
        $('.wmd-button span').animate({color: '#2C3E50'}, 400);
    }, function() {
        $('.wmd-button span').animate({color: '#999999'}, 400);
    });
    var buttonBarHeight =  40;

    // toggle preview
    $('.wmd-toggle-preview').on('switch-change', function (e, data) {
        var $el = $(data.el);
        $('.wmd-toggle-preview').bootstrapSwitch('setState', data.value);
        window.setTimeout(function () {
            if ( data.value ) {
                $('#wmd-input').show();
                $('#wmd-button-bar').css('padding-left', '0px');
                $('#wmd-preview').hide();
                $('#wmd-preview').parent().removeClass('wmd-panel-for-preview');
                $('.wmd-wrapper').height($('.wmd-panel-for-input').outerHeight() + buttonBarHeight * 2 )
            } else {
                $('#wmd-preview').show();
                $('#wmd-preview').parent().addClass('wmd-panel-for-preview');
                $('#wmd-input').hide();
                $('#wmd-button-bar').css('padding-left', '10000px');
                $('.wmd-wrapper').height($('.wmd-panel-for-preview').outerHeight()  + buttonBarHeight * 2 )
                
            }    
        }, 100)
    });

    $('#wmd-input').autogrow(function () {
        $('.wmd-wrapper').height($('.wmd-panel-for-input').outerHeight() + buttonBarHeight * 2)
    });

    // enlarge the icon when hovering.
    $('.wmd-button > span').hover(function() {
        $(this).addClass('icon-large');
    }, function() {
        $(this).removeClass('icon-large');
    });
})();
