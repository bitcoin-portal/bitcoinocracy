module Admin
  class ArgumentsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # simply overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Argument.all.paginate(10, params[:page])
    # end

    # Define a custom finder by overriding the `find_resource` method:
    def find_resource(param)
      Argument.friendly.find(param)
    end

    def hide
      argument.hide! if argument.visible?
      redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to admin_argument_url(argument)
    end

    def unhide
      argument.unhide! if argument.hidden?
      redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to admin_argument_url(argument)
    end
    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information

    private
      def argument
        Argument.friendly.find(params[:slug] || params[:id])
      end
  end
end
