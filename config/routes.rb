Rails.application.routes.draw do
  # the index page gets three routes:
  root 'welcome#index'

  get 'index' => 'welcome#index'
  # "get" routes for when we initially come to the page
  # (whether typing in manually, or coming to as the root)
  post 'index' => 'welcome#index'  
  # a "post route for when we come to the page"
  # after submitting the form

  # hey, while we're here, wanna change the 'test' route?
  get 'test' => 'welcome#test'

  get ':anything' => 'welcome#index'

end
