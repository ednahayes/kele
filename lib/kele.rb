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
        @enrollment_id = @user_data['current_enrollment']['id']
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

    def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment )
        response = self.class.get(get_api_url('checkpoint_submissions'), headers: { "authorization" => @auth_token },
        query: {
            enrollment_id: @enrollment_id,
            checkpoint_id: checkpoint_id,
            assignment_branch: assignment_branch,
            assignment_commit_link: assignment_commit_link,
            comment: comment
        })
        @submission_id = response.body["id"]
    end
    
    
    def update_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
        response = self.class.get(get_api_url('checkpoint_submissions/:id'), headers: { "authorization" => @auth_token },
        query: {
            id: @submission_id,
            enrollment_id: @enrollment_id,
            checkpoint_id: checkpoint_id,
            assignment_branch: assignment_branch,
            assignment_commit_link: assignment_commit_link,
            comment: comment
        })
    end
    
    def get_api_url(endpoint)
        "https://www.bloc.io/api/v1/#{endpoint}"
    end
    

end