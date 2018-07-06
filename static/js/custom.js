(function() {
  var url = 'https://webmention.io/api/mentions';
  var $postFooter = $('.post-footer');

  if ($postFooter.length !== 1) {
    return;
  }
  
  var request = $.ajax(url, {
    data: {target: 'https://www.baty.net' + location.pathname}
  });
  
  var getAuthor = function(data) {
    if (!data.author || !data.author.url) {
      return '';
    }
    var author = '<div class="comment-author vcard"><img class="avatar photo u-photo" src="' + data.author.photo + '" alt="' + data.author.name + '">';
    author += '<cite class="fn"><a class="url" rel="external nofollow" href="' + data.author.url + '">' + data.author.name + '</a></cite>';
    
    return author;
  };
  
  request.then(function(json) {
    var links = (json.links  || []);
    
    if (typeof [].map === 'function') {
      links = links.map(function(link) {
        link.date = +new Date(link.verified_date);
      
        return link;
      })
      .sort(function(a, b) {
        return a.date > b.date ? 1 : -1;
      });
    }
    
    var replies = [];
    var mentions = [];
    
    if (!links.length) {
      return;
    }
    
    $.each(links, function(i, link) {
      var data = link.data;
      var mention = '<li class="comment u-comment h-cite">';
      
      if (link.activity.type === 'reply') {
        mention += getAuthor(data);
        mention += '<div class="comment-content">' + data.content + '</div>';
        mention += '</li>';
        
        replies.push(mention);
      } else {
        mention += link.activity.sentence_html;
        mention += '</li>';
        mentions.push(mention);
      }
      
    });
    
    $postFooter.after('<h2>Webmentions</h2><ol class="commentlist">' + mentions.join('') + '</ol>');
    $postFooter.after('<h2>Comments</h2><ol class="mentions-list">' + replies.join('') + '</ol>');
  });
  
  request.catch(function(jqXHR, status) {
    console.log(jqXHR);
    console.log(status);
  });
})();