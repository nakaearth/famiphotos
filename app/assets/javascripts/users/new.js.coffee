$("#user-modal").html("<%= escape_javascript(render 'new_modal') %>")
$("#user-modal").modal("show")
