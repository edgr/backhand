const scroll = () => {
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
}

const infiniteScroll = () => {
  const nextPage = document.querySelector('.pagination');
  if (nextPage) {
    window.addEventListener('scroll', scroll)
  }
}

export { infiniteScroll };
