require 'kele'

describe Kele do
    
  it 'initializes email and password' do
      expect(email).to respond_to(@email)
      expect(password).to respond_to(@password)
  end
  
 
  describe '#get_api_url' do
     it 'gets response from bloc api' do
       VCR.use_cassette 'model/api_response' do
          response = get_api_url("https://www.bloc.io/api/v1/#{endpoint}")
          response.first.should = "https://www.bloc.io/api/v1/#{endpoint}"
          expect(response).to have_http_status(:success)
       end
     end
  end
  

end