class MessagesController < ApplicationController
    def new
        @message = Message.new
    end

    def create
        message = current_user.messages.build(message_params)
        if message.save
            ActionCable.server.broadcast "chatroom_channel", {mod_message: message_render(message)}
        else    
        end
    end

    private

    def message_params
        params.require(:message).permit(:body)
    end

    def message_render(message)
        render(partial: 'message', locals: {message: message})
    end
end
