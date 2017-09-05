require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
    
    include HTTParty
    include Roadmap
    
    
    def initialize(email, password)
        @email = email
        @password = password
        
        response = self.class.post(get_api_url('sessions'), body: {
            email: email,
            password: password
        })
        
        @auth_token = response["auth_token"]
        raise "Invalid Email or Password. Try Again." if @auth_token.nil?
    end
    
    
    def get_me
        response = self.class.get(get_api_url('users/me'), headers: { "authorization" => @auth_token })
        @user_data = JSON.parse(response.body)  
    end   
    
    def get_mentor_availability(mentor_id)
        response = self.class.get(get_api_url("mentors/#{mentor_id}/student_availability"), headers: { "authorization" => @auth_token })
 
        @mentor_availability = JSON.parse(response.body)
    end
    
    
    def get_messages(page = 'all' )
        if page == 'all'
            response = self.class.get(get_api_url("message_threads"), headers: { "authorization" => @auth_token})
        else
            response = self.class.get(get_api_url("message_threads?page=#{page}"), headers: { "authorization" => @auth_token })
        end
    
        @messages =  JSON.parse(response.body)
        
    end
    
    
    def create_message(sender, recipient_id, token, subject, text)
        response = self.class.get(get_api_url('messages'), headers: { "authorization" => @auth_token },
        query: {
            sender: sender,
            recipient_id: recipient_id,
            token: token,
            subject: subject,
            "stripped-text" => text
        })
        
    end


    
    def get_api_url(endpoint)
        "https://www.bloc.io/api/v1/#{endpoint}"
    end
    

end