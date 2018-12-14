module Admins
  module LastMessages
    extend ActiveSupport::Concern

    included do
      before_action :load_last_messages
    end

    protected

    def load_last_messages
      @messages = Contact.last(3).reverse || []
    end
  end
end
