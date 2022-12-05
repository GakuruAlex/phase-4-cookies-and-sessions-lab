class SessionController < ApplicationController
    def index
        session[:pages_view] ||= 0
        
    end
end
