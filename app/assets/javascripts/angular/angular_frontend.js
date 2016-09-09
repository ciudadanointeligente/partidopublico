function scroll_to_top() {
    $('html, body').animate({
        scrollTop: $('#container').offset().top
    }, 500);
}
