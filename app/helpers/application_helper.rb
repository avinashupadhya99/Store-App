module ApplicationHelper
  def paginate(collection, params= {})
    will_paginate collection, params.merge(:renderer => RemoteLinkPaginationHelper::BootstrapLinkRenderer)
  end
end