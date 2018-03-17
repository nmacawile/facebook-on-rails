$(document).on "turbolinks:load", ->
	jQuery ->
	  if $('#infinite-scrolling').size() > 0
	    $(window).on 'scroll', ->
	      more_posts_url = $('.pagination .next_page a').attr('href')
	      if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
	        $('#infinite-scrolling .pagination').html('<i class="fas fa-spinner fa-spin fa-lg"></i>  Loading posts...')
	        $.getScript more_posts_url
	      return
	    return