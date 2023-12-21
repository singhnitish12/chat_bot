class ChatResponsesController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:process_json]
  
    def process_json
      prompt_json = JSON.parse(request.body.read)
      @content = nil
        
        response = OpenAI::Client.new(access_token: ENV["OPENAI_ACCESS_TOKEN"]).chat(
          parameters: {
            model: "gpt-3.5-turbo",
            messages: [
              { role: "user", content: prompt_json["prompt"] },
            ],
          }
        )
  
        @content = response.dig("choices", 0, "message", "content")
  
      if @content.nil? || @content.empty?
        render json: { status: "error", message: "No content from OpenAI API" }, status: 404
        return
      end
      
      render json: { status: "success", message: @content }
    end
  end
  