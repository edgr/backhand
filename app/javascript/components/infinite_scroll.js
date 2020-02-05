const infiniteScroll = () => {
  const scroll = document.getElementById('infinite-scrolling');
  if (scroll && $('#infinite-scrolling').length > 0) {
    $(window).on('scroll', function() {
      const moreUsersUrl = $('#infinite-scrolling .pagination .next_page').attr('href');
      const scrollTop = $(document).scrollTop();
      const windowHeight = $(window).height();
      const bodyHeight = $(document).height() - windowHeight;
      const scrollPercentage = (scrollTop / bodyHeight);
      if (moreUsersUrl && (scrollPercentage > 0.8)) {
        const loading = document.querySelector('.loading-users').innerText;
        $('#infinite-scrolling .pagination').html(loading);
        $.getScript(moreUsersUrl);
      }
    });
  }
}

export { infiniteScroll };
