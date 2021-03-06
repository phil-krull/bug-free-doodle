/*https://www.librarieshacked.org/tutorials/autocompletewithapi*/
var book = function(){

    $("#txtBookSearch").autocomplete({ // attach auto-complete functionality to textbox
        // define source of the data
        source: function (request, response) {
            // url link to google books, including text entered by user (request.term)
            var booksUrl = "https://www.googleapis.com/books/v1/volumes?printType=books&q=" + encodeURIComponent(request.term) + "&key=AIzaSyD7eTMOPEaffOPIIxBH8seD6xOS6Q6_oE0";
            $.ajax({
                url: booksUrl,
                dataType: "jsonp",
                success: function(data) {
                    response($.map(data.items, function (item) {
                        if (item.volumeInfo.authors && item.volumeInfo.title && item.volumeInfo.industryIdentifiers && item.volumeInfo.publishedDate)
                        {
                            return {
                                // label value will be shown in the suggestions
                                label: item.volumeInfo.title + ', ' + item.volumeInfo.authors[0] + ', ' + item.volumeInfo.publishedDate,
                                // value is what gets put in the textbox once an item selected
                                value: item.volumeInfo.title,
                                // other individual values to use later
                                title: item.volumeInfo.title,
                                author: item.volumeInfo.authors[0],
                                isbn: item.volumeInfo.industryIdentifiers,
                                publishedDate: item.volumeInfo.publishedDate,
                                image: (item.volumeInfo.imageLinks == null ? "" : item.volumeInfo.imageLinks.thumbnail),
                                description: item.volumeInfo.description,
                            };
                        }
                    }));
                }
            });
        },
        select: function (event, ui) {
            // what to do when an item is selected
            // first clear anything that may already be in the description
            // $('#divDescription').empty();
            // we get the currently selected item using ui.item
            // show a pic if we have one
                // , function(data) {
                // if (data == true){
                //     $('#divDescription').append('<p>Good news, you already own this book</p>');
                // } else {
                //     $('#divDescription').append('<button type="submit" class="btn btn-primary btn-sm">Add book to bookshelf</button>');
                // }
            // }
            // })
            if (ui.item.image != '')
            {
                $('#divDescription').append('<img src="' + ui.item.image + '" style="float: left; padding: 10px;">');
                  $('#book_image').val(ui.item.image)
            }
            // and title, author, and year
            $('#divDescription').append('<p><b>Title:</b> ' + ui.item.title  + '</p>');
              $('#book_title').val(ui.item.title)
            $('#divDescription').append('<p><b>Author:</b> ' + ui.item.author  + '</p>');
              $('#book_author').val(ui.item.author)
            $('#divDescription').append('<p><b>First published year:</b> ' + ui.item.publishedDate  + '</p>');
              $('#book_year').val(ui.item.publishedDate)
            // and the usual description of the book
            $('#divDescription').append('<p><b>Description:</b> ' + ui.item.description  + '</p>');
                $('#book_description').val(ui.item.description)
            // and show the link to oclc (if we have an isbn number)
            if (ui.item.isbn && ui.item.isbn[0].identifier)
            {
                $('#divDescription').append('<P><b>ISBN:</b> ' + ui.item.isbn[0].identifier + '</p>');
                $('#divDescription').append('<p><a href="http://www.worldcat.org/isbn/' + ui.item.isbn[0].identifier + '" target="_blank">View item on worldcat</a></p>');
                $('#divDescription').append('<p><a href="http://www.amazon.com/gp/search?field-isbn=' + ui.item.isbn[0].identifier + '">View item on Amazon</a></p>');
                  $('#book_isbn').val(ui.item.isbn[0].identifier)
            }
            var booktitle = $('#book_info').serialize()
            $.post('/bookshelfs/book', booktitle, function(result){
                console.log(result)

                if (result == 'false') {
                    $('#divDescription').append('<button type="submit" class="btn btn-primary btn-sm">Add book to bookshelf</button>');
                }
                if (result == 'true') {
                    $('#divDescription').append('<p id="red">Good news, you already own this book</p>');
                }
            });
        },
        minLength: 2 // set minimum length of text the user must enter
    });
/*I used the below to see the the item object*/
// $('#divDescription').append(JSON.stringify(ui.item));
};
$(document).on('page:load', book)
$(document).ready(book)