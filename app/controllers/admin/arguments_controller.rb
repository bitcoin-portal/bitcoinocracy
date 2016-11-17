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
      Argument.find_by!(slug: param)
    end

    def hide
      Argument.find_by!(slug: params[:id]).hide!
      redirect_to :back
    end

    def unhide
      Argument.find_by!(slug: params[:id]).unhide!
      redirect_to :back
    end
    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
