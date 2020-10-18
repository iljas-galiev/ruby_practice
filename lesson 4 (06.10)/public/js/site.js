$(document).ready(function () {
    $('.todo-link').click(function (e) {
        e.preventDefault();
        var dataURL = $(this).data('href');
        $.ajax({
            method: 'GET',
            url: dataURL,
            success: function (data) {
                $('.modal-content').html(data)
                $('.modal').modal('show')
            }
        })
    });
    $('.todo-delete').click(function (e) {
        e.preventDefault();
        if(!confirm("Are u sure?")) return false;
        var dataURL = $(this).data('href');
        var el = $(this);
        $.ajax({
            method: 'DELETE',
            url: dataURL,
            success: function () {
                el.parents('.todo-item').remove()
            }
        })
    });

});