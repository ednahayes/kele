require 'httparty'
require 'json'

module Roadmap
    include HTTParty
    
    def get_roadmap(roadmap_id) 
     #my roadmap_id is 37
        response = self.class.get(get_api_url("roadmaps/#{roadmap_id}"), headers: { "authorization" => @auth_token })
        @roadmap = JSON.parse(response.body)
    end
    
    
    def get_checkpoint(checkpoint_id)
        #try checkpoint_id 2210
        response = self.class.get(get_api_url("checkpoints/#{checkpoint_id}"), headers: { "authorization" => @auth_token })
        @checkpoint = JSON.parse(response.body)
    end   
        
    def get_api_url(endpoint)
        "https://www.bloc.io/api/v1/#{endpoint}"
    end        
end