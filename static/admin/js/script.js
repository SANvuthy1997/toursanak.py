var editor = new MediumEditor('.editable', {
        toolbar: {
            buttons: ['bold', 'italic', 'underline', 'anchor', 'table','h4','h5','h6','pre','justifyCenter','justifyFull','justifyLeft','justifyRight','orderedlist','unorderedlist','strikethrough'],
        },
        buttonLabels: 'fontawesome',
        extensions: {
            'table': new TableExtension(),
        }
    });

    $(function () {
            $('.editable').mediumInsert({
                editor: editor,
                addons: {
                    images: {
                        uploadScript: null,
                        deleteScript: null,
                        captionPlaceholder: 'Type caption for image',
                        styles: {
                            slideshow: {
                                label: '<span class="fa fa-play"></span>',
                                added: function ($el) {
                                    $el
                                        .data('cycle-center-vert', true)
                                        .cycle({
                                            slides: 'figure'
                                        });
                                },
                                removed: function ($el) {
                                    $el.cycle('destroy');
                                }
                            }
                        },
                        actions: null
                    }
                }
            });
        });
