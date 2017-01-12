module AppBaseEngine
  # AppBaseEngine::Routes.mixin(self)
  class Routes
    def self.mixin mapper
      mapper.extend ::AppBaseEngine::DefaultRoutes
      mapper.send :app_base_routes
    end
  end

  module DefaultRoutes
    def app_base_routes
      # get '/page_404' => 'errors#page_404', as: :page_404
      %w[ bug detect_403 detect_404 detect_422 detect_500 ].each do |page|
        get page => "exceptions##{ page }"
      end

      # AppSubscriptionsController
      post '/app_sbuscribe' => 'app_subscriptions#app_sbuscribe', as: :app_sbuscribe
    end
  end
end
