$(document).on "turbolinks:load", ->
	jQuery ->
		$(document).on 'click', '.load-more', ->
			$(this).replaceWith('<div class="btn btn-block btn-default disabled"><i class="fas fa-spinner fa-spin"></i>  Loading...</div>');
		return