module PagyHelper
  include Pagy::Frontend

  def pagy_nav_els(pagy)
    html, link, p_prev, p_next = +'', pagy_link_proc(pagy), pagy.prev, pagy.next

    html << '<div class="flex">'
    html << (p_prev ? link.call(p_prev, pagy_t('pagy.nav.prev'), 'class="previous_page text-grey-dark" aria-label="Previous Page"')
                    : %(<a class="previous_page text-grey-dark opacity-50 cursor-not-allowed">#{pagy_t('pagy.nav.prev')}</a>))
    pagy.series.each do |item| # series example: [1, :gap, 7, 8, "9", 10, 11, :gap, 36]
      html << if    item.is_a?(Integer); link.call(item, item, 'class="text-grey-dark pl-3"') # page link
      elsif item.is_a?(String) ; %(<span class="current text-els-black selected pl-3" aria-current="true">#{item}</span>) # active page
      elsif item == :gap       ; %(<span class="gap pl-3 text-grey-dark">#{pagy_t('pagy.nav.gap')}</span>) # page gap
              end
    end
    html << (p_next ? link.call(p_next, pagy_t('pagy.nav.next'), 'class="next_page text-grey-dark pl-3" aria-label="Next Page"')
                    : %(<a class="next_page text-grey-dark pl-3 opacity-50 cursor-not-allowed">#{pagy_t('pagy.nav.next')}</a>))
    html << '</div>'
    %(<nav class="pagy" aria-label="Pagination">#{html}</nav>)
  end

  def pagy_nav(pagy)
    html, link, p_prev, p_next = +'', pagy_link_proc(pagy), pagy.prev, pagy.next

    html << '<ul class="pagination justify-content-center">'
    html << (if p_prev
      %(<li class="page-item">
        #{link.call(p_prev, '&laquo;', 'class="previous_page page-link"')}
      </li>)
    else
      %(<li class="page-item disabled">
        <a class="previous_page page-link" aria-disabled="true">&laquo;</a>
      </li>)
    end)
    pagy.series.each do |item| # series example: [1, :gap, 7, 8, "9", 10, 11, :gap, 36]
      html << (if item.is_a?(Integer)
        %(<li class="page-item">#{link.call(item, item, 'class="page-link"')}</li>)
      elsif item.is_a?(String)
        %(<li class="page-item active"><span class="page-link" aria-current="true">#{item}</span>) # active page
      elsif item == :gap
        %(<li class="page-item disabled"><span class="page-link">#{pagy_t('pagy.nav.gap')}</span></li>) # page gap
      end)
    end
    html << (if p_next
      %(<li class="page-item">
        #{link.call(p_next, '&raquo;', 'class="next_page page-link"')}
      </li>)
    else
      %(<li class="page-item disabled">
        <a class="next_page page-link" aria-disabled="true">&raquo;</a>
      </li>)
    end)
    html << '</ul>'
    %(<nav class="pagy" aria-label="Pagination">#{html}</nav>)
  end
end
